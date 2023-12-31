cmake_minimum_required(VERSION 2.8.3)
project(prometheus_drl)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

set (CMAKE_CXX_STANDARD 11)
## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  message_generation  
  roscpp
  geometry_msgs
  nav_msgs
  sensor_msgs
  mavros
  std_msgs
  std_srvs
  tf
  tf2_ros
  tf2_eigen
  mavros_msgs
  laser_geometry
  pcl_ros
  prometheus_msgs
)

## System dependencies are found with CMake's conventions
find_package(Boost REQUIRED COMPONENTS system)
find_package(PCL REQUIRED)

################################################
## Declare ROS messages, services and actions ##
################################################

## Generate added messages and services with any dependencies listed here
add_message_files(
  DIRECTORY msg
  FILES
  move_cmd.msg
  agent_state.msg
  agent_reset.msg
)

generate_messages(
  DEPENDENCIES
  geometry_msgs 
  nav_msgs
  sensor_msgs
  std_msgs
)

catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS  message_runtime
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  ../common/include
)


###############################
##      声明可执行cpp文件     ##
###############################

add_executable(drl_main_node
	src/drl_main_node.cpp
  src/drl_actuator.cpp
	src/drl_sensing.cpp
	src/occupy_map_2d.cpp
	)

target_link_libraries(drl_main_node
    ${catkin_LIBRARIES}
	  ${PCL_LIBRARIES}
	)

add_executable(terminal_control src/terminal_control.cpp)
add_dependencies(terminal_control prometheus_drl_gencpp)
target_link_libraries(terminal_control ${catkin_LIBRARIES})

add_executable(collect src/collect.cpp)
add_dependencies(collect prometheus_drl_gencpp)
target_link_libraries(collect ${catkin_LIBRARIES})

add_executable(read_agent_state src/read_agent_state.cpp)
add_dependencies(read_agent_state prometheus_drl_gencpp)
target_link_libraries(read_agent_state ${catkin_LIBRARIES})

add_executable(scan_change src/scan_change.cpp)
add_dependencies(scan_change prometheus_drl_gencpp)
target_link_libraries(scan_change ${catkin_LIBRARIES})

add_executable (map_generator src/map_generator.cpp )
target_link_libraries(map_generator
  ${catkin_LIBRARIES}
  ${PCL_LIBRARIES})

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS ${PROJECT_NAME} ${PROJECT_NAME}_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark cpp header files for installation
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
)

## Mark other files for installation (e.g. launch and bag files, etc.)
install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_prometheus_swarm_control.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
