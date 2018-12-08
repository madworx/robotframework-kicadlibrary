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

def test_get_known_comp_def_should_work():
    """Loading a  well-known library, and then  subsequently loading a
    well-known component should return the correct value."""
    lib.load_component_library("74xx")
    comp_def = lib.get_component_definition("74LS04")
    pindef = comp_def.getPinByNumber(14)
    assert pindef['name'] == 'VCC'

def test_adding_component_library_path_that_doesnt_exist_should_fail():
    with pytest.raises(AssertionError, match=r'Attempted to add'):
        lib.add_component_library_path('/non-existent')

def test_adding_component_library_path_that_exist_should_work():
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
    test_dir, _ = os.path.splitext(__file__)
    with pytest.raises(AssertionError, match=r'.*DCM file.+does not exist'):
        lib.load_component_library(test_dir+'/missing_dcm.lib')

def test_load_invalid_component_lib_should_fail():
    test_dir, _ = os.path.splitext(__file__)
    with pytest.raises(AssertionError, match='not a KiCad Schematic Library File'):
        lib.load_component_library(test_dir+'/invalid.lib')
