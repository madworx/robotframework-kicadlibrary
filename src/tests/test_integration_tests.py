# pylint: disable=global-statement,unused-argument,redefined-outer-name,missing-docstring,invalid-name

from robot import run_cli

def test_run_integration_tests():
    if run_cli(['-F', 'robot',
                '-o', 'NONE',
                '-l', 'NONE',
                '-r', 'NONE',
                'examples/'], False) is not 0:
        raise AssertionError("Integration tests didn't return True.")
