# pylint: disable=global-statement,redefined-outer-name
# pylint: disable=missing-docstring,invalid-name
import os

from KiCadLibrary import KiCadLibrary

lib = None


def setup_function():
    global lib
    test_dir = os.path.abspath(os.path.splitext(__file__)[0])
    lib = KiCadLibrary()
    lib.load_pcb(test_dir + '/test.kicad_pcb')
    lib.load_schema(test_dir + '/test.sch')


def test_assert_num_components():
    # We expect the design to have exactly 12 components.
    assert len(lib.find_modules(reference='.*')) == 12


# pylint: disable=protected-access
def test_get_list_of_unconnected():
    data = lib._return_unconnected_pins()

    # Number of checked components should match number
    # of modules in total.
    assert len(lib.find_modules(reference='.*')) == \
        data['stats']['checked_components']

    # Each component should be missing a connection
    # on Pin 1, and Pin 1 alone.
    for c in data['data']:
        assert len(data['data'][c]) == 1
        assert data['data'][c][0] == 1
