# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /local/scylladb/Scylla-original/seastar/c-ares

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /local/scylladb/Scylla-original/seastar/build/release/c-ares

# Include any dependencies generated for this target.
include CMakeFiles/acountry.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/acountry.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/acountry.dir/flags.make

CMakeFiles/acountry.dir/acountry.c.o: CMakeFiles/acountry.dir/flags.make
CMakeFiles/acountry.dir/acountry.c.o: /local/scylladb/Scylla-original/seastar/c-ares/acountry.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-original/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/acountry.dir/acountry.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/acountry.dir/acountry.c.o   -c /local/scylladb/Scylla-original/seastar/c-ares/acountry.c

CMakeFiles/acountry.dir/acountry.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/acountry.dir/acountry.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-original/seastar/c-ares/acountry.c > CMakeFiles/acountry.dir/acountry.c.i

CMakeFiles/acountry.dir/acountry.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/acountry.dir/acountry.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-original/seastar/c-ares/acountry.c -o CMakeFiles/acountry.dir/acountry.c.s

CMakeFiles/acountry.dir/acountry.c.o.requires:

.PHONY : CMakeFiles/acountry.dir/acountry.c.o.requires

CMakeFiles/acountry.dir/acountry.c.o.provides: CMakeFiles/acountry.dir/acountry.c.o.requires
	$(MAKE) -f CMakeFiles/acountry.dir/build.make CMakeFiles/acountry.dir/acountry.c.o.provides.build
.PHONY : CMakeFiles/acountry.dir/acountry.c.o.provides

CMakeFiles/acountry.dir/acountry.c.o.provides.build: CMakeFiles/acountry.dir/acountry.c.o


CMakeFiles/acountry.dir/ares_getopt.c.o: CMakeFiles/acountry.dir/flags.make
CMakeFiles/acountry.dir/ares_getopt.c.o: /local/scylladb/Scylla-original/seastar/c-ares/ares_getopt.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-original/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/acountry.dir/ares_getopt.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/acountry.dir/ares_getopt.c.o   -c /local/scylladb/Scylla-original/seastar/c-ares/ares_getopt.c

CMakeFiles/acountry.dir/ares_getopt.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/acountry.dir/ares_getopt.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-original/seastar/c-ares/ares_getopt.c > CMakeFiles/acountry.dir/ares_getopt.c.i

CMakeFiles/acountry.dir/ares_getopt.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/acountry.dir/ares_getopt.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-original/seastar/c-ares/ares_getopt.c -o CMakeFiles/acountry.dir/ares_getopt.c.s

CMakeFiles/acountry.dir/ares_getopt.c.o.requires:

.PHONY : CMakeFiles/acountry.dir/ares_getopt.c.o.requires

CMakeFiles/acountry.dir/ares_getopt.c.o.provides: CMakeFiles/acountry.dir/ares_getopt.c.o.requires
	$(MAKE) -f CMakeFiles/acountry.dir/build.make CMakeFiles/acountry.dir/ares_getopt.c.o.provides.build
.PHONY : CMakeFiles/acountry.dir/ares_getopt.c.o.provides

CMakeFiles/acountry.dir/ares_getopt.c.o.provides.build: CMakeFiles/acountry.dir/ares_getopt.c.o


CMakeFiles/acountry.dir/ares_nowarn.c.o: CMakeFiles/acountry.dir/flags.make
CMakeFiles/acountry.dir/ares_nowarn.c.o: /local/scylladb/Scylla-original/seastar/c-ares/ares_nowarn.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-original/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/acountry.dir/ares_nowarn.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/acountry.dir/ares_nowarn.c.o   -c /local/scylladb/Scylla-original/seastar/c-ares/ares_nowarn.c

CMakeFiles/acountry.dir/ares_nowarn.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/acountry.dir/ares_nowarn.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-original/seastar/c-ares/ares_nowarn.c > CMakeFiles/acountry.dir/ares_nowarn.c.i

CMakeFiles/acountry.dir/ares_nowarn.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/acountry.dir/ares_nowarn.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-original/seastar/c-ares/ares_nowarn.c -o CMakeFiles/acountry.dir/ares_nowarn.c.s

CMakeFiles/acountry.dir/ares_nowarn.c.o.requires:

.PHONY : CMakeFiles/acountry.dir/ares_nowarn.c.o.requires

CMakeFiles/acountry.dir/ares_nowarn.c.o.provides: CMakeFiles/acountry.dir/ares_nowarn.c.o.requires
	$(MAKE) -f CMakeFiles/acountry.dir/build.make CMakeFiles/acountry.dir/ares_nowarn.c.o.provides.build
.PHONY : CMakeFiles/acountry.dir/ares_nowarn.c.o.provides

CMakeFiles/acountry.dir/ares_nowarn.c.o.provides.build: CMakeFiles/acountry.dir/ares_nowarn.c.o


CMakeFiles/acountry.dir/ares_strcasecmp.c.o: CMakeFiles/acountry.dir/flags.make
CMakeFiles/acountry.dir/ares_strcasecmp.c.o: /local/scylladb/Scylla-original/seastar/c-ares/ares_strcasecmp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-original/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/acountry.dir/ares_strcasecmp.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/acountry.dir/ares_strcasecmp.c.o   -c /local/scylladb/Scylla-original/seastar/c-ares/ares_strcasecmp.c

CMakeFiles/acountry.dir/ares_strcasecmp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/acountry.dir/ares_strcasecmp.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-original/seastar/c-ares/ares_strcasecmp.c > CMakeFiles/acountry.dir/ares_strcasecmp.c.i

CMakeFiles/acountry.dir/ares_strcasecmp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/acountry.dir/ares_strcasecmp.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-original/seastar/c-ares/ares_strcasecmp.c -o CMakeFiles/acountry.dir/ares_strcasecmp.c.s

CMakeFiles/acountry.dir/ares_strcasecmp.c.o.requires:

.PHONY : CMakeFiles/acountry.dir/ares_strcasecmp.c.o.requires

CMakeFiles/acountry.dir/ares_strcasecmp.c.o.provides: CMakeFiles/acountry.dir/ares_strcasecmp.c.o.requires
	$(MAKE) -f CMakeFiles/acountry.dir/build.make CMakeFiles/acountry.dir/ares_strcasecmp.c.o.provides.build
.PHONY : CMakeFiles/acountry.dir/ares_strcasecmp.c.o.provides

CMakeFiles/acountry.dir/ares_strcasecmp.c.o.provides.build: CMakeFiles/acountry.dir/ares_strcasecmp.c.o


# Object files for target acountry
acountry_OBJECTS = \
"CMakeFiles/acountry.dir/acountry.c.o" \
"CMakeFiles/acountry.dir/ares_getopt.c.o" \
"CMakeFiles/acountry.dir/ares_nowarn.c.o" \
"CMakeFiles/acountry.dir/ares_strcasecmp.c.o"

# External object files for target acountry
acountry_EXTERNAL_OBJECTS =

bin/acountry: CMakeFiles/acountry.dir/acountry.c.o
bin/acountry: CMakeFiles/acountry.dir/ares_getopt.c.o
bin/acountry: CMakeFiles/acountry.dir/ares_nowarn.c.o
bin/acountry: CMakeFiles/acountry.dir/ares_strcasecmp.c.o
bin/acountry: CMakeFiles/acountry.dir/build.make
bin/acountry: lib/libcares.a
bin/acountry: CMakeFiles/acountry.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/local/scylladb/Scylla-original/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable bin/acountry"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/acountry.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/acountry.dir/build: bin/acountry

.PHONY : CMakeFiles/acountry.dir/build

CMakeFiles/acountry.dir/requires: CMakeFiles/acountry.dir/acountry.c.o.requires
CMakeFiles/acountry.dir/requires: CMakeFiles/acountry.dir/ares_getopt.c.o.requires
CMakeFiles/acountry.dir/requires: CMakeFiles/acountry.dir/ares_nowarn.c.o.requires
CMakeFiles/acountry.dir/requires: CMakeFiles/acountry.dir/ares_strcasecmp.c.o.requires

.PHONY : CMakeFiles/acountry.dir/requires

CMakeFiles/acountry.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/acountry.dir/cmake_clean.cmake
.PHONY : CMakeFiles/acountry.dir/clean

CMakeFiles/acountry.dir/depend:
	cd /local/scylladb/Scylla-original/seastar/build/release/c-ares && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /local/scylladb/Scylla-original/seastar/c-ares /local/scylladb/Scylla-original/seastar/c-ares /local/scylladb/Scylla-original/seastar/build/release/c-ares /local/scylladb/Scylla-original/seastar/build/release/c-ares /local/scylladb/Scylla-original/seastar/build/release/c-ares/CMakeFiles/acountry.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/acountry.dir/depend

