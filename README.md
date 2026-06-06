# micro-ROS Setup inside Docker Container (ROS 2 Humble)

## Prerequisites
- Docker installed
- ROS 2 Humble container running

## Installation Steps

### Step 0: Enter the Docker Container
Get inside the running container before running any commands.
```bash
docker exec -it <container_name> bash
```

### Step 1: Source ROS 2 Environment
Load the ROS 2 environment variables into the current shell session.
```bash
source /opt/ros/$ROS_DISTRO/setup.bash
```

### Step 2: Create Workspace
Create the micro-ROS workspace directory and navigate into it.
```bash
mkdir microros_ws && cd microros_ws
```

### Step 3: Clone micro-ROS Setup Package
Download the micro-ROS setup repository matching your ROS 2 distro version.
```bash
git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup
```

### Step 4: Initialize rosdep
Initialize rosdep for dependency management. *(Safe to ignore if already initialized)*
```bash
sudo rosdep init
```

### Step 5: Update Package Lists and rosdep
Refresh apt package index and update rosdep's dependency database.
```bash
sudo apt update && rosdep update
```

### Step 6: Install Dependencies
Install all packages required by the micro-ROS setup.
```bash
rosdep install --from-paths src --ignore-src -y
```

### Step 7: Install pip
Install Python package manager needed for micro-ROS build tools.
```bash
sudo apt install python3-pip -y
```

### Step 8: Build the Workspace
Compile the micro-ROS setup package using colcon. *(This may take a few minutes)*
```bash
colcon build
```

### Step 9: Source the Built Workspace
Load the newly built workspace environment into the current shell session.
```bash
source install/local_setup.bash
```

---

> ⚠️ **Note:** Sourcing is lost every time you exit the container. To make it permanent inside the container:
> ```bash
> echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
> echo "source ~/microros_ws/install/local_setup.bash" >> ~/.bashrc
> ```
