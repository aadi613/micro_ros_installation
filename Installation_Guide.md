# Installation Guide - micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)

## Introduction

This guide explains how to set up a micro-ROS workspace on Ubuntu 22.04 with ROS 2 Humble.

The guide is intended for beginners who are using ROS 2 and Ubuntu for the first time.

---

# Prerequisites

Before starting, ensure that:

* Ubuntu 22.04 LTS is installed.
* ROS 2 Humble is installed.
* An internet connection is available.
* You have access to a terminal.

---

# Software Installation

Install the required tools before setting up micro-ROS.

## Update System Packages

```bash
sudo apt update
sudo apt upgrade -y
```

Purpose:

* Updates package information.
* Upgrades installed packages.

---

## Install Git

Git is used to download repositories from GitHub.

```bash
sudo apt install git -y
```

Verify installation:

```bash
git --version
```

Expected Result:

```text
git version x.x.x
```

---

## Install Colcon

Colcon is the build system used by ROS 2.

```bash
sudo apt install python3-colcon-common-extensions -y
```

Verify installation:

```bash
colcon --help
```

---

## Install rosdep

rosdep automatically installs required package dependencies.

```bash
sudo apt install python3-rosdep -y
```

Initialize rosdep:

```bash
sudo rosdep init
rosdep update
```

Note:

* `rosdep init` only needs to be run once per system.

---

## Install pip

pip is the Python package manager.

```bash
sudo apt install python3-pip -y
```

Verify installation:

```bash
pip3 --version
```

---

## Install vcstool

vcstool helps manage ROS repositories.

```bash
sudo apt install python3-vcstool -y
```

Verify installation:

```bash
vcs --help
```

---

# Step 1: Verify ROS 2 Installation

Check whether ROS 2 Humble is installed correctly.

```bash
echo $ROS_DISTRO
```

Expected Result:

```text
humble
```

If nothing is displayed, source ROS 2:

```bash
source /opt/ros/humble/setup.bash
```

---

# Step 2: Source the ROS 2 Environment

Load ROS 2 environment variables into the current terminal.

```bash
source /opt/ros/$ROS_DISTRO/setup.bash
```

Expected Result:

* No output indicates successful execution.

---

# Step 3: Create a Workspace

Create a new workspace for micro-ROS.

```bash
mkdir microros_ws
cd microros_ws
```

Expected Result:

* Workspace directory is created.
* Terminal enters the workspace.

---

# Step 4: Download the micro-ROS Setup Package

Clone the micro-ROS setup repository.

```bash
git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup
```

Expected Result:

* Repository is downloaded into the `src` folder.

---

# Step 5: Update Package Information

Update Ubuntu package lists and rosdep database.

```bash
sudo apt update && rosdep update
```

Expected Result:

* Package lists are updated.
* rosdep database is refreshed.

---

# Step 6: Install Dependencies

Install all dependencies required by micro-ROS.

```bash
rosdep install --from-paths src --ignore-src -y
```

Expected Result:

* Required packages are downloaded and installed.

---

# Step 7: Build the Workspace

Compile the micro-ROS setup package.

```bash
colcon build
```

Expected Result:

* Build completes successfully.
* `build`, `install`, and `log` directories are created.

---

# Step 8: Source the Workspace

Load the newly built workspace.

```bash
source install/local_setup.bash
```

Expected Result:

* Workspace environment is available in the current terminal.

---

# Verification

Verify that the workspace was created successfully.

```bash
ls
```

Expected Result:

```text
build
install
log
src
```

---

# Common Errors and Solutions

## Error: rosdep not initialized

Message:

```text
ERROR: your rosdep installation has not been initialized yet.
```

Solution:

```bash
sudo rosdep init
rosdep update
```

---

## Error: colcon command not found

Solution:

```bash
sudo apt install python3-colcon-common-extensions
```

---

## Error: git command not found

Solution:

```bash
sudo apt install git
```

---

## Error: pip3 command not found

Solution:

```bash
sudo apt install python3-pip
```

---

## Error: Internet Connection Issues

If package installation fails:

```bash
sudo apt update
```

Verify that the system is connected to the internet and try again.

---

# Conclusion

The micro-ROS development environment has now been successfully configured on Ubuntu 22.04 with ROS 2 Humble.

You are now ready to:

* Create micro-ROS firmware workspaces
* Build micro-ROS applications
* Connect ESP32 and other microcontrollers
* Run the micro-ROS Agent
* Integrate microcontrollers with ROS 2 systems

