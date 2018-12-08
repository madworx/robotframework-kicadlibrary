# pylint: disable=global-statement,unused-argument,redefined-outer-name,missing-docstring,invalid-name

"""Test cases for basic loading and usage of the KiCadLibrary"""

import pytest

from KiCadLibrary import KiCadLibrary

lib = None

def setup_function(function):
    global lib
    lib = KiCadLibrary()

def test_loading_wout_arg_should_work():
    """Loading the  KiCadLibrary without passing any  arguments should
    work"""
    KiCadLibrary()

def test_load_missing_pcbnew_should_fail():
    """Attempting  to load  a Pcbnew  file that  doesn't exist  should
    fail."""
    with pytest.raises(IOError, match=r'Unable to open '):
        lib.load_pcb('/non-existant.adfkjdsaflkj')

def test_load_invalid_pcbnew_should_fail():
    with pytest.raises(IOError, match=r'Unknown file type'):
        lib.load_pcb('/dev/null')

def test_load_missing_eeschema_should_fail():
    """Attempting to load  an Eeschema file that  doesn't exist should
    fail."""
    with pytest.raises(IOError, match=r'No such file'):
        lib.load_schema('/non-existant.adfkjdsaflkj')

def test_load_invalid_eeschema_should_fail():
    with pytest.raises(AssertionError, match=r'not a KiCad Schematic File'):
        lib.load_schema('/dev/null')
