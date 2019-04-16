# pylint: disable=invalid-name
"""
KiCad Library -  Robot Framework testing library  for validating KiCad
Pcbnew/Eeschema designs.
"""

try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO

import sys
import re
import os

import pcbnew

from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError
from robot.api import logger

# pylint: disable=relative-import
from .kicad_library_utils.schlib import schlib
from .kicad_library_utils.sch import sch

def prettyprint_reference(self):
    """Print module reference (for __str__ et.al.)"""
    return "[{0}]".format(self.GetReference())

def hash_wxpoint(self):
    """Enable hasing of wxPoint data structure"""
    return hash((self.x, self.y))

# pylint: disable=R0201
class KiCadLibrary(object):
    """This is  the KiCadLibrary  for interacting with  and validating
    PCBs made in [http://kicad-pcb.org/|KiCad EDA].

    It also  contains some  limited functionality to  pull information
    from  Eeschema module  library files  (.lib), e.g.  to be  able to
    validate logical pin names vs actual pad nets.

    == Terminology ==
    - _Module_ refers to components having been placed onto the PCB.
    - _Pads_ refers to the pads ("pins") on the modules placed on the PCB.
    - _Pins_ refers to the corresponding pin-out defined in KiCad
      libraries (e.g. `74xx`) for a given module.
    - _Reference_ is the main identity of the component in the design,
      such as `U1`, `R242` or `J_42`.
    - _Value_ is the component type name, such as `74LS04`, `R`,
      `Conn_02x02_Counter_Clockwise` or `GND`.
    - _Pad netname_ is the named net assigned to a specific pin. E.g. `GND`, `a6` et.al.

    == Selecting / finding modules ==
    Generally, all keywords in this library uses regular expressions
    for matching, and take a number of options as argument, namely
    `value`, `reference` and `pad_netname`.

    The results of the individual options are intersected (logical AND).

    Example: To ensure that all resistors in a design are placed on
    an even 50 mil grid, the following keyword invocation could be used:

    | `Module Pads Should Be On Grid` | 50 mil | value=R |

    Example: To ensure that all connectors related to the ISA-bus are
    placed on an even 100 mil boundary, the following keyword could be
    used: (Assuming that the connectors in question have the string
    "ISA" in their component reference, such as `J_ISA_4`)

    | `Module Pads Should Be On Grid` | 100 mil | value=Conn.* | reference=.*ISA.* |

    == Policy on deprecated keywords ==

    == Getting involved ==
    The   source   code   for   this   project   is   hosted  on
    [https://github.com/madworx/robotframework-kicadlibrary/|GitHub].

    Any and all suggestions for improvements can be submitted as
    [https://github.com/madworx/robotframework-kicadlibrary/issues|issues]
    or [https://github.com/madworx/robotframework-kicadlibrary/pulls|pull-requests].
    """

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self, pcb=None, schema=None):
        self.cuts = None
        self.board = None
        self.schemas = {}
        self.components = {}
        self.component_libraries = {}
        self.component_library_search_paths = [".", "/usr/share/kicad/library"]

        if pcb is not None:
            self.load_pcb(pcb)

        if schema is not None:
            self.load_schema(schema)

        # Make pcbnew.MODULE object pretty print their reference.
        pcbnew.MODULE.__str__ = prettyprint_reference
        pcbnew.MODULE.__repr__ = prettyprint_reference

        # Make wxPoint hashable
        pcbnew.wxPoint.__hash__ = hash_wxpoint

        logger.debug("Initialized KiCadLibrary")

    def get_component_definition(self, component_type):
        """
        Return the _component definition_  for a named component given
        as argument. (`<[library:]component_name>`)

        The `component_type` argument is a string, specifying either a
        library name  followed by a  colon (`:`) as well  as component
        name  (`74xx:74LS04`),  or only  a  component  name by  itself
        (`74LS04`).

        If the library name is specified,  we will attempt to load the
        library if it hasn't been loaded yet.

        If  the library  name is  not  specified, we  will search  all
        libraries that have been loaded so far.

        Examples:
        | `${def}=` | `Get Component Definition` | `74xx:74LS04` |
        | `${def}=` | `Get Component Definition` | `74LS04` |
        """
        m_name = re.match(r'^(?:(.+):)?(.+)$', component_type)
        libs = self.component_libraries.values()
        if m_name:
            if m_name.group(1) is not None:
                libs = [self.load_component_library(m_name.group(1))]
            for loaded_lib in libs:
                component = loaded_lib.getComponentByName(m_name.group(2))
                if component is not None:
                    return component
            raise AssertionError("Could not locate component {0} in any "
                                 "of the loaded or named libraries.".
                                 format(component_type))
        raise AssertionError(
            "Invalid format{0}".format(component_type))

    def load_pcb(self, filename):
        """Load a KiCAD / Pcbnew (.kicad_pcb) file."""
        self.board = pcbnew.LoadBoard(self._resolve_filename(filename))
        self.board.BuildListOfNets()

    def _resolve_filename(self, filename, relative_to=None):
        if relative_to is None:
            try:
                relative_to = BuiltIn().get_variable_value("${SUITE SOURCE}")
            except RobotNotRunningError:
                # If we're not running RF, use __file__ instead for resolving
                # relative file names.
                relative_to = __file__
        if os.path.isabs(filename):
            return os.path.abspath(filename)
        return  os.path.join(os.path.dirname(relative_to),
                             filename)

    def load_schema(self, filename, subschema='_root'):
        """Load a KiCAD / Eeschema (.sch) file."""
        logger.debug("Loading eeschema file: [{0}]".
                     format(filename))
        if subschema not in self.schemas:
            old = sys.stderr
            stderr_buf = StringIO()
            sys.stderr = stderr_buf
            self.schemas[subschema] = sch.Schematic(self._resolve_filename(filename))
            sys.stderr = old
            if stderr_buf.getvalue():
                raise AssertionError("{0}: {1}".format(filename, stderr_buf.getvalue()))

        for sheet in self.schemas[subschema].sheets:
            logger.debug("Loading hierarchical subsheet {0} -> {1}".
                         format(sheet.fields[0]['value'], sheet.fields[1]['value']))
            self.load_schema(self._resolve_filename(
                re.sub(r'"', '', sheet.fields[1]['value']),
                self._resolve_filename(filename)),
                             sheet.fields[0]['value'])

    def add_component_library_path(self, paths):
        # pylint: disable=line-too-long
        """Add the  given `path` (or paths) to  the list of paths  being searched
        when using the `Load Component Library` keyword.

        Examples:
        | `Add Component Library Path` | `../kicad_libs/LIB_UM245R` | `../kicad_libs/LIB_AS6C4008-55PCN` |
        | `Add Component Library Path` | `/usr/local/kicad/share/library` |
        | `Suite Setup` | `Add Component Library Path` | `${LIBRARY_MODULE_PATHS}` |
        """
        if isinstance(paths, list):
            for path in paths:
                self.add_component_library_path(path)
        else:
            paths = self._resolve_filename(paths)
            if os.path.exists(paths):
                self.component_library_search_paths.insert(0, paths)
                logger.debug("Prepended [{0}] to component library search path.".
                             format(paths))
            else:
                raise AssertionError(str("Attempted to add [{0}] to component "
                                         "library search path, but that path "
                                         "doesn't exist.").
                                     format(paths))

    def load_component_library(self, library):
        """
        Load library file(s) (.lib) containing component definitions.

        Library can be either a relative path, an absolute path, or
        a name (with or without .lib extension).

        This  keyword is  mainly useful  if you  have not  provided an
        Eeschema file  (`Load Schema`) --  if you are using  the `Load
        Schema`  keyword,  the  required   libraries  will  be  loaded
        automagically.

        Examples:
        | `Load Component Library` | `74xx` | `4xxx` |
        | `Load Component Library` | `../kicad_libs/LIB_UM245R/UM245R.lib` |
        | `Suite Setup` | `Load Component Library` | `74xx` |
        """
        if isinstance(library, list):
            ret = []
            for lib in library:
                ret.append(self.load_component_library(lib))
            return ret

        library = re.sub(r"[.]lib$", "", library)
        libname = os.path.basename(library)
        if libname not in self.component_libraries:
            sp = [os.path.dirname(library)] \
                if os.path.isabs(library) \
                else self.component_library_search_paths
            for search_path in sp:
                candidate = os.path.join(self._resolve_filename(search_path),
                                         "{0}.lib".format(libname))
                if os.path.exists(candidate):
                    logger.debug("Found requested library [{0}] at [{1}].".
                                 format(library, candidate))
                    old = sys.stderr
                    stderr_buf = StringIO()
                    sys.stderr = stderr_buf
                    self.component_libraries[libname] \
                        = schlib.SchLib(os.path.abspath(candidate))
                    sys.stderr = old
                    if stderr_buf.getvalue():
                        raise AssertionError("{0}: {1}".format(library, stderr_buf.getvalue()))
                    return self.component_libraries[libname]
            raise AssertionError("Failed to find component library [{0}.lib]".format(libname))
        return self.component_libraries[libname]

    def find_modules(self, modules=None, value=None,
                     reference=None, pad_netname=None):
        # pylint: disable=line-too-long
        """Return a list of modules matching all search criteria given
        as arguments.

        The results  of all arguments  that are given  are intersected
        (logical AND) before the final set is returned.

        `modules` is a list of modules already extracted by a previous
        run of `Find Modules` or other module-finding keywords.

        `value`  is a  regular expression  matching the  "value" of  a
        given module (typically a reference  to a component type, such
        as `74LS139`)

        `reference` is a regular  expression matching the reference of
        a given module on the PCB, e.g. `J3`, `IC1`, `C125`.

        `pad_netname` is a regular expression matching the net name of
        any of the pads of the component.

        Examples:
        | `${conns}=` | `Find Modules` | `value=Conn_02x20_Odd_Even` |
        | `${j_conns}=` | `Find Modules` | `value=Conn_02x[0-9]{2}_Odd_Even` | `reference=J[0-9]+` |
        | `${address_connectors}=` | `Find Modules` | `value=Conn_02x[0-9]{2}_Odd_Even` | `reference=J[0-9]+` | `pad_netname=a[0-9]+` |
        """

        ret = modules

        if reference is not None:
            ret = self.intersect_modules_by_reference(
                ret,
                self.find_modules_by_reference(reference))

        if value is not None:
            ret = self.intersect_modules_by_reference(
                ret,
                self.find_modules_by_value(value))

        if pad_netname is not None:
            ret = self.intersect_modules_by_reference(
                ret,
                self.find_modules_by_pad_netname(pad_netname))

        return ret

    def get_component_pins_for_module(self, module, pin_names=None):
        """Return a dict of the pins for the given module."""
        # If we  have sheets  loaded, attempt  to pull  full reference
        # from there.
        if self.schemas:
            for sheet_name in self.schemas:
                for comp in self.schemas[sheet_name].components:
                    if '"{0}"'.format(module.GetReference()) == comp.fields[0]['ref']:
                        logger.debug("Found component {0}: {1}".
                                     format(module.GetReference(),
                                            comp.labels['name']))
                        return self._get_pins_for_component(comp.labels['name'],
                                                            pin_names)
            raise AssertionError(str("When looking for definition of component {0} "
                                     "in sheets, we couldn't find it?!".
                                     format(module.GetReference())))

        # If we  haven't loaded  Eeschema scheets, use  the GetValue()
        # method to get  a shortname of the  component without library
        # specifier,  and  attempt to  load  that  component from  the
        # already loaded libraries.
        return self._get_pins_for_component(module.GetValue(), pin_names)

    def _get_pins_for_component(self, component_name, pin_name=None):
        comp = self.get_component_definition(component_name)
        return {p["num"]: p for p in comp.pins
                if pin_name is None
                or re.match(pin_name, p["name"])}

    def find_modules_by_reference(self, regexp):
        """*DEPRECATED!!* Use keyword `Find Modules` instead.

        Returns a list of modules matching given reference ``regexp``
        in _regular expression format_.

        Examples:
        | `${connector}=` | `Find Modules By Reference` | `J3` |
        | `${non_capacitors}=` | `Find Modules By Reference` | `^[^C]` |
        """
        return [m for m in self.board.GetModules()
                if re.match(regexp, m.GetReference())]

    def find_modules_by_value(self, regexp):
        """*DEPRECATED!!* Use keyword `Find Modules` instead.

        Examples:
        | `${connectors}=` | `Find Modules By Value` | `Conn_02x20_Odd_Even` |
        | `${ics}=` | `Find Modules By Value` | `74LS124` |
        """
        return [m for m in self.board.GetModules()
                if re.match(regexp, m.GetValue())]

    def intersect_modules_by_reference(self, list1, list2):
        # pylint: disable=line-too-long
        """Perform a set intersection of the two module lists ``list1``
        and ``list2`` based on the module ``references``. (I.e. returns
        a new list containing only the modules that exist in both lists.
        If either of the two lists are equal to `None`, the other
        argument will be returned.

        *You normally don't need to use this keyword, see documentation
        on module selection.*

        Examples:
        | `${connectors}=`     |  `Find Modules By Value`          | `Conn_02x20_Odd_Even` |
        | `${connectors2}=`    |  `Find Modules By Reference`      | `regexp=^J[0-9]+$` |
        | `${bus_connectors}=` |  `Intersect Modules By Reference` | `${connectors}` | `${connectors2}` |
        """

        if not bool(list1):
            return list2
        if not bool(list2):
            return list1

        list1_ref_set = set(m.GetReference() for m in list1)
        return [m for m in list2 if m.GetReference() in list1_ref_set]

    def complement_modules_by_reference(self, list1, list2):
        # pylint: disable=line-too-long
        """Perform a set complement operation on the two module lists
        ``list1``  and ``list2`` based on the module ``references``.
        (I.e. returns a new list containing only the modules that exist
        in ``list1`` but not in ``list2``)

        Examples:
        | `${connectors}=` | `Find Modules By Value` | `Conn_02x20_Odd_Even` |
        | `${connectors2}=` | `Find Modules By Reference` | `regexp=^J[0-9]+$` |
        | `${non_bus_connectors}=` | `Complement Modules By Reference` | `${connectors}` | `${connectors2}` |
        """

        if not bool(list1):
            return []
        if not bool(list2):
            return list1

        list2_ref_set = set(m.GetReference() for m in list2)
        return [m for m in list1 if m.GetReference() not in list2_ref_set]

    def get_pad_netnames_for_module(self, module):
        """Return  a _dict_  mapping pad  names to  the short  form of
        netnames for the given module.
        """
        return {p.GetPadName(): p.GetShortNetname() for p in module.Pads()}

    def modules_should_have_same_pads_and_netnames(self, modules=None,
                                                   value=None,
                                                   reference=None,
                                                   pad_netname=None):
        """*DEPRECATED!!* This keyword has been renamed to
        `Matching Modules Should Have Same Pads And Netnames`."""
        self.matching_modules_should_have_same_pads_and_netnames(modules,
                                                                 value,
                                                                 reference,
                                                                 pad_netname)

    def matching_modules_should_have_same_pads_and_netnames(self, modules=None,
                                                            value=None,
                                                            reference=None,
                                                            pad_netname=None):
        """Verify  that  all  modules qualifying  any  argument  being
        non-None, have  the same number of  pads, as well as  the same
        net-names for each pad.

        One usage of this is to validate that inter-PCB connectors have
        the same pinouts.

        *This keyword does not validate net names given in the
        schema versus the PCB.*

        Examples:
        | `Matching Modules Should Have Same Pads And Netnames` | `reference=^J[0-9]+$` |
        | `Matching Modules Should Have Same Pads And Netnames` | `value=Conn_02x20_Odd_Even` |
        | `${modules}=` | `Find Modules By Value` | `Conn_02x20_Odd_Even` |
        | `Matching Modules Should Have Same Pads And Netnames` | `modules=${modules}` |
        """
        modlist = self.find_modules(modules, value, reference, pad_netname)
        ret = True
        aggregates = {}
        for mod in modlist:
            for pad in mod.Pads():
                if pad.GetPadName() not in aggregates:
                    aggregates[pad.GetPadName()] = {}
                if pad.GetShortNetname() not in aggregates[pad.GetPadName()]:
                    aggregates[pad.GetPadName()][pad.GetShortNetname()] = 0

                aggregates[pad.GetPadName()][pad.GetShortNetname()] = \
                    aggregates[pad.GetPadName()][pad.GetShortNetname()] + 1

        for mod in modlist:
            # All matching modules should have the same pin-count:
            if mod.GetPadCount() is not len(aggregates.keys()):
                ret = False
                logger.error("Module {0} has unexpected pad count: {1} (should be {2})".
                             format(mod, mod.GetPadCount(), len(aggregates.keys())))

            for pad in mod.Pads():
                voted = max(aggregates[pad.GetPadName()], key=aggregates[pad.GetPadName()].get)
                if pad.GetShortNetname() != voted:
                    ret = False
                    logger.error("Module {0} pad {1} is net {2} (should be {3})".
                                 format(mod, pad.GetPadName(),
                                        pad.GetShortNetname(), voted))
                else:
                    logger.debug("Module {0} pad {1} is net {2} - ok)".
                                 format(mod, pad.GetPadName(),
                                        pad.GetShortNetname()))

        logger.info("Ran validation on {0} modules. Returning {1}".
                    format(len(modlist), ret))

        if not ret:
            raise AssertionError("Some modules don't have matching pad- and net-names.")

    def find_modules_by_pad_netname(self, regexp):
        """*DEPRECATED!!* Use keyword `Find Modules` instead.

        Return a list of modules that have pads with netnames matching
        ``regexp``.

        Examples:
        | `${memory_ics}=` | `Find Modules By Pad Netname` | `ace[0-9]` |
        """
        ret = []
        for mod in self.board.GetModules():
            for pad in mod.Pads():
                if re.match(regexp, pad.GetNet().GetShortNetname()):
                    ret.append(mod)
        return ret

    # pylint: disable=too-many-arguments,line-too-long
    def modules_should_have_values_matching(self, matching, modules=None,
                                            value=None, reference=None,
                                            pad_netname=None):
        """Validate that the selected modules have values matching the
        regular expression given in `matching`.

        This can be used, for example, to validate that all resistors
        have been given a value which looks like an actual ohm value.

        Examples:
        | `Modules Should Have Values Matching` | `[0-9]+(.[0-9]+)? *([kM])?$` | `reference=R[0-9]+` |
        | `Modules Should Have Values Matching` | `[0-9]+(.[0-9]+)? *[munp]?F$` | `reference=C[0-9]+` |
        """
        modlist = self.find_modules(modules, value, reference, pad_netname)
        ret = True
        for mod in modlist:
            if not re.match(matching, mod.GetValue()):
                logger.error("Module {0} has invalid value [{1}]."
                             .format(mod, mod.GetValue()))
                ret = False
        if not ret:
            raise AssertionError("Modules with incorrect values detected.")

    # pylint: disable=too-many-arguments
    def modules_should_have_orientation(self, orientation, modules=None,
                                        value=None, reference=None,
                                        pad_netname=None):
        """Validate that the modules in `modlist` have the given `orientation`
        (specified in degrees)

        Examples:
        | `${connectors}=` | `Find Modules By Value` | `Conn_02x20_Odd_Even` |
        | `Modules Should Have Orientation` | `${connectors}` | `90` |
        """
        ret = True
        modlist = self.find_modules(modules, value, reference, pad_netname)
        for mod in modlist:
            mod_orient = float(mod.GetOrientation()) / 10.0
            if mod_orient != float(orientation):
                logger.error("Orientation of module %s is %s, should be %s."
                             % (mod, mod_orient, orientation))
                ret = False
            else:
                logger.info("Orientation of module {0} is {1}".
                            format(mod, mod_orient))
        if not ret:
            raise AssertionError("Module orientation(s) are wrong")

    def _get_all_edge_cuts(self):
        """Return a dict of all edge cuts"""
        if self.cuts is None:
            self.cuts = {}
            for segment in self.board.GetDrawings():
                if pcbnew.DRAWSEGMENT_ClassOf(segment) and \
                   self.board.GetLayerName(segment.GetLayer()) == 'Edge.Cuts':
                    self.cuts[segment.GetStart()] = segment.GetEnd()
                    self.cuts[segment.GetEnd()] = segment.GetStart()
        return self.cuts

    # pylint: disable=too-many-arguments
    def module_pads_should_be_on_grid(self, grid, modules=None, value=None,
                                      reference=None, pad_netname=None):
        """Validate that the modules matching the given arguments (`value`,
        `reference`,`pad_netname`) list have their pads on the given ``grid``.

        ``grid``  can  be  given  either  as  an  integer/float  value
        (``1.2700``), where this keyword will  assume that it is given
        in millimeters, or having the unit specified, either ``mm`` or
        ``mil``.

        Examples:
        | `Module Pads Should Be On Grid` | `1.2700` | `value=Conn_02x20_Odd_Even` |
        | `${connectors}=` | `Find Modules By Value` | `Conn_02x20_Odd_Even` |
        | `Module Pads Should Be On Grid` | `50 mil` | `modules=${connectors}` |
        | `Module Pads Should Be On Grid` | `1.27 mm` | `modules=${connectors}` |
        """
        ret = True
        modules = self.find_modules(modules, value, reference, pad_netname)
        grid = self._parse_dimension_string(grid)
        for mod in modules:
            if not (float(mod.FindPadByName("1").GetPosition().x/grid).is_integer() and
                    float(mod.FindPadByName("1").GetPosition().y/grid).is_integer()):
                logger.error("Module {0} doesn't have Pad #1 on grid boundary.".
                             format(mod))
                ret = False
            else:
                logger.debug("Module {0} has its first pad on the grid boundary.".
                             format(mod))
        if not ret:
            raise AssertionError("Modules not on grid detected.")

    def edge_cuts_should_be_on_grid(self, grid):
        """Validate that all _Edge Cuts_ are on the given `grid`.

         Examples:
        | `Edge Cuts Should Be On Grid` | `50 mil` |
        | `Edge Cuts Should Be On Grid` | `1.2700` |
        | `Edge Cuts Should Be On Grid` | `1.27 mm` |
        """
        ret = True
        grid = self._parse_dimension_string(grid)
        cuts = self._get_all_edge_cuts()
        for cut in cuts:
            if not (float(cut.x/grid).is_integer() and
                    float(cut.y/grid).is_integer() and
                    float(cuts[cut].x/grid).is_integer() and
                    float(cuts[cut].y/grid).is_integer()):
                logger.error(str(("{0: >10};{1: >10}; -- {2: >10};{3: >10}; ",
                                  "{4: >10};{5: >10}; -- {6: >10};{7: >10}; ")).
                             format(cut.x, cut.y, cuts[cut].x, cuts[cut].y,
                                    cut.x/grid, cut.y/grid,
                                    cuts[cut].x/grid, cuts[cut].y/grid))
                ret = False
        if not ret:
            raise AssertionError("Edge cuts not on grid detected.")

    def _parse_dimension_string(self, string):
        m_match = re.search(r"^([0-9]+[0-9.].?[0-9]*)\s*(mil|mm)\s*$", string)
        if not m_match:
            value = float(string) * 1e6
        elif m_match.group(2) == "mm":
            value = float(m_match.group(1)) * 1e6
        elif m_match.group(2) == "mil":
            value = self._miltomm(m_match.group(1)) * 1e6
        return value

    def _miltomm(self, mil):
        mil = float(mil)
        millimeter = mil * 25.4/1000.0
        return millimeter
