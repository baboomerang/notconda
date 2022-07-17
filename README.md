# Notconda

This tool is a wrapper script for the Python `venv` module. It lets users easily manage virtual environments from a single directory.

Also, this tool is aimed for Linux users that want to manage their Python environments ***without needing to install Anaconda or similar "bloated" software.***

This tool is very lightweight, efficient, and gets the job done.

## Installation

Install Notconda by defining this alias in your `.bashrc` file.

```bash
    alias notconda='source ${PATH_TO_SCRIPT}/notconda.sh'
```
Put the script file in a preferred directory, then make sure the alias points to that directory.

For Example: if your `notconda.sh` is in `~/Documents/`, then the alias path should look like: `source ~/Documents/notconda.sh`
## Usage/Examples

```bash
    $ notconda create nodeenv
    $ notconda activate nodeenv
    $ notconda list
    $ notconda deactivate
```

