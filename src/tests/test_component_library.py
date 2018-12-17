# pylint: disable=global-statement,unused-argument,redefined-outer-name,missing-docstring,invalid-name

import os
import pytest

from KiCadLibrary import KiCadLibrary

lib = None

def setup_function(function):
    global lib
    lib = KiCadLibrary()

def test_get_comp_def_should_fail():
    """Attempting  to get  the component  definition of  a fictitious
    component should throw an exception"""
    with pytest.raises(AssertionError, match=r'Could not locate component'):
        lib.get_component_definition("fictitious")

def test_loading_the_same_library_twice_should_return_same():
    """Ensure that when  attempting to load the  same library multiple
    times, we only actually load it once."""
    a = lib.load_component_library('74xx')
    b = lib.load_component_library('74xx')
    assert id(a) == id(b)

def test_get_wellknown_comp_def_should_work(libs=None):
    """Loading a  well-known library, and then  subsequently loading a
    well-known component should return the correct value."""
    if libs is None:
        libs = "74xx"
    lib.load_component_library(libs)
    comp_def = lib.get_component_definition("74LS04")
    pindef = comp_def.getPinByNumber(14)
    assert pindef['name'] == 'VCC'

def test_get_wellknown_comp_lists_should_work():
    """Loading  a  list of  supported  libraries  should result  in  a
    valid component definition."""
    test_get_wellknown_comp_def_should_work(['4xxx', '74xx'])

def test_request_for_invalid_component_should_fail():
    """Attempting to get empty component definition should fail"""
    with pytest.raises(AssertionError, match=r'Invalid format'):
        lib.get_component_definition('')

def test_request_for_invalid_component_should_fail2():
    """Attempting to get component using only library name should fail
    (`74xx:`)"""
    with pytest.raises(AssertionError, match=r'Could not locate component'):
        lib.get_component_definition('74xx:')

def test_adding_component_library_path_that_doesnt_exist_should_fail():
    """Attempting to add a component  library search path that doesn't
    exist should fail"""
    with pytest.raises(AssertionError, match=r'Attempted to add'):
        lib.add_component_library_path('/non-existent')

def test_adding_component_library_path_that_exist_should_work():
    """Adding a component library search  path that exists should work
    (regardless if there are libraries in that actualy directory)"""
    lib.add_component_library_path('/tmp')

def test_adding_component_library_paths_that_exist_should_work():
    lib.add_component_library_path(['/tmp'])

def test_adding_component_library_paths_that_doesnt_exist_should_fail1():
    with pytest.raises(AssertionError, match=r'Attempted to add'):
        lib.add_component_library_path(['/tmp', '/non-existent'])

def test_adding_component_library_paths_that_doesnt_exist_should_fail2():
    with pytest.raises(AssertionError, match=r'Attempted to add'):
        lib.add_component_library_path(['/non-existent', '/tmp'])

def test_load_missing_component_lib_should_fail():
    with pytest.raises(AssertionError, match=r'Failed to find'):
        lib.load_component_library('/non-existant.adfkjdsaflkj')

def test_load_missingdcm_component_lib_should_fail():
    test_dir = os.path.abspath(os.path.splitext(__file__)[0])
    with pytest.raises(AssertionError, match=r'.*DCM file.+does not exist'):
        lib.load_component_library(test_dir+'/missing_dcm.lib')

def test_load_invalid_component_lib_should_fail():
    test_dir = os.path.abspath(os.path.splitext(__file__)[0])
    with pytest.raises(AssertionError, match='not a KiCad Schematic Library File'):
        lib.load_component_library(test_dir+'/invalid.lib')
