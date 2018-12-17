# pylint: disable=global-statement,unused-argument,redefined-outer-name,missing-docstring,invalid-name

from robot import run_cli

def test_run_integration_tests():
    return run_cli(['examples/'], False)
