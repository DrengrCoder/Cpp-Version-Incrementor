################################################################################
########################## Make command instructions ###########################

##### Template #####
# command
#	description / defintiion

##### Terminal command list #####

### Defualt commands from template makefile ###
# make
#	Builds the first target it finds, which should be declared under the 'Main 
#	build recipe' heading. This command simply looks for the first command in
#	the file and starts trying to build it, further building any prerequisites
#	defined for the target. Only one recipe should exist under this heading.

# make build
#	Defined to simply call the first target defined under the 'Main build 
#	recipe' heading. Done like this so 'build' can be called from other recipe's
#	without needing to type or modify the main target recipe command.

# make tests
#	Builds all test files into executables and stores them in the build folder.
#	This function additionally calls 'build' first to make sure any detected
#	changes are built before building new tests, but nothing will happen if no
#	changes have been detected to save compilation time.

# make tests_and_runtests
#	Calls the 'tests' command defined above and then the 'run_tests' command
#	defined below.

# make all
#	Calls the 'tests' command defined above, as this command also calls 'build'.

# make all_and_runtests
#	Calls the 'tests_and_runtests' command defined above.

# make clean
#	Removes all .o and .d files from the 'build/src/obj' directory, as well as
#	removing the main target executable.

# make clean_tests
#	Removes all files from the 'build/tests' directory.

# make clean_all
#	Calls 'clean_tests' and 'clean' defined above.

# make rebuild
#	Calls 'clean' and 'build' defined above.

# make rebuild_tests
#	Calls 'clean_tests' and 'tests' defined above.

# make rebuild_all
#	Calls 'clean_all' and 'all' defined above.

# make rebuild_tests_and_runtests
#	Calls 'rebuild_tests' defined above, and 'run_tests' defined below.

# make rebuild_all_and_runtests
#	Calls 'rebuild_all' defined above, and 'run_tests' defined below.

# make run_tests
#	Loops through all test executables in the 'build/tests' directory and runs
#	them, with an exit condition to exit the loop upon first failure.

# make make_directories
#	Create all required directories for this project. Typically only used to
#	create build directories but can be used for other purposes. Should be
#	defined as a prerequisite step for the first recipe called that builds any
#	type of file.

# make clear_log_files
#	Deletes all log files from within the various LogFiles directories.

# make announce_compiling_main
#	Prints echo information to display when things are happening. Defined as a
#	prerequisite to the recipe that starts compiling main project files.

# make announce_compiling_tests
#	Prints echo information to display when things are happening. Defined as a
#	prerequisite to the recipe that starts compiling test files.

################################################################################
########################## Basic variable definition ###########################

# Program executable name
TARGET_EXEC := VersionIncrementor

# Removal flags
RM := rm -rf

################################################################################
############################# Directory variables ##############################

# Install directory
at ?= /usr/local/include/dylanclibs

# Directories
#	Base directories
SRC_DIR ?= ./src
TEST_DIR ?= ./tests
BLD_DIR ?= ./build

#	Build directories
BLD_SRC_DIR ?= $(BLD_DIR)/src
BLD_TEST_DIR ?= $(BLD_DIR)/tests

################################################################################
##################### Retrieving and naming program files ######################

# Get the cpp files
SRCS := $(shell find $(SRC_DIR) -name '*.cpp')

# Name the object files
OBJS := $(SRCS:$(SRC_DIR)/%=$(BLD_SRC_DIR)/obj/%.o)

# Get the test files
TEST_SRCS := $(shell find $(TEST_DIR) -name '*.cpp')

# Name test executables
TEST_EXECS := $(TEST_SRCS:$(TEST_DIR)/%.cpp=%)

################################################################################
################################ Compiler flags ################################

################# C++ ##################
# C++ Compiler - This is already a default, override as needed with extra flags
#CXX := g++

# Extra C++ Compiler Flags
#	-Wall = turn on all warnings
CXXFLAGS := -Wall

# Define the include directories for compiler
INC_DIRS := $(shell find $(SRC_DIR) -type d)
# Add the 'include' prefix to INC_DIRS
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

########################################

############### General ################

# C Preprocessor flags
# 	The -MMD and -MP flags together generate Makefiles for us!
# 	These files will have .d instead of .o as the output.
CPPFLAGS := $(INC_FLAGS) -MMD -MP

########################################

################################################################################
############################## Main build recipe ###############################

# Build target program executable
$(BLD_SRC_DIR)/$(TARGET_EXEC): $(OBJS) 
	@echo Building \"$(TARGET_EXEC)\" executable.....
	@$(CXX) $(OBJS) -o $@
	@echo Finished building \"$(TARGET_EXEC)\", see output for details.
	@echo "####################################################################"

################################################################################
############################ Other target recipe's #############################

# Build object files from source
$(BLD_SRC_DIR)/obj/%.cpp.o: $(SRC_DIR)/%.cpp | announce_compiling_main make_directories
	@echo Making object file: $@
	@$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

# Build test executables
$(TEST_EXECS): announce_compiling_tests
	@echo Building \"$@\" executable...
	@$(CXX) $(CXXFLAGS) -o $(BLD_TEST_DIR)/$@ $(TEST_DIR)/$@.cpp

################################################################################
################################ Phony targets #################################

# Define these custom commands
.PHONY: build tests tests_and_runtests all all_and_runtests \
	clean clean_tests clean_all \
	rebuild rebuild_tests rebuild_all \
	rebuild_tests_and_runtests rebuild_all_and_runtests \
	run_tests make_directories clear_log_files \
	announce_compiling_main announce_compiling_tests

################################################################################
############################ Build command recipe's ############################

# Build main project / executable
build: $(BLD_SRC_DIR)/$(TARGET_EXEC)

# Build test files
tests: build $(TEST_EXECS)
	@echo Finished compiling tests, see output for details.
	@echo "####################################################################"

# Build tests and run them
tests_and_runtests: tests run_tests

# Build all targets - 'tests' runs 'build' and is the only thing required but
# for readability, this is nice to have
all: tests

# Build all targets and run tests
all_and_runtests: tests_and_runtests

################################################################################
############################ Clean command recipe's ############################

# Clean build folder
#	Additionally deletes everything in the dbg folder
clean:
	@echo "####################################################################"
	@echo Cleaning project files...
	@$(RM) $(BLD_SRC_DIR)/*/*.o $(BLD_SRC_DIR)/*/*.d $(BLD_SRC_DIR)/$(TARGET_EXEC)
	@$(RM) $(BLD_DIR)/dbg/*
	@echo Project files cleaned.
	@echo "####################################################################"

# Clean test files
clean_tests:
	@echo "####################################################################"
	@echo Cleaning test files...
	@$(RM) $(BLD_TEST_DIR)/*
	@echo Test files cleaned.
	@echo "####################################################################"

# Clean build folder and tests
clean_all: clean_tests clean

################################################################################
########################### Rebuild command recipe's ###########################

# Rebuild main target - clean and build
rebuild: clean build

# Rebuild test files - clean tests and build tests
rebuild_tests: clean_tests tests

# Rebuild all - clean main target and tests, and build main target and tests
rebuild_all: clean_all all

# Rebuild test files and run them - rebuild tests and run tests
rebuild_tests_and_runtests: rebuild_tests run_tests

# Rebuild all and run tests
rebuild_all_and_runtests: rebuild_all run_tests

################################################################################
######################### Additional command recipe's ##########################

# Install the files into the includes directory
install:
	@echo Installing Version Incrementor to: \"$(at)\"...
	@mkdir -p $(at)
	@cp ./build/src/VersionIncrementor $(at)

# Increment version number header
increment_version:
	@echo Incrementing version...
	@/usr/local/include/dylanclibs/VersionIncrementor -p ./src/version_number.h -n BUILD

# Run test files
#	This assumes the test files have already been built by some other command.
#	-s --reporter console || exit	-	will exit upon error in tests
run_tests:
	@echo "####################################################################"
	@echo Running tests.....
	for exec in $(TEST_EXECS); do \
		$(BLD_TEST_DIR)/$$exec -s --reporter console || exit; \
	done
	@echo Tests finished running, see console output for details.
	@echo "####################################################################"

make_directories:
	@mkdir -p $(BLD_DIR)
	@mkdir -p $(BLD_DIR)/dbg
	@mkdir -p $(BLD_SRC_DIR)
	@mkdir -p $(BLD_SRC_DIR)/obj
	@mkdir -p $(BLD_TEST_DIR)

# Remove all the log files to clean the project folders.
clear_log_files:
	@echo "####################################################################"
	@echo Deleting log files...
	@$(RM) LogFiles/* $(BLD_SRC_DIR)/LogFiles/* $(BLD_TEST_DIR)/LogFiles/*
	@echo Log files deleted.
	@echo "####################################################################"

# Announce the compilation recipe has started. Make this a prerequisite of the
# main target build recipe.
announce_compiling_main:
	@echo "####################################################################"
	@echo Compiling main program objects.....
	
# Announce compiling tests has started.
announce_compiling_tests:
	@echo "####################################################################"
	@echo Compiling tests...

