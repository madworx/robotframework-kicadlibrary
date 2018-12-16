"""Setup file for Python"""

import sys
import os

from setuptools import setup, find_packages

from src.robotdoc.libdocpkg import setup_command

needs_pytest = {'pytest', 'test', 'ptr'}.intersection(sys.argv)
pytest_runner = ['pytest-runner','pytest<5'] if needs_pytest else []

if "--get-version" in sys.argv:
    from setuptools_scm import get_version
    print get_version(root='.', relative_to=__file__)
    sys.exit(0)

setup(name='robotframework-kicadlibrary',
      description='Robot Framework KiCAD library',
      long_description=open('README.md').read(),
      long_description_content_type='text/markdown',
      #version=,
      use_scm_version=True,
      url='https://github.com/madworx/robotframework-kicadlibrary',
      author='Martin Kjellstrand',
      author_email='martin.kjellstrand@madworx.se',
      license='MIT',
      packages=['KiCadLibrary',
                'KiCadLibrary.kicad_library_utils',
                'KiCadLibrary.kicad_library_utils.sch',
                'KiCadLibrary.kicad_library_utils.schlib'],
      package_dir={'': 'src'},
      install_requires=['robotframework<4'],
      setup_requires=['setuptools_scm', 'robotframework<4'] + pytest_runner,
      tests_require=['pytest-runner', 'pytest<5', 'pytest-cov', 'pytest-mock',
                     'pylint<2.0.0', 'pytest-pylint', 'coverage', 'pytest-html',
                     'setuptools_scm', 'robotframework<4'],
      test_suite='tests',
      cmdclass = {'build_rf_docs': setup_command.BuildLibDoc},
      zip_safe = True,
      classifiers=[
          'Development Status :: 4 - Beta',
          'Environment :: Console',
          'Framework :: Robot Framework :: Library',
          'Intended Audience :: Developers',
          'Intended Audience :: End Users/Desktop',
          'Intended Audience :: Information Technology',
          'Intended Audience :: Manufacturing',
          'License :: OSI Approved :: MIT License',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Microsoft :: Windows',
          'Operating System :: POSIX',
          'Programming Language :: Python',
          'Topic :: Scientific/Engineering :: Electronic Design Automation (EDA)',
          'Topic :: Software Development :: Testing :: Acceptance'
          ]
)
