#!/bin/bash

# ==========================================
#        DEVFORGE SERVER SETUP
# ==========================================

DEVFORGE_DIR="$HOME/devforge"
SCRIPTS_DIR="$DEVFORGE_DIR/scripts"
LOGS_DIR="$DEVFORGE_DIR/logs"
CONFIG_DIR="$DEVFORGE_DIR/config"
TEMP_DIR="$DEVFORGE_DIR/temp"

SETUP_STATUS=0

echo "=========================================="
echo "       DEVFORGE SERVER SETUP"
echo "=========================================="
echo "Started at: $(date '+%Y-%m-%d %H:%M:%S')"
echo

# ------------------------------------------
# 1. Check required commands
# ------------------------------------------

echo "Checking required commands..."

REQUIRED_COMMANDS=("awk" "grep" "find" "systemctl" "df" "free" "top")

for command in "${REQUIRED_COMMANDS[@]}"
do
    if command -v "$command" > /dev/null 2>&1
    then
        echo "$command: PASS"
    else
        echo "$command: FAIL"
        SETUP_STATUS=1
    fi
done

echo

# ------------------------------------------
# 2. Create DevForge directories
# ------------------------------------------

echo "Creating DevForge directories..."

for directory in "$DEVFORGE_DIR" "$SCRIPTS_DIR" "$LOGS_DIR" "$CONFIG_DIR" "$TEMP_DIR"
do
    if mkdir -p "$directory"
    then
        echo "$directory: PASS"
    else
        echo "$directory: FAIL"
        SETUP_STATUS=1
    fi
done

echo

# ------------------------------------------
# 3. Set permissions
# ------------------------------------------

echo "Setting permissions..."

if chmod 755 "$SCRIPTS_DIR"
then
    echo "Scripts directory permissions: PASS"
else
    echo "Scripts directory permissions: FAIL"
    SETUP_STATUS=1
fi

if chmod 755 "$LOGS_DIR" "$CONFIG_DIR" "$TEMP_DIR"
then
    echo "Project directory permissions: PASS"
else
    echo "Project directory permissions: FAIL"
    SETUP_STATUS=1
fi

echo

# ------------------------------------------
# 4. Create configuration file
# ------------------------------------------

CONFIG_FILE="$CONFIG_DIR/devforge.conf"

if [[ ! -f "$CONFIG_FILE" ]]
then
    if cat > "$CONFIG_FILE" <<EOF
# DevForge Configuration

DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
CPU_THRESHOLD=80
LOG_RETENTION_DAYS=7
EOF
    then
        echo "Configuration file created: PASS"
    else
        echo "Configuration file creation: FAIL"
        SETUP_STATUS=1
    fi
else
    echo "Configuration file already exists: SKIPPED"
fi

echo

# ------------------------------------------
# 5. Verify directories
# ------------------------------------------

echo "Verifying DevForge environment..."

for directory in "$DEVFORGE_DIR" "$SCRIPTS_DIR" "$LOGS_DIR" "$CONFIG_DIR" "$TEMP_DIR"
do
    if [[ -d "$directory" ]]
    then
        echo "$directory: PASS"
    else
        echo "$directory: FAIL"
        SETUP_STATUS=1
    fi
done

echo

# ------------------------------------------
# 6. Final status
# ------------------------------------------

echo "=========================================="

if [[ $SETUP_STATUS -eq 0 ]]
then
    echo "DevForge Server Setup: SUCCESS"
    echo "Completed at: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=========================================="
    exit 0
else
    echo "DevForge Server Setup: FAILED"
    echo "Completed at: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=========================================="
    exit 1
fi
