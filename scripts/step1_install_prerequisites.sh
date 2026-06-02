#!/bin/bash
# =============================================================================
# STEP 1: Install Prerequisites
# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)
# =============================================================================
# This script installs all required system tools before setting up micro-ROS:
#   - Git
#   - Colcon (ROS 2 build system)
#   - rosdep (dependency manager)
#   - pip (Python package manager)
#   - vcstool (ROS repository manager)
# =============================================================================

set -e  # Exit immediately if any command fails

echo ""
echo "============================================================"
echo "  STEP 1: Installing Prerequisites"
echo "============================================================"

# ── 1.1 Update System Packages ───────────────────────────────────
echo ""
echo "[1/6] Updating system packages..."
sudo apt update
sudo apt upgrade -y
echo "✔ System packages updated."

# ── 1.2 Install Git ──────────────────────────────────────────────
echo ""
echo "[2/6] Installing Git..."
sudo apt install git -y
echo "✔ Git installed: $(git --version)"

# ── 1.3 Install Colcon ───────────────────────────────────────────
echo ""
echo "[3/6] Installing Colcon (ROS 2 build system)..."
sudo apt install python3-colcon-common-extensions -y
echo "✔ Colcon installed successfully."

# ── 1.4 Install rosdep ───────────────────────────────────────────
echo ""
echo "[4/6] Installing rosdep (dependency manager)..."
sudo apt install python3-rosdep -y

# Initialize rosdep only if not already done
if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then
    echo "     Initializing rosdep..."
    sudo rosdep init
else
    echo "     rosdep already initialized, skipping init."
fi
rosdep update
echo "✔ rosdep installed and initialized."

# ── 1.5 Install pip ──────────────────────────────────────────────
echo ""
echo "[5/6] Installing pip (Python package manager)..."
sudo apt install python3-pip -y
echo "✔ pip installed: $(pip3 --version)"

# ── 1.6 Install vcstool ──────────────────────────────────────────
echo ""
echo "[6/6] Installing vcstool (ROS repository manager)..."
sudo apt install python3-vcstool -y
echo "✔ vcstool installed successfully."

echo ""
echo "============================================================"
echo "  ✅ STEP 1 COMPLETE: All prerequisites installed!"
echo "     Next → Run: step2_setup_workspace.sh"
echo "============================================================"
echo ""
