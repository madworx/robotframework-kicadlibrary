"""Setup file for Python"""

import sys
import os

from setuptools import setup, find_packages

from src.robotdoc.libdocpkg import setup_command

needs_pytest = {'pytest', 'test', 'ptr'}.intersection(sys.argv)
pytest_runner = ['pytest-runner','pytest<5'] if needs_pytest else []

setup(name='robotframework-kicadlibrary',
      version_format='{tag}.dev{commitcount}+{gitsha}',
      description='Robot Framework KiCAD library',
      long_description=open('README.md').read(),
      long_description_content_type='text/markdown',
      url='https://github.com/madworx/robotframework-kicadlibrary',
      author='Martin Kjellstrand',
      author_email='martin.kjellstrand@madworx.se',
      license='GPL',
      packages=['KiCadLibrary',
                'KiCadLibrary.kicad_library_utils',
                'KiCadLibrary.kicad_library_utils.sch',
                'KiCadLibrary.kicad_library_utils.schlib'],
      package_dir={'': 'src'},
      install_requires=['robotframework<=3'],
      setup_requires=['setuptools-git-version','robotframework<=3'] + pytest_runner,
      tests_require=['pytest-runner','pytest<5', 'pytest-cov', 'pytest-mock',
                     'pylint<2.0.0', 'pytest-pylint', 'coverage', 'pytest-html',
                     'setuptools-git-version','robotframework<=3'],
      test_suite='tests',
      cmdclass     = {'build_rf_docs': setup_command.BuildLibDoc},
      zip_safe     = True
)
