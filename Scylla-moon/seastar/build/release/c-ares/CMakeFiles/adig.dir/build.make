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
CMAKE_SOURCE_DIR = /local/scylladb/Scylla-moon/seastar/c-ares

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /local/scylladb/Scylla-moon/seastar/build/release/c-ares

# Include any dependencies generated for this target.
include CMakeFiles/adig.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/adig.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/adig.dir/flags.make

CMakeFiles/adig.dir/adig.c.o: CMakeFiles/adig.dir/flags.make
CMakeFiles/adig.dir/adig.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/adig.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/adig.dir/adig.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/adig.dir/adig.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/adig.c

CMakeFiles/adig.dir/adig.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/adig.dir/adig.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/adig.c > CMakeFiles/adig.dir/adig.c.i

CMakeFiles/adig.dir/adig.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/adig.dir/adig.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/adig.c -o CMakeFiles/adig.dir/adig.c.s

CMakeFiles/adig.dir/adig.c.o.requires:

.PHONY : CMakeFiles/adig.dir/adig.c.o.requires

CMakeFiles/adig.dir/adig.c.o.provides: CMakeFiles/adig.dir/adig.c.o.requires
	$(MAKE) -f CMakeFiles/adig.dir/build.make CMakeFiles/adig.dir/adig.c.o.provides.build
.PHONY : CMakeFiles/adig.dir/adig.c.o.provides

CMakeFiles/adig.dir/adig.c.o.provides.build: CMakeFiles/adig.dir/adig.c.o


CMakeFiles/adig.dir/ares_getopt.c.o: CMakeFiles/adig.dir/flags.make
CMakeFiles/adig.dir/ares_getopt.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/adig.dir/ares_getopt.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/adig.dir/ares_getopt.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c

CMakeFiles/adig.dir/ares_getopt.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/adig.dir/ares_getopt.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c > CMakeFiles/adig.dir/ares_getopt.c.i

CMakeFiles/adig.dir/ares_getopt.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/adig.dir/ares_getopt.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c -o CMakeFiles/adig.dir/ares_getopt.c.s

CMakeFiles/adig.dir/ares_getopt.c.o.requires:

.PHONY : CMakeFiles/adig.dir/ares_getopt.c.o.requires

CMakeFiles/adig.dir/ares_getopt.c.o.provides: CMakeFiles/adig.dir/ares_getopt.c.o.requires
	$(MAKE) -f CMakeFiles/adig.dir/build.make CMakeFiles/adig.dir/ares_getopt.c.o.provides.build
.PHONY : CMakeFiles/adig.dir/ares_getopt.c.o.provides

CMakeFiles/adig.dir/ares_getopt.c.o.provides.build: CMakeFiles/adig.dir/ares_getopt.c.o


CMakeFiles/adig.dir/ares_nowarn.c.o: CMakeFiles/adig.dir/flags.make
CMakeFiles/adig.dir/ares_nowarn.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/adig.dir/ares_nowarn.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/adig.dir/ares_nowarn.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c

CMakeFiles/adig.dir/ares_nowarn.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/adig.dir/ares_nowarn.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c > CMakeFiles/adig.dir/ares_nowarn.c.i

CMakeFiles/adig.dir/ares_nowarn.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/adig.dir/ares_nowarn.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c -o CMakeFiles/adig.dir/ares_nowarn.c.s

CMakeFiles/adig.dir/ares_nowarn.c.o.requires:

.PHONY : CMakeFiles/adig.dir/ares_nowarn.c.o.requires

CMakeFiles/adig.dir/ares_nowarn.c.o.provides: CMakeFiles/adig.dir/ares_nowarn.c.o.requires
	$(MAKE) -f CMakeFiles/adig.dir/build.make CMakeFiles/adig.dir/ares_nowarn.c.o.provides.build
.PHONY : CMakeFiles/adig.dir/ares_nowarn.c.o.provides

CMakeFiles/adig.dir/ares_nowarn.c.o.provides.build: CMakeFiles/adig.dir/ares_nowarn.c.o


CMakeFiles/adig.dir/ares_strcasecmp.c.o: CMakeFiles/adig.dir/flags.make
CMakeFiles/adig.dir/ares_strcasecmp.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/adig.dir/ares_strcasecmp.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/adig.dir/ares_strcasecmp.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c

CMakeFiles/adig.dir/ares_strcasecmp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/adig.dir/ares_strcasecmp.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c > CMakeFiles/adig.dir/ares_strcasecmp.c.i

CMakeFiles/adig.dir/ares_strcasecmp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/adig.dir/ares_strcasecmp.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c -o CMakeFiles/adig.dir/ares_strcasecmp.c.s

CMakeFiles/adig.dir/ares_strcasecmp.c.o.requires:

.PHONY : CMakeFiles/adig.dir/ares_strcasecmp.c.o.requires

CMakeFiles/adig.dir/ares_strcasecmp.c.o.provides: CMakeFiles/adig.dir/ares_strcasecmp.c.o.requires
	$(MAKE) -f CMakeFiles/adig.dir/build.make CMakeFiles/adig.dir/ares_strcasecmp.c.o.provides.build
.PHONY : CMakeFiles/adig.dir/ares_strcasecmp.c.o.provides

CMakeFiles/adig.dir/ares_strcasecmp.c.o.provides.build: CMakeFiles/adig.dir/ares_strcasecmp.c.o


# Object files for target adig
adig_OBJECTS = \
"CMakeFiles/adig.dir/adig.c.o" \
"CMakeFiles/adig.dir/ares_getopt.c.o" \
"CMakeFiles/adig.dir/ares_nowarn.c.o" \
"CMakeFiles/adig.dir/ares_strcasecmp.c.o"

# External object files for target adig
adig_EXTERNAL_OBJECTS =

bin/adig: CMakeFiles/adig.dir/adig.c.o
bin/adig: CMakeFiles/adig.dir/ares_getopt.c.o
bin/adig: CMakeFiles/adig.dir/ares_nowarn.c.o
bin/adig: CMakeFiles/adig.dir/ares_strcasecmp.c.o
bin/adig: CMakeFiles/adig.dir/build.make
bin/adig: lib/libcares.a
bin/adig: CMakeFiles/adig.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable bin/adig"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/adig.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/adig.dir/build: bin/adig

.PHONY : CMakeFiles/adig.dir/build

CMakeFiles/adig.dir/requires: CMakeFiles/adig.dir/adig.c.o.requires
CMakeFiles/adig.dir/requires: CMakeFiles/adig.dir/ares_getopt.c.o.requires
CMakeFiles/adig.dir/requires: CMakeFiles/adig.dir/ares_nowarn.c.o.requires
CMakeFiles/adig.dir/requires: CMakeFiles/adig.dir/ares_strcasecmp.c.o.requires

.PHONY : CMakeFiles/adig.dir/requires

CMakeFiles/adig.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/adig.dir/cmake_clean.cmake
.PHONY : CMakeFiles/adig.dir/clean

CMakeFiles/adig.dir/depend:
	cd /local/scylladb/Scylla-moon/seastar/build/release/c-ares && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /local/scylladb/Scylla-moon/seastar/c-ares /local/scylladb/Scylla-moon/seastar/c-ares /local/scylladb/Scylla-moon/seastar/build/release/c-ares /local/scylladb/Scylla-moon/seastar/build/release/c-ares /local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles/adig.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/adig.dir/depend

