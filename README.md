<!--
SPDX-FileCopyrightText: Contributors to the Power Grid Model project <powergridmodel@lfenergy.org>

SPDX-License-Identifier: MPL-2.0
-->

# pgm-build-deps

A proxy Python package to host all header-only libraries which are needed to build Power Grid Model.

The GitHub Actions automatically fetches the latest versions of the header-only libraries and updates the `pgm-build-deps` package.

## Installation and Usage

This package should be part of build dependencies of the Power Grid Model project.

### As build dependency for Python

```toml
[build-system]
requires = [
    "pgm-build-deps"
]
```

In the build process, the entry point `cmake.root` will be installed into the build environment. The build backend, e.g., [`scikit-build-core`](https://github.com/scikit-build/scikit-build-core), can retrieve the `cmake` search paths and use them when invoking `cmake`.

### Load into your local environment for the C++ build

#### Windows (PowerShell)

```ps1
uv tool install pgm-build-deps
$env:CMAKE_PREFIX_PATH = (pgm-build-setup-local-prefix)

# only if you want it to persist across sessions
[Environment]::SetEnvironmentVariable("CMAKE_PREFIX_PATH", $env:CMAKE_PREFIX_PATH, "User")
```

This replaces `CMAKE_PREFIX_PATH` in the current window.
The last command saves it for your Windows user; restart your editor to pick it up.

#### Unix-like systems (Bash, Zsh, or another POSIX-compatible shell)

```sh
uv tool install pgm-build-deps
export CMAKE_PREFIX_PATH="$(pgm-build-setup-local-prefix)"

# only if you want it to persist across sessions; use .bash_profile, .zprofile or equivalent for other shells
cat >> "$HOME/.profile" <<'EOF'
export CMAKE_PREFIX_PATH="$(pgm-build-setup-local-prefix)"
EOF
```

This replaces `CMAKE_PREFIX_PATH` in the current shell.
The heredoc appends the export command to `~/.profile` for future login shells.
On Linux, launch your editor from this shell (e.g., `code .`) so extensions inherit the variable.

### Load into CI for the C++ build

```yaml
    steps:
      - name: Install uv
        uses: astral-sh/setup-uv@v5
      
      - name: Install pgm-build-deps
        run: |
          uv tool install pgm-build-deps
          pgm-build-setup-ga-ci
```

After setting this in your GitHub Actions CI, the follow-up `cmake` calls will find the packages.

## License

The source code of this package is licensed under the [MPL-2.0](https://spdx.org/licenses/MPL-2.0.html) license.

The header-only libraries are licensed under their respective licenses, which can be found in the [`LICENSES`](LICENSES) directory of this package.
