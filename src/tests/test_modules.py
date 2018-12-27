# pylint: disable=global-statement,redefined-outer-name,missing-docstring,invalid-name

import os
import pytest
import mock

from KiCadLibrary import KiCadLibrary

lib = None
test_dir = os.path.abspath(os.path.splitext(__file__)[0])

def setup_function():
    global lib, test_dir
    lib = KiCadLibrary()
    lib.load_pcb(test_dir+'/test_modules.kicad_pcb')

def test_get_module_pins_without_schema_should_not_work():
    with pytest.raises(AssertionError, match=r'Could not locate component'):
        lib.get_component_pins_for_module(lib.find_modules(reference="U1")[0], "foobar")

def test_get_valid_module_pins_with_loaded_library_should_work():
    lib.load_component_library('Timer')
    pins = lib.get_component_pins_for_module(lib.find_modules(reference="U1")[0])
    assert bool(pins)

def test_module_intersection():
    list1 = lib.find_modules(reference="U1")
    list2 = lib.find_modules(reference="nonexistent")
    assert lib.intersect_modules_by_reference(list1, list2) == list1
    assert lib.intersect_modules_by_reference(list2, list1) == list1
    assert lib.intersect_modules_by_reference(list1, list1) == list1

def test_module_complement():
    list1 = lib.find_modules(reference="U.+")
    list2 = lib.find_modules(reference="nonexistent")
    list3 = lib.find_modules(reference="U3")
    assert len(list1) == 3
    assert bool(list2) is False
    assert len(list3) == 1
    assert lib.complement_modules_by_reference(list1, list2) == list1
    assert lib.complement_modules_by_reference(list2, list1) == []
    assert lib.complement_modules_by_reference(list1, list1) == []
    c = lib.complement_modules_by_reference(list1, list3)
    assert len(c) == 2
    assert ((c[0].GetReference() == 'U2' and c[1].GetReference() == 'U1')
            or (c[0].GetReference() == 'U1' and c[1].GetReference() == 'U2'))

def test_module_pads_should_have_same_netnames_should_fail():
    with pytest.raises(AssertionError, match=r'have matching pad'):
        lib.matching_modules_should_have_same_pads_and_netnames(reference=r'U.*')

def test_module_pads_should_have_same_netnames_should_work():
    lib.matching_modules_should_have_same_pads_and_netnames(value='LM555')
    lib.modules_should_have_same_pads_and_netnames(value='LM555')

def test_find_modules_by_netname():
    l = lib.find_modules(pad_netname='CV')
    assert len(l) == 2

def test_edge_cuts_grid_should_fail():
    with pytest.raises(AssertionError, match=r'not on grid'):
        lib.edge_cuts_should_be_on_grid("1.99mil")

def test_edge_cuts_grid_should_work():
    lib.edge_cuts_should_be_on_grid("50mil")

def test_module_pads_should_be_on_grid_should_fail():
    with pytest.raises(AssertionError, match=r'not on grid'):
        lib.module_pads_should_be_on_grid("50mil", reference=r'.*')

def test_module_pads_should_be_on_grid_should_work():
    lib.module_pads_should_be_on_grid("25mil", reference=r'.*')

def test_modules_should_have_orientation_should_fail():
    with pytest.raises(AssertionError, match=r'Module orientation\(s\) are wrong'):
        lib.modules_should_have_orientation(180, reference=r'[^R].*')

def test_modules_should_have_orientation_should_work():
    lib.modules_should_have_orientation(0, value='LM555')
    lib.modules_should_have_orientation(90, reference=r'U3')

def test_internal_error_get_component_pins_for_module():
    lib.load_schema(test_dir+'/test_modules.sch')
    module = lib.find_modules(reference=r'U1')[0]
    module.GetReference = mock.MagicMock(return_value="error")
    with pytest.raises(AssertionError, match=r"we couldn't find it\?!"):
        lib.get_component_pins_for_module(module)

def test_modules_should_have_matching_values_should_work():
    lib.modules_should_have_values_matching(r'[0-9]+(.[0-9]+)? *([kM])?$',
                                            reference=r'R[1-3]+')
    with pytest.raises(AssertionError, match=r'incorrect values detected'):
        lib.modules_should_have_values_matching(r'[0-9]+(.[0-9]+)? *([kM])?$',
                                                reference=r'R4$')
