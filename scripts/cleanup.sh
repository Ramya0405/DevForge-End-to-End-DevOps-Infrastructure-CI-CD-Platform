#!/bin/bash

#!/bin/bash

# ==========================================
#        DEVFORGE CLEANUP SCRIPT
# ==========================================

LOG_DIR="$HOME/devforge/logs"
TEMP_DIR="$HOME/devforge/temp"
RETENTION_DAYS=7

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "=========================================="
echo "       DEVFORGE CLEANUP"
echo "=========================================="
echo "Started at: $TIMESTAMP"
echo

cleanup_status=0

# ------------------------------------------
# Check and clean old log files
# ------------------------------------------

if [[ -d "$LOG_DIR" ]]
then
    echo "Checking old log files..."

    OLD_LOGS=$(find "$LOG_DIR" -type f -mtime +$RETENTION_DAYS)

    if [[ -n "$OLD_LOGS" ]]
    then
        echo "Old log files found:"
        echo "$OLD_LOGS"

        if find "$LOG_DIR" -type f -mtime +$RETENTION_DAYS -delete
        then
            echo "Old log files cleaned successfully."
        else
            echo "ERROR: Failed to delete old log files."
            cleanup_status=1
        fi
    else
        echo "No old log files found."
    fi
else
    echo "Log directory does not exist. Skipping log cleanup."
fi

echo

# ------------------------------------------
# Check and clean temporary files
# ------------------------------------------

if [[ -d "$TEMP_DIR" ]]
then
    echo "Cleaning temporary files..."

    if find "$TEMP_DIR" -type f -delete
    then
        echo "Temporary files cleaned successfully."
    else
        echo "ERROR: Failed to clean temporary files."
        cleanup_status=1
    fi
else
    echo "Temporary directory does not exist. Skipping temp cleanup."
fi

echo
echo "Cleanup completed at: $(date "+%Y-%m-%d %H:%M:%S")"
echo

# ------------------------------------------
# Final status
# ------------------------------------------

if [[ $cleanup_status -eq 0 ]]
then
    echo "Overall Cleanup Status: SUCCESS"
    exit 0
else
    echo "Overall Cleanup Status: FAILED"
    exit 1
fi
