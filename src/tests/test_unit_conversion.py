# pylint: disable=global-statement,unused-argument,redefined-outer-name,missing-docstring,invalid-name,protected-access

import pytest

from KiCadLibrary import KiCadLibrary

lib = None

def setup_function(function):
    global lib
    lib = KiCadLibrary()

def test_parse_dimstr():
    """Valid dimension defintions should work, and return the expected
    results."""
    assert int(lib._parse_dimension_string('50mil')) == 1.27e6
    assert int(lib._parse_dimension_string('50 mil')) == 1.27e6
    assert int(lib._parse_dimension_string('3.14mm')) == 3.14e6
    assert int(lib._parse_dimension_string('3.14 mm')) == 3.14e6
    assert int(lib._parse_dimension_string('3.14')) == 3.14e6

def test_parse_invalid_dimstr_should_fail():
    """Invalid dimension defintions should fail"""
    with pytest.raises(ValueError, match=r'could not convert string to float'):
        lib._parse_dimension_string('asdfslkjsafds')
    with pytest.raises(ValueError, match=r'could not convert string to float'):
        lib._parse_dimension_string('')
    with pytest.raises(ValueError, match=r'invalid literal for float'):
        lib._parse_dimension_string('2.45 feet')
    with pytest.raises(ValueError, match=r'invalid literal for float'):
        lib._parse_dimension_string('1,27')
    with pytest.raises(ValueError, match=r'invalid literal for float'):
        lib._parse_dimension_string('1,27 mil')
