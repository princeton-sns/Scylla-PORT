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
include CMakeFiles/ahost.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ahost.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ahost.dir/flags.make

CMakeFiles/ahost.dir/ahost.c.o: CMakeFiles/ahost.dir/flags.make
CMakeFiles/ahost.dir/ahost.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ahost.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/ahost.dir/ahost.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ahost.dir/ahost.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ahost.c

CMakeFiles/ahost.dir/ahost.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ahost.dir/ahost.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ahost.c > CMakeFiles/ahost.dir/ahost.c.i

CMakeFiles/ahost.dir/ahost.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ahost.dir/ahost.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ahost.c -o CMakeFiles/ahost.dir/ahost.c.s

CMakeFiles/ahost.dir/ahost.c.o.requires:

.PHONY : CMakeFiles/ahost.dir/ahost.c.o.requires

CMakeFiles/ahost.dir/ahost.c.o.provides: CMakeFiles/ahost.dir/ahost.c.o.requires
	$(MAKE) -f CMakeFiles/ahost.dir/build.make CMakeFiles/ahost.dir/ahost.c.o.provides.build
.PHONY : CMakeFiles/ahost.dir/ahost.c.o.provides

CMakeFiles/ahost.dir/ahost.c.o.provides.build: CMakeFiles/ahost.dir/ahost.c.o


CMakeFiles/ahost.dir/ares_getopt.c.o: CMakeFiles/ahost.dir/flags.make
CMakeFiles/ahost.dir/ares_getopt.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/ahost.dir/ares_getopt.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ahost.dir/ares_getopt.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c

CMakeFiles/ahost.dir/ares_getopt.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ahost.dir/ares_getopt.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c > CMakeFiles/ahost.dir/ares_getopt.c.i

CMakeFiles/ahost.dir/ares_getopt.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ahost.dir/ares_getopt.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ares_getopt.c -o CMakeFiles/ahost.dir/ares_getopt.c.s

CMakeFiles/ahost.dir/ares_getopt.c.o.requires:

.PHONY : CMakeFiles/ahost.dir/ares_getopt.c.o.requires

CMakeFiles/ahost.dir/ares_getopt.c.o.provides: CMakeFiles/ahost.dir/ares_getopt.c.o.requires
	$(MAKE) -f CMakeFiles/ahost.dir/build.make CMakeFiles/ahost.dir/ares_getopt.c.o.provides.build
.PHONY : CMakeFiles/ahost.dir/ares_getopt.c.o.provides

CMakeFiles/ahost.dir/ares_getopt.c.o.provides.build: CMakeFiles/ahost.dir/ares_getopt.c.o


CMakeFiles/ahost.dir/ares_nowarn.c.o: CMakeFiles/ahost.dir/flags.make
CMakeFiles/ahost.dir/ares_nowarn.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/ahost.dir/ares_nowarn.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ahost.dir/ares_nowarn.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c

CMakeFiles/ahost.dir/ares_nowarn.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ahost.dir/ares_nowarn.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c > CMakeFiles/ahost.dir/ares_nowarn.c.i

CMakeFiles/ahost.dir/ares_nowarn.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ahost.dir/ares_nowarn.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ares_nowarn.c -o CMakeFiles/ahost.dir/ares_nowarn.c.s

CMakeFiles/ahost.dir/ares_nowarn.c.o.requires:

.PHONY : CMakeFiles/ahost.dir/ares_nowarn.c.o.requires

CMakeFiles/ahost.dir/ares_nowarn.c.o.provides: CMakeFiles/ahost.dir/ares_nowarn.c.o.requires
	$(MAKE) -f CMakeFiles/ahost.dir/build.make CMakeFiles/ahost.dir/ares_nowarn.c.o.provides.build
.PHONY : CMakeFiles/ahost.dir/ares_nowarn.c.o.provides

CMakeFiles/ahost.dir/ares_nowarn.c.o.provides.build: CMakeFiles/ahost.dir/ares_nowarn.c.o


CMakeFiles/ahost.dir/ares_strcasecmp.c.o: CMakeFiles/ahost.dir/flags.make
CMakeFiles/ahost.dir/ares_strcasecmp.c.o: /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/ahost.dir/ares_strcasecmp.c.o"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ahost.dir/ares_strcasecmp.c.o   -c /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c

CMakeFiles/ahost.dir/ares_strcasecmp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ahost.dir/ares_strcasecmp.c.i"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c > CMakeFiles/ahost.dir/ares_strcasecmp.c.i

CMakeFiles/ahost.dir/ares_strcasecmp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ahost.dir/ares_strcasecmp.c.s"
	/usr/bin/gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /local/scylladb/Scylla-moon/seastar/c-ares/ares_strcasecmp.c -o CMakeFiles/ahost.dir/ares_strcasecmp.c.s

CMakeFiles/ahost.dir/ares_strcasecmp.c.o.requires:

.PHONY : CMakeFiles/ahost.dir/ares_strcasecmp.c.o.requires

CMakeFiles/ahost.dir/ares_strcasecmp.c.o.provides: CMakeFiles/ahost.dir/ares_strcasecmp.c.o.requires
	$(MAKE) -f CMakeFiles/ahost.dir/build.make CMakeFiles/ahost.dir/ares_strcasecmp.c.o.provides.build
.PHONY : CMakeFiles/ahost.dir/ares_strcasecmp.c.o.provides

CMakeFiles/ahost.dir/ares_strcasecmp.c.o.provides.build: CMakeFiles/ahost.dir/ares_strcasecmp.c.o


# Object files for target ahost
ahost_OBJECTS = \
"CMakeFiles/ahost.dir/ahost.c.o" \
"CMakeFiles/ahost.dir/ares_getopt.c.o" \
"CMakeFiles/ahost.dir/ares_nowarn.c.o" \
"CMakeFiles/ahost.dir/ares_strcasecmp.c.o"

# External object files for target ahost
ahost_EXTERNAL_OBJECTS =

bin/ahost: CMakeFiles/ahost.dir/ahost.c.o
bin/ahost: CMakeFiles/ahost.dir/ares_getopt.c.o
bin/ahost: CMakeFiles/ahost.dir/ares_nowarn.c.o
bin/ahost: CMakeFiles/ahost.dir/ares_strcasecmp.c.o
bin/ahost: CMakeFiles/ahost.dir/build.make
bin/ahost: lib/libcares.a
bin/ahost: CMakeFiles/ahost.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable bin/ahost"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ahost.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ahost.dir/build: bin/ahost

.PHONY : CMakeFiles/ahost.dir/build

CMakeFiles/ahost.dir/requires: CMakeFiles/ahost.dir/ahost.c.o.requires
CMakeFiles/ahost.dir/requires: CMakeFiles/ahost.dir/ares_getopt.c.o.requires
CMakeFiles/ahost.dir/requires: CMakeFiles/ahost.dir/ares_nowarn.c.o.requires
CMakeFiles/ahost.dir/requires: CMakeFiles/ahost.dir/ares_strcasecmp.c.o.requires

.PHONY : CMakeFiles/ahost.dir/requires

CMakeFiles/ahost.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ahost.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ahost.dir/clean

CMakeFiles/ahost.dir/depend:
	cd /local/scylladb/Scylla-moon/seastar/build/release/c-ares && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /local/scylladb/Scylla-moon/seastar/c-ares /local/scylladb/Scylla-moon/seastar/c-ares /local/scylladb/Scylla-moon/seastar/build/release/c-ares /local/scylladb/Scylla-moon/seastar/build/release/c-ares /local/scylladb/Scylla-moon/seastar/build/release/c-ares/CMakeFiles/ahost.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ahost.dir/depend
