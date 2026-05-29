# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)

## Overview

This section documents the setup of the micro-ROS development environment on Ubuntu 22.04 with ROS 2 Humble.

## Prerequisites

* Ubuntu 22.04 LTS
* ROS 2 Humble installed
* Git installed
* Internet connection for downloading dependencies

## Step 1: Source ROS 2 Environment

Load the ROS 2 environment variables.

```bash
source /opt/ros/$ROS_DISTRO/setup.bash
```

## Step 2: Create Workspace

Create and enter the micro-ROS workspace.

```bash
mkdir microros_ws
cd microros_ws
```

## Step 3: Download micro-ROS Setup Package

Clone the micro-ROS setup repository.

```bash
git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup
```

## Step 4: Initialize and Update rosdep

Initialize rosdep and update dependency information.

```bash
sudo rosdep init
sudo apt update && rosdep update
```

## Step 5: Install Required Dependencies

Install all dependencies required by the micro-ROS package.

```bash
rosdep install --from-paths src --ignore-src -y
```

## Step 6: Install Python Package Manager

Install pip for Python package management.

```bash
sudo apt install python3-pip
```

## Step 7: Build the Workspace

Compile the micro-ROS setup package.

```bash
colcon build
```

## Step 8: Source the Built Workspace

Load the newly built workspace environment.

```bash
source install/local_setup.bash
```

## Result

The micro-ROS development environment is successfully configured and ready for creating micro-ROS firmware and agents.
