"""Module for installing dependcies for directory tools."""

from pip._internal import utils
import conda.cli as conda_client
import subprocess
import sys
import re
import os

class PackageInstaller(object):
    """Installation of dependcies for tools."""

    def __init__(self):

        self.modules = self.define_modules()
        self.environment = self.find_environment()

    def define_modules(self):
        """Read modules list from Pipfile."""

        with open('../Pipfile') as modules:
            content = modules.read().splitlines()

        begin = [i for i, line in enumerate(content) if re.match(r'\[packages\]', line)][0] + 1
        end = [i for i, line in enumerate(content) if re.match(r'\[requires\]', line)][0] - 2

        modules = [re.search(r'.*(?=\s\=)', module)[0] for module in content[begin:end]]
        return modules

    def find_environment(self):
        """Determine if user is using Conda or Pip for package management."""

        if os.system('conda list >/dev/null 2>&1') == 256:
            print('no Conda environment found ... installing packages via pip')
            env = 'pip'
        else:
            print('Conda environment found ... installing packages via Conda')
            env = 'conda'

        return env

    def module_check_install(self):
        """Check local machine for installed packages; install those that aren't via conda."""

        packages = [package.project_name for package in utils.misc.get_installed_distributions()]
        for module in self.modules:
            if not module in packages:
                print(module + ' not found ... will attempt to install now')

                if self.environment == 'conda':
                    conda_client.main('conda', 'install', '-y', module)

                elif self.environment == 'pip':
                    subprocess.call([sys.executable, '-m', 'pip', 'install', f'{module}'])

        print('\n module installation complete')
