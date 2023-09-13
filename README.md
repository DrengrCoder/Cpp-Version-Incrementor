# Version Incrementor v1.0.0

## Table of Contents

- [Description](#description)
- [Versioning System](#versioning-system)
- [Features](#features)
- [Make and Install](#make-and-install)
    - [Dependancies](#dependancies)
- [Usage](#usage)
    - [Overview](#overview)
    - [Specific Recipe Command Details](#specific-recipe-command-details)
    - [Input arguments](#input-arguments)
    - [Examples](#examples)

## Description

A project that builds a binary for the automated version incrementor program. The project binary should be included in the C++ Library project by default, and installed in the /usr/bin directory.

## Versioning System

This Version Incrementor operates based on the [Semantic Versioning](https://github.com/semver/semver/blob/master/semver.md) standard. A MAJOR.MINOR.PATCH.BUILD version numbering system has been adopted, where the MAJOR.MINOR.PATCH number is based on the Semantic Versioning documentation standard, and the **Build** number is incremented every time the _build_ command is used. The **Build** can be incremented in one of the following ways, but is not limited to: A Pre-build step in a comprehensive IDE, or a prerequisite step in a Make or CMake based project.

## Features

The program accepts two options: A file path for the header file in a given project and the number you wish to increment. The format must follow a strict pattern, and you should let this program create the header file itself if it doesn't exist on the first use so it generates the file as it needs to be. This does not automatically implement pre-build steps into VS code or any other type of project, rather it creates a program binary that will increment a given version number as required. You should look at the [Usage](#usage) section on how to use this program.

## Make and Install

**NOTE:** Due to the nature of command recipe's implemented in this program for testing and demostration purposes, follow these **exact** steps to build the program and install it into the required location.

1. Run `make build`, to execute the primary build recipe. This will generate the program binary.
2. Run `sudo make install` to copy or 'install' the binary file in the include directory so an IDE can see it and can be used in your code. Alternatively, use `make install at=/your/chosen/directory/` to install the file in a custom folder location.
3. Review the [Usage](#usage) section to see how to use this program and get details for other make recipes in this project.

### Dependancies

This program requires the `log.h`, `cli_parser.h`, and `string.h` files to be installed from the C++ Classes project I have developed. The file paths for the include statements in `main.cpp` for those files may need changing depending on your chosen install location.

## Usage

### Overview

Once installed into the directory of your choice, you will be able to execute the binary file from anywhere, or you can install it in the `/usr/bin` directory so it is accessible in the Linux terminal window like any other system software, including from within makefile's, but you will need to remember the binary file path to use in your makefile later if you do not install it in the normal `/usr/bin` folder.

### Specific Recipe Command Details

Reviewing the list of make recipe's in this project, you'll notice several additions compared to other projects I have developed: `main_target`, `major`, `minor`, `patch`, `increment_version_major`, `increment_version_minor`, `increment_version_patch` and `increment_version_build`. The latter 4 recipes specifically show you how to call the version incrementor from a makefile, while the remaining recipe's simply call one of the `increment` recipe's before calling `clean` and then building the main target executable.

```
patch: increment_version_patch clean $(BLD_SRC_DIR)/$(TARGET_EXEC)

increment_version_patch:
	@echo Incrementing patch...
	@VersionIncrementor -p ./src/version_number.h -n PATCH

increment_version_build:
	@echo Incrementing build...
	@VersionIncrementor -p ./src/version_number.h
```

The `clean` recipe must be called before building the final executable because the version number header has been updated, but using the standard `make` or `make build` commands don't always detect a change and therefore won't attempt to rebuild the main target with the new header file data. The `main_target: increment_version_build clean $(BLD_SRC_DIR)/$(TARGET_EXEC)` recipe has been declared above the standard main target executable build step, so every time you run `make`, it will call this recipe to increment the build number, clean the project and rebuild the target executable with the latest version number data.

You should carefully examine the format and order of make recipe's within this project if you want to replicate these simple features, but you are free to implement this program and use it as you desire.

### Input arguments

1. The `-p` argument, or `--header-file-path`, defines the full filepath (including file name) to the header file where the version numbers are stored as macro's. This file is created if it does not exist, and you should let this program create that file upon first use so you can understand the format expected by this program.
2. The `-n` argument, or `--version-number`, defines the version number you want to increment at this time. `MAJOR`, `MINOR`, `PATCH` and `BUILD` are the only options, and you should review the [Versioning System](#versioning-system) section for more information.

### Examples

- `VersionIncrementor -h` shows the help information.
- `VersionIncrementor -v` shows the version information.
- `VersionIncrementor -n -h` shows the help information for the `-n` argument.
- `VersionIncrementor -p /path/to/project/header.h` will increment numbers in the file in the specified path. If the `-n` argument is not present, it assumed `BUILD`.
- `VersionIncrementor -p ./src/header.h` will increment the build number in the file in the specified path, and in this instance, the specified path has been written to go from the makefile's location. So within the given project a makefile is run for, the sub folder _/src/_ with the header file _header.h_ is used in _this_ project.
- `VersionIncrementor -p /path/to/project/header.h -n MAJOR` will increment the major number in the header file.
- `VersionIncrementor -p /path/to/project/header.h -n PATCH` will increment the patch number in the header file.
