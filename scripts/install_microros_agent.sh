#!/bin/bash
# =============================================================================
# MASTER SCRIPT: Full micro-ROS Agent Installation (Steps 1–4)
# micro-ROS Setup on Ubuntu 22.04 (ROS 2 Humble)
# =============================================================================
# Runs all setup steps in sequence:
#   Step 1 → Install system prerequisites
#   Step 2 → Verify ROS 2 & create workspace
#   Step 3 → Install dependencies & build workspace
#   Step 4 → Create & build micro-ROS Agent
#
# After this script completes, use step5_run_agent.sh to start the agent.
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_banner() {
    echo ""
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║        micro-ROS Agent - Full Installation               ║"
    echo "║        Ubuntu 22.04 + ROS 2 Humble                      ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo ""
}

print_step() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  ▶  $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

print_banner

# ── Confirm before starting ───────────────────────────────────────
echo "This will install micro-ROS Agent on your system."
echo "Estimated time: 10–20 minutes (depending on internet speed)."
echo ""
read -p "Proceed? [y/N] " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Installation cancelled."
    exit 0
fi

START_TIME=$(date +%s)

# ── Step 1 ────────────────────────────────────────────────────────
print_step "STEP 1/4 — Installing Prerequisites"
bash "$SCRIPT_DIR/step1_install_prerequisites.sh"

# ── Step 2 ────────────────────────────────────────────────────────
print_step "STEP 2/4 — Setting Up Workspace"
bash "$SCRIPT_DIR/step2_setup_workspace.sh"

# ── Step 3 ────────────────────────────────────────────────────────
print_step "STEP 3/4 — Installing Dependencies & Building Workspace"
bash "$SCRIPT_DIR/step3_install_dependencies_and_build.sh"

# ── Step 4 ────────────────────────────────────────────────────────
print_step "STEP 4/4 — Creating & Building micro-ROS Agent"
bash "$SCRIPT_DIR/step4_create_agent.sh"

# ── Done ──────────────────────────────────────────────────────────
END_TIME=$(date +%s)
ELAPSED=$(( END_TIME - START_TIME ))
MINUTES=$(( ELAPSED / 60 ))
SECONDS=$(( ELAPSED % 60 ))

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅  micro-ROS Agent Installation COMPLETE!             ║"
echo "║                                                          ║"
echo "║  Time taken: ${MINUTES}m ${SECONDS}s                                   ║"
echo "║                                                          ║"
echo "║  To launch the Agent:                                    ║"
echo "║    Serial (ESP32):                                       ║"
echo "║      ./step5_run_agent.sh serial /dev/ttyUSB0 115200    ║"
echo "║    UDP:                                                  ║"
echo "║      ./step5_run_agent.sh udp4 8888                     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
