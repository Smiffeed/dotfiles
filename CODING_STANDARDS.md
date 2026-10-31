# Coding Standards for Dotfiles

This document outlines architectural and implementation standards for configurations and scripts in this repository.

## 1. Wayland Dmenu and Launcher Utilities

When creating or modifying launcher scripts that feed into lightweight Wayland dmenu utilities (`fuzzel`, `bemenu`, etc.):

- **Pre-format in generator**: Do not use complex template format strings (such as `--with-nth='{1} ({2})'`) over large line streams. Lightweight C parsers can crash or corrupt heap memory on large inputs. Format the complete line in the upstream generator (Python, Awk, or shell) as `display_string\ttarget_payload`.
- **Use simple numeric column selectors**: Pass `--with-nth=1` to display the formatted text and `--accept-nth=2` to return the target payload.
- **Process replacement**: Use `exec` when launching the terminal or final application from a launcher script (e.g. `exec foot yazi "$SELECTION"`). This replaces the launcher shell process rather than keeping an idle parent process in memory.
- **Progressive streaming**: In Python or shell generators, process input line by line to keep UI startup instant.

## 2. Interactive GUI & Script Verification

Interactive scripts running under compositor hotkeys or launcher overlays fail silently if an unhandled error or core dump occurs.

- **Smoke test interactive scripts**: Before handing any GUI or dmenu script change to the user, run a non-blocking smoke test (e.g. using a 1-second timeout or simulated input via `subprocess.Popen`) to verify the process initializes cleanly and does not exit with a signal or error.
- **Syntax validation**: Every shell script must pass `bash -n`, and Python scripts must pass `py_compile`. Run `./check.sh` before finishing.

## 3. Path Portability

- Never hardcode user workspace directory variations (such as `~/Workspace` vs `~/Workspaces`) in utility scripts.
- Use `$(cd "$(dirname "$0")" && pwd)` in repository scripts to locate project roots reliably.
