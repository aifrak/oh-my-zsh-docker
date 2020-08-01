import os
import platform
import pytest
import testinfra

HOME_PATH = os.environ['HOME']
ROOT = 'root'
USER_NAME = 'zsh-user'
USER_GROUP = 'www-data'
FONTS_PATH = '/usr/local/share/fonts'
OH_MY_ZSH_PATH = HOME_PATH + '/.oh-my-zsh'


def test_python():
    assert platform.python_version() == '3.8.5'


def test_pip_packages(host):
    pip_packages = host.pip_package.get_packages

    assert pip_packages()['pip']['version'] == '20.1.1'
    assert pip_packages()['pytest']['version'] == '5.4.3'
    assert pip_packages()['testinfra']['version'] == '5.2.2'


@pytest.mark.parametrize('name,version', [
    ('git', ''),
    ('wget', ''),
    ('zsh', ''),
    ('lsd', '0.17.0'),
])
def test_packages(host, name, version):
    package = host.package(name)

    assert package.is_installed
    if version:
        assert package.version.startswith(version)


def test_current_user(host):
    user = host.user()

    assert user.name == USER_NAME
    assert user.group == USER_GROUP


def test_home_directory(host):
    assert HOME_PATH == '/home/' + USER_NAME


def test_fzf_package(host):
    # workaround to test if fzf is installed (not detected as installed by testinfra)
    fzf_version_cmd = host.run('fzf --version')

    assert fzf_version_cmd.succeeded
    assert fzf_version_cmd.stdout.startswith('0.21.1')


@pytest.mark.parametrize('path,user,group', [
    (OH_MY_ZSH_PATH + '/custom/plugins/zsh-syntax-highlighting', USER_NAME, USER_GROUP),
    (OH_MY_ZSH_PATH + '/custom/plugins/zsh-autosuggestions', USER_NAME, USER_GROUP),
    (OH_MY_ZSH_PATH + '/custom/themes/powerlevel10k', USER_NAME, USER_GROUP),
])
def test_copied_directories(host, path, user, group):
    file = host.file(path)

    assert file.is_directory
    assert len(file.listdir()) > 0
    assert file.user == user
    assert file.group == group


@pytest.mark.parametrize('path,user,group', [
    (HOME_PATH + '/.zshrc', USER_NAME, USER_GROUP),
    (HOME_PATH + '/.p10k.zsh', USER_NAME, USER_GROUP),
    (HOME_PATH + '/.oh-my-zsh/custom/aliases.zsh', USER_NAME, USER_GROUP),
    (FONTS_PATH + '/Fura Code Light Nerd Font Complete.ttf', ROOT, ROOT),
    (FONTS_PATH + '/Fura Code Regular Nerd Font Complete.ttf', ROOT, ROOT),
    (FONTS_PATH + '/Fura Code Medium Nerd Font Complete.ttf', ROOT, ROOT),
    (FONTS_PATH + '/Fura Code Bold Nerd Font Complete.ttf', ROOT, ROOT),
    (FONTS_PATH + '/Fura Code Retina Nerd Font Complete.ttf', ROOT, ROOT),
])
def test_copied_files(host, path, user, group):
    file = host.file(path)

    assert file.is_file
    assert file.user == user
    assert file.group == group


def test_zsh(host):
    cmd = host.run("zsh")

    assert cmd.succeeded