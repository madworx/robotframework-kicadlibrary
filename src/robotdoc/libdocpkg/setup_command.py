# pylint: disable=missing-docstring

import sys
import os.path
from distutils.cmd import Command

class BuildLibDoc(Command):
    description = 'Build Robotframework library documentation'
    user_options = [
        ('libraries=', 'L', 'Library names'),
        ('output-dir=', 'o', 'Output directory'),
    ]

    # assume the first part of the package is the library name
    def _guess_library_names(self):
        library_names = list()
        for package in self.distribution.packages:
            name = package.split('.')[0]
            if name not in library_names:
                library_names.append(name)
        return library_names

    def initialize_options(self):
        self.libraries = self._guess_library_names()
        self.output_dir = 'docs'

    def finalize_options(self):
        # pylint: disable=attribute-defined-outside-init
        self.output_dir = os.path.abspath(self.output_dir)
        self.mkpath(self.output_dir)
        self.ensure_string_list('libraries')

    def run(self):
        import robot.libdoc
        # add all package_dir directories to the module path, so libdoc can
        # import the library properly
        for path in self.distribution.package_dir.values():
            sys.path.insert(0, path)
        for lib in self.libraries:
            if 'KICADLIBRARY_VERSION' in os.environ:
                ver = os.environ['KICADLIBRARY_VERSION']
            else:
                from setuptools_scm import get_version
                ver =  get_version(root='../../..', relative_to=__file__) 
            html_file = os.path.join(self.output_dir,
                                     lib + '-' +
                                    ver + '.html')
            robot.libdoc.libdoc(lib, html_file)
