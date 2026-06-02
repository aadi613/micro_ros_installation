#!/bin/bash
# =============================================================================
# STEP 5: Run micro-ROS Agent
# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)
# =============================================================================
# This script launches the micro-ROS Agent which bridges your microcontroller
# (ESP32, STM32, Arduino, etc.) to ROS 2 via serial, UDP, or TCP transport.
#
# USAGE:
#   ./step5_run_agent.sh [transport] [port/ip] [baudrate]
#
# EXAMPLES:
#   ./step5_run_agent.sh serial /dev/ttyUSB0 115200   # Serial (ESP32)
#   ./step5_run_agent.sh udp4   8888                  # UDP
#   ./step5_run_agent.sh tcp4   8888                  # TCP
#
# DEFAULTS: serial /dev/ttyUSB0 115200
# =============================================================================

set -e

# ── Parse Arguments ───────────────────────────────────────────────
TRANSPORT="${1:-serial}"
PORT="${2:-/dev/ttyUSB0}"
BAUDRATE="${3:-115200}"

echo ""
echo "============================================================"
echo "  STEP 5: Run micro-ROS Agent"
echo "============================================================"
echo "  Transport : $TRANSPORT"
if [ "$TRANSPORT" == "serial" ]; then
echo "  Port      : $PORT"
echo "  Baud Rate : $BAUDRATE"
else
echo "  Port      : $PORT"
fi
echo "============================================================"

# ── Load environment ──────────────────────────────────────────────
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

# Source the micro-ROS workspace
source "$MICROROS_WS/install/local_setup.bash"
echo "✔ Environments sourced."

cd "$MICROROS_WS"

# ── Launch Agent ──────────────────────────────────────────────────
echo ""
echo "🚀 Launching micro-ROS Agent..."
echo "   Press Ctrl+C to stop."
echo ""

case "$TRANSPORT" in
    serial)
        ros2 run micro_ros_agent micro_ros_agent serial --dev "$PORT" -b "$BAUDRATE"
        ;;
    udp4)
        ros2 run micro_ros_agent micro_ros_agent udp4 --port "$PORT"
        ;;
    udp6)
        ros2 run micro_ros_agent micro_ros_agent udp6 --port "$PORT"
        ;;
    tcp4)
        ros2 run micro_ros_agent micro_ros_agent tcp4 --port "$PORT"
        ;;
    tcp6)
        ros2 run micro_ros_agent micro_ros_agent tcp6 --port "$PORT"
        ;;
    *)
        echo "❌ Unknown transport: $TRANSPORT"
        echo "   Supported: serial | udp4 | udp6 | tcp4 | tcp6"
        exit 1
        ;;
esac
