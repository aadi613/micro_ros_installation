#!/bin/bash
# =============================================================================
# STEP 2: Verify ROS 2 & Create micro-ROS Workspace
# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)
# =============================================================================
# This script:
#   - Verifies ROS 2 Humble is installed and sourced
#   - Sources the ROS 2 environment
#   - Creates the microros_ws workspace
#   - Clones the micro-ROS setup repository
# =============================================================================

set -e

echo ""
echo "============================================================"
echo "  STEP 2: Verify ROS 2 & Create Workspace"
echo "============================================================"

# ── 2.1 Verify ROS 2 is installed ────────────────────────────────
echo ""
echo "[1/4] Checking ROS 2 installation..."

if [ -z "$ROS_DISTRO" ]; then
    echo "     ROS_DISTRO not set. Attempting to source ROS 2 Humble..."
    if [ -f /opt/ros/humble/setup.bash ]; then
        source /opt/ros/humble/setup.bash
        echo "     Sourced: /opt/ros/humble/setup.bash"
    else
        echo "❌ ERROR: ROS 2 Humble not found at /opt/ros/humble/"
        echo "   Please install ROS 2 Humble first:"
        echo "   https://docs.ros.org/en/humble/Installation.html"
        exit 1
    fi
fi

echo "✔ ROS 2 Distribution: $ROS_DISTRO"

# ── 2.2 Source ROS 2 Environment ─────────────────────────────────
echo ""
echo "[2/4] Sourcing ROS 2 environment..."
source /opt/ros/$ROS_DISTRO/setup.bash
echo "✔ ROS 2 environment sourced."

# ── 2.3 Create Workspace ─────────────────────────────────────────
echo ""
echo "[3/4] Creating micro-ROS workspace..."

WORKSPACE_DIR="$HOME/microros_ws"

if [ -d "$WORKSPACE_DIR" ]; then
    echo "     Workspace already exists at: $WORKSPACE_DIR"
    echo "     Skipping workspace creation."
else
    mkdir -p "$WORKSPACE_DIR"
    echo "✔ Workspace created at: $WORKSPACE_DIR"
fi

cd "$WORKSPACE_DIR"
echo "     Working directory: $(pwd)"

# ── 2.4 Clone micro-ROS Setup Repository ─────────────────────────
echo ""
echo "[4/4] Cloning micro-ROS setup repository (branch: $ROS_DISTRO)..."

if [ -d "src/micro_ros_setup" ]; then
    echo "     micro_ros_setup already cloned. Skipping."
else
    git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup
    echo "✔ micro_ros_setup cloned into: $WORKSPACE_DIR/src/micro_ros_setup"
fi

echo ""
echo "============================================================"
echo "  ✅ STEP 2 COMPLETE: Workspace created!"
echo "     Location : $WORKSPACE_DIR"
echo "     Next → Run: step3_install_dependencies.sh"
echo "============================================================"
echo ""

# Export workspace path for subsequent scripts
echo "export MICROROS_WS=$WORKSPACE_DIR" > "$HOME/.microros_env"
echo "export ROS_DISTRO=$ROS_DISTRO"     >> "$HOME/.microros_env"
echo "     (Saved workspace env to ~/.microros_env)"
