#!/usr/bin/env python3
"""Just the code needed for `pipenv --venv`, without all the heavy imports.

Extracted from https://github.com/pypa/pipenv/tree/9378cb515189d11841a4de49a5ac3c01fca509ec
"""

import base64
import errno
import fnmatch
import glob
import hashlib
import io
import os
import re
import sys
import typing
from pathlib import Path

if typing.TYPE_CHECKING:
    from typing import Generator, List, Optional, Tuple, Union


# pipenv/patched/pipfile/api.py
def find(max_depth=3):
    # type: (int) -> str
    """Returns the path of a Pipfile in parent directories."""
    i = 0
    for c, _, _ in walk_up(os.getcwd()):
        i += 1

        if i < max_depth:
            p = os.path.join(c, "Pipfile")
            if os.path.isfile(p):
                return p
    raise RuntimeError("No Pipfile found!")


# pipenv/utils.py
def mkdir_p(newdir):
    # type: (str) -> None
    """works the way a good mkdir should :)
    - already exists, silently complete
    - regular file in the way, raise an exception
    - parent directory(ies) does not exist, make them as well
    From: http://code.activestate.com/recipes/82465-a-friendly-mkdir/
    """
    if os.path.isdir(newdir):
        pass
    elif os.path.isfile(newdir):
        raise OSError(
            "a file with the same name as the desired dir, '{}', already exists.".format(
                newdir
            )
        )

    else:
        head, tail = os.path.split(newdir)
        if head and not os.path.isdir(head):
            mkdir_p(head)
        if tail:
            # Even though we've checked that the directory doesn't exist above, it might exist
            # now if some other process has created it between now and the time we checked it.
            try:
                os.mkdir(newdir)
            except OSError as exn:
                # If we failed because the directory does exist, that's not a problem -
                # that's what we were trying to do anyway. Only re-raise the exception
                # if we failed for some other reason.
                if exn.errno != errno.EEXIST:
                    raise


def walk_up(bottom):
    # type: (str) -> Generator[Tuple[str, List[str], List[str]], None, None]
    """mimic os.walk, but walk 'up' instead of down the directory tree.
    From: https://gist.github.com/zdavkeos/1098474
    """

    bottom = os.path.realpath(bottom)

    # get files in current dir
    try:
        names = os.listdir(bottom)
    except OSError:
        return

    dirs, nondirs = [], []
    for name in names:
        if os.path.isdir(os.path.join(bottom, name)):
            dirs.append(name)
        else:
            nondirs.append(name)

    yield bottom, dirs, nondirs

    new_path = os.path.realpath(os.path.join(bottom, ".."))

    # see if we are at the top
    if new_path == bottom:
        return

    for x in walk_up(new_path):
        yield x


def get_workon_home():
    # type: () -> Path
    workon_home = os.environ.get("WORKON_HOME")
    if not workon_home:
        if os.name == "nt":
            workon_home = "~/.virtualenvs"
        else:
            workon_home = os.path.join(
                os.environ.get("XDG_DATA_HOME", "~/.local/share"), "virtualenvs"
            )
    # Create directory if it does not already exist
    expanded_path = Path(os.path.expandvars(workon_home)).expanduser()
    mkdir_p(str(expanded_path))
    return expanded_path


def is_virtual_environment(path):
    # type: (Path) -> bool
    """Check if a given path is a virtual environment's root.

    This is done by checking if the directory contains a Python executable in
    its bin/Scripts directory. Not technically correct, but good enough for
    general usage.
    """
    if not path.is_dir():
        return False
    for bindir_name in ("bin", "Scripts"):
        for python in path.joinpath(bindir_name).glob("python*"):
            try:
                exeness = python.is_file() and os.access(str(python), os.X_OK)
            except OSError:
                exeness = False
            if exeness:
                return True
    return False


def looks_like_dir(path):
    # type: (str) -> bool
    seps = (sep for sep in (os.path.sep, os.path.altsep) if sep is not None)
    return any(sep in path for sep in seps)


def normalize_drive(path):
    # type: (str) -> str
    """Normalize drive in path so they stay consistent.

    This currently only affects local drives on Windows, which can be
    identified with either upper or lower cased drive names. The case is
    always converted to uppercase because it seems to be preferred.

    See: <https://github.com/pypa/pipenv/issues/1218>
    """
    if os.name != "nt" or not isinstance(path, str):
        return path

    drive, tail = os.path.splitdrive(path)
    # Only match (lower cased) local drives (e.g. 'c:'), not UNC mounts.
    if drive.islower() and len(drive) == 2 and drive[1] == ":":
        return f"{drive.upper()}{tail}"

    return path


# pipenv/environments.py
def normalize_pipfile_path(p):
    # type: (str) -> str
    loc = Path(p)
    try:
        loc = loc.resolve()
    except OSError:
        loc = loc.absolute()
    # Recase the path properly on Windows. From https://stackoverflow.com/a/35229734/5043728
    if os.name == "nt":
        matches = glob.glob(re.sub(r"([^:/\\])(?=[/\\]|$)", r"[\1]", str(loc)))
        path_str = matches[0] if matches else str(loc)
    else:
        path_str = str(loc)
    return normalize_drive(os.path.abspath(path_str))


class Setting:
    def __init__(self):
        # type: () -> None
        self.PIPENV_IGNORE_VIRTUALENVS = bool(
            os.environ.get("PIPENV_IGNORE_VIRTUALENVS")
        )
        self.PIPENV_MAX_DEPTH = int(os.environ.get("PIPENV_MAX_DEPTH", "3")) + 1
        self.PIPENV_NO_INHERIT = "PIPENV_NO_INHERIT" in os.environ
        if self.PIPENV_NO_INHERIT:
            self.PIPENV_MAX_DEPTH = 2

        pipenv_pipfile = os.environ.get("PIPENV_PIPFILE")
        if pipenv_pipfile:
            if not os.path.isfile(pipenv_pipfile):
                raise RuntimeError("Given PIPENV_PIPFILE is not found!")

            pipenv_pipfile = normalize_pipfile_path(pipenv_pipfile)
            # Overwrite environment variable so that subprocesses can get the correct path.
            # See https://github.com/pypa/pipenv/issues/3584
            if pipenv_pipfile is not None:
                os.environ["PIPENV_PIPFILE"] = pipenv_pipfile
        self.PIPENV_PIPFILE = pipenv_pipfile
        self.PIPENV_VENV_IN_PROJECT = bool(os.environ.get("PIPENV_VENV_IN_PROJECT"))
        self.PIPENV_PYTHON = os.environ.get("PIPENV_PYTHON")


# pipenv/project.py
class Project:
    def __init__(self):
        # type: () -> None
        self._name = None  # type: Optional[str]
        self._virtualenv_location = None  # type: Optional[str]
        self._pipfile_location = None  # type: Optional[str]
        self.s = Setting()

    @property
    def name(self):
        # type: () -> str
        if self._name is None:
            self._name = self.pipfile_location.split(os.sep)[-2]
        return self._name

    @property
    def virtualenv_exists(self):
        # type: () -> bool
        if os.path.exists(self.virtualenv_location):
            if os.name == "nt":
                extra = ["Scripts", "activate.bat"]
            else:
                extra = ["bin", "activate"]
            return os.path.isfile(os.sep.join([self.virtualenv_location] + extra))

        return False

    def is_venv_in_project(self):
        # type: () -> bool
        return self.s.PIPENV_VENV_IN_PROJECT or (
            bool(self.project_directory)
            and os.path.isdir(os.path.join(self.project_directory, ".venv"))
        )

    @classmethod
    def _sanitize(cls, name):
        # type: (str) -> str
        # Replace dangerous characters into '_'. The length of the sanitized
        # project name is limited as 42 because of the limit of linux kernel
        #
        # 42 = 127 - len('/home//.local/share/virtualenvs//bin/python2') - 32 - len('-HASHHASH')
        #
        #      127 : BINPRM_BUF_SIZE - 1
        #       32 : Maximum length of username
        #
        # References:
        #   https://www.gnu.org/software/bash/manual/html_node/Double-Quotes.html
        #   http://www.tldp.org/LDP/abs/html/special-chars.html#FIELDREF
        #   https://github.com/torvalds/linux/blob/2bfe01ef/include/uapi/linux/binfmts.h#L18
        return re.sub(r'[ &$`!*@"()\[\]\\\r\n\t]', "_", name)[0:42]

    def _get_virtualenv_hash(self, name):
        # type: (str) -> Tuple[str, str]
        """Get the name of the virtualenv adjusted for windows if needed
        Returns (name, encoded_hash)
        """

        def get_name(name, location):
            # type: (str, str) -> Tuple[str, str]
            name = self._sanitize(name)
            hash_ = hashlib.sha256(location.encode()).digest()[:6]
            encoded_hash = base64.urlsafe_b64encode(hash_).decode()
            return name, encoded_hash[:8]

        clean_name, encoded_hash = get_name(name, self.pipfile_location)
        venv_name = "{0}-{1}".format(clean_name, encoded_hash)

        # This should work most of the time for
        #   Case-sensitive filesystems,
        #   In-project venv
        #   "Proper" path casing (on non-case-sensitive filesystems).
        if (
            not fnmatch.fnmatch("A", "a")
            or self.is_venv_in_project()
            or get_workon_home().joinpath(venv_name).exists()
        ):
            return clean_name, encoded_hash

        # Check for different capitalization of the same project.
        for path in get_workon_home().iterdir():
            if not is_virtual_environment(path):
                continue
            try:
                env_name, hash_ = path.name.rsplit("-", 1)
            except ValueError:
                continue
            if len(hash_) != 8 or env_name.lower() != name.lower():
                continue
            return get_name(env_name, self.pipfile_location.replace(name, env_name))

        # Use the default if no matching env exists.
        return clean_name, encoded_hash

    @property
    def virtualenv_name(self):
        # type: () -> str
        sanitized, encoded_hash = self._get_virtualenv_hash(self.name)
        suffix = ""
        if self.s.PIPENV_PYTHON:
            if os.path.isabs(self.s.PIPENV_PYTHON):
                suffix = "-{0}".format(os.path.basename(self.s.PIPENV_PYTHON))
            else:
                suffix = "-{0}".format(self.s.PIPENV_PYTHON)

        # If the pipfile was located at '/home/user/MY_PROJECT/Pipfile',
        # the name of its virtualenv will be 'my-project-wyUfYPqE'
        return sanitized + "-" + encoded_hash + suffix

    def get_location_for_virtualenv(self):
        # type: () -> str
        # If there's no project yet, set location based on config.
        if not self.project_directory:
            if self.is_venv_in_project():
                return os.path.abspath(".venv")
            return str(get_workon_home().joinpath(self.virtualenv_name))

        dot_venv = os.path.join(self.project_directory, ".venv")

        # If there's no .venv in project root, set location based on config.
        if not os.path.exists(dot_venv):
            if self.is_venv_in_project():
                return dot_venv
            return str(get_workon_home().joinpath(self.virtualenv_name))

        # If .venv in project root is a directory, use it.
        if os.path.isdir(dot_venv):
            return dot_venv

        # Now we assume .venv in project root is a file. Use its content.
        with io.open(dot_venv) as f:
            name = f.read().strip()

        # If content looks like a path, use it as a relative path.
        # Otherwise use directory named after content in WORKON_HOME.
        if looks_like_dir(name):
            path = Path(self.project_directory, name)
            return path.absolute().as_posix()
        return str(get_workon_home().joinpath(name))

    @property
    def virtualenv_location(self):
        # type: () -> str
        # if VIRTUAL_ENV is set, use that.
        virtualenv_env = os.getenv("VIRTUAL_ENV")
        if (
            "PIPENV_ACTIVE" not in os.environ
            and not self.s.PIPENV_IGNORE_VIRTUALENVS
            and virtualenv_env
        ):
            return virtualenv_env

        if not self._virtualenv_location:  # Use cached version, if available.
            assert self.project_directory, "project not created"
            self._virtualenv_location = self.get_location_for_virtualenv()
        return self._virtualenv_location

    @property
    def project_directory(self):
        # type: () -> str
        return os.path.abspath(os.path.join(self.pipfile_location, os.pardir))

    @property
    def pipfile_location(self):
        # type: () -> str
        if self.s.PIPENV_PIPFILE:
            return self.s.PIPENV_PIPFILE

        if self._pipfile_location is None:
            try:
                loc = find(max_depth=self.s.PIPENV_MAX_DEPTH)
            except RuntimeError:
                loc = "Pipfile"
            self._pipfile_location = normalize_pipfile_path(loc)
        return self._pipfile_location


def main():
    # type: () -> None
    # pipenv/cli/options.py
    p = Project()
    # pipenv/cli/command.py
    if not p.virtualenv_exists:
        sys.exit(1)
    print(p.virtualenv_location)


if __name__ == "__main__":
    main()
