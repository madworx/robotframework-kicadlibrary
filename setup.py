"""Setup file for Python"""

import sys

from setuptools import setup, find_packages

needs_pytest = {'pytest', 'test', 'ptr'}.intersection(sys.argv)
pytest_runner = ['pytest-runner','pytest<5'] if needs_pytest else []

setup(name='robotframework-kicadlibrary',
      version_format='{tag}.dev{commitcount}+{gitsha}',
      description='Robot Framework KiCAD library',
      url='https://github.com/madworx/robotframework-kicadlibrary',
      author='Martin Kjellstrand',
      author_email='martin.kjellstrand@madworx.se',
      license='GPL',
      packages=find_packages('./src'),
      package_dir={'': 'src'},
      install_requires=['robotframework<=3.0.4'],
      setup_requires=['setuptools-git-version'] + pytest_runner,
      tests_require=['pytest-runner','pytest<5', 'pytest-cov', 'pytest-mock',
                     'pylint<2.0.0', 'pytest-pylint', 'coverage', 'pytest-html',
                     'setuptools-git-version'],
      test_suite='tests'
)
