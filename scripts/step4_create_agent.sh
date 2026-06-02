#!/bin/bash
# =============================================================================
# STEP 4: Create & Build micro-ROS Agent
# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)
# =============================================================================
# The micro-ROS Agent acts as a bridge between microcontrollers (e.g., ESP32,
# STM32) and ROS 2. This script:
#   - Sources the built micro-ROS workspace
#   - Creates a micro-ROS Agent firmware workspace
#   - Downloads the micro-ROS Agent source
#   - Builds the Agent
# =============================================================================

set -e

echo ""
echo "============================================================"
echo "  STEP 4: Create & Build micro-ROS Agent"
echo "============================================================"

# ── Load saved environment ────────────────────────────────────────
if [ -f "$HOME/.microros_env" ]; then
    source "$HOME/.microros_env"
else
    MICROROS_WS="$HOME/microros_ws"
fi

# Source ROS 2
if [ -z "$ROS_DISTRO" ]; then
    source /opt/ros/humble/setup.bash
fi
source /opt/ros/$ROS_DISTRO/setup.bash

# Source the micro-ROS workspace built in Step 3
echo ""
echo "[0/4] Sourcing micro-ROS workspace..."
source "$MICROROS_WS/install/local_setup.bash"
echo "✔ micro-ROS workspace sourced."

cd "$MICROROS_WS"

# ── 4.1 Create micro-ROS Agent firmware workspace ─────────────────
echo ""
echo "[1/4] Creating micro-ROS Agent firmware workspace..."
ros2 run micro_ros_setup create_agent_fw.sh
echo "✔ Agent firmware workspace created."

# ── 4.2 Download micro-ROS Agent source ──────────────────────────
echo ""
echo "[2/4] Downloading micro-ROS Agent source..."
ros2 run micro_ros_setup download_agent_packages.sh
echo "✔ Agent packages downloaded."

# ── 4.3 Install Agent dependencies ───────────────────────────────
echo ""
echo "[3/4] Installing Agent dependencies..."
sudo apt update && rosdep update
rosdep install --from-paths src --ignore-src -y
echo "✔ Agent dependencies installed."

# ── 4.4 Build the Agent ───────────────────────────────────────────
echo ""
echo "[4/4] Building the micro-ROS Agent..."
echo "     This may take several minutes..."
colcon build
echo "✔ micro-ROS Agent built successfully."

echo ""
echo "============================================================"
echo "  ✅ STEP 4 COMPLETE: micro-ROS Agent is built!"
echo "     Next → Run: step5_run_agent.sh"
echo "============================================================"
echo ""
