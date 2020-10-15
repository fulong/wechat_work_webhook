cmake_minimum_required(VERSION 2.8)
set(BUILD_PROJECT_NAME "linux_cmake_template")
project(${BUILD_PROJECT_NAME})

set( CMAKE_VERBOSE_MAKEFILE on )

add_definitions(
		-DPOSIX
		-DUSE_LINUX
		-D_DEBUG
)

set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
set(CMAKE_C_FLAGS "-std=gnu99 ${CMAKE_C_FLAGS}")

if(NOT "${GCC_NAME}" STREQUAL  "")
	set(OPENSSL_EXTERN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/doc/share/openssl-${GCC_NAME}/)
	set(MOSQUITTO_EXTERN_DIR ${PROJECT_SOURCE_DIR}/doc/share/mosquitto-${GCC_NAME}/)

	if("${GCC_NAME}" STREQUAL "Sourcery-G++-Lite-2008q3-72")
		set(CMAKE_C_FLAGS "-march=armv4t ${CMAKE_C_FLAGS}")
	endif()
endif()

set(LINUX_CMAKE_TEMPLATE_INCLUDE_DIR
)

##2 LIBRARY PATH
message(STATUS "Step 2 :  Add library path and public link library")
	message(STATUS "       LINUX")
	set(LINUX_CMAKE_TEMPLATE_LIBRARY_DIR
			)
	set(LINUX_CMAKE_TEMPLATE_LINK_LIB
		)

include_directories(${LINUX_CMAKE_TEMPLATE_INCLUDE_DIR})
link_directories(${LINUX_CMAKE_TEMPLATE_LIBRARY_DIR})
#####################################################################
# Step 3 :Set visual studio runtime type
if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  "${PROJECT_SOURCE_DIR}/bin/debug/unix/${ARCH}/")
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  "${PROJECT_SOURCE_DIR}/bin/debug/unix/${ARCH}/")
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  "${PROJECT_SOURCE_DIR}/bin/debug/unix/${ARCH}/")
endif()
if(${CMAKE_BUILD_TYPE} STREQUAL "Release")
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  "${PROJECT_SOURCE_DIR}/bin/release/unix/${ARCH}/")
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  "${PROJECT_SOURCE_DIR}/bin/release/unix/${ARCH}/")
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  "${PROJECT_SOURCE_DIR}/bin/release/unix/${ARCH}/")
endif()


#########################################################################
#Step 4 : Add PROJECT define 
message(STATUS "Step 4 : Add code source")

#add_subdirectory(dep/zlog)
#add_subdirectory(dep/libevent)

set(SRC_LIST
		${CMAKE_CURRENT_SOURCE_DIR}/src/main/linux_cmake_template_main.c
        src/main/linux_cmake_template_main.h)
#########################################################################
#Step 5 : Add executable or library target
add_executable(${BUILD_PROJECT_NAME} ${SRC_LIST})

if(NOT ("${LINUX_CMAKE_TEMPLATE_LINK_LIB}" STREQUAL ""))
	target_link_libraries(${BUILD_PROJECT_NAME}
		${LINUX_CMAKE_TEMPLATE_LINK_LIB}
	)
endif()