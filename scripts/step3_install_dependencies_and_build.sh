#!/bin/bash
# =============================================================================
# STEP 3: Install Dependencies & Build Workspace
# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)
# =============================================================================
# This script:
#   - Updates apt and rosdep databases
#   - Installs all micro-ROS package dependencies via rosdep
#   - Builds the workspace with colcon
# =============================================================================

set -e

echo ""
echo "============================================================"
echo "  STEP 3: Install Dependencies & Build Workspace"
echo "============================================================"

# ── Load saved environment ────────────────────────────────────────
if [ -f "$HOME/.microros_env" ]; then
    source "$HOME/.microros_env"
    echo "     Loaded environment: $HOME/.microros_env"
else
    MICROROS_WS="$HOME/microros_ws"
    echo "     Using default workspace: $MICROROS_WS"
fi

# Ensure ROS 2 is sourced
if [ -z "$ROS_DISTRO" ]; then
    source /opt/ros/humble/setup.bash
fi
source /opt/ros/$ROS_DISTRO/setup.bash

# Move into workspace
cd "$MICROROS_WS"
echo "     Working directory: $(pwd)"

# ── 3.1 Update apt and rosdep ────────────────────────────────────
echo ""
echo "[1/3] Updating apt package lists and rosdep database..."
sudo apt update && rosdep update
echo "✔ Package lists and rosdep updated."

# ── 3.2 Install ROS Dependencies ─────────────────────────────────
echo ""
echo "[2/3] Installing all required dependencies (rosdep)..."
rosdep install --from-paths src --ignore-src -y
echo "✔ All dependencies installed."

# ── 3.3 Build the Workspace ──────────────────────────────────────
echo ""
echo "[3/3] Building the micro-ROS workspace with colcon..."
echo "     This may take a few minutes..."
colcon build

echo ""
echo "============================================================"
echo "  ✅ STEP 3 COMPLETE: Workspace built successfully!"
echo "     Directories created:"
ls -1 "$MICROROS_WS"
echo "     Next → Run: step4_create_agent.sh"
echo "============================================================"
echo ""
