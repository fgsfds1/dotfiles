#!/bin/bash

# CPU usage calculation matching waybar's algorithm
# Reads /proc/stat and calculates usage percentage
# Set DEBUG=1 to output debug information

STATE_FILE="/tmp/waybar-cpu-load-prev"
DEBUG="${DEBUG:-0}"

# Debug print function
debug() {
    if [[ "$DEBUG" == "1" ]]; then
        echo "[DEBUG] $1" >&2
    fi
}

# Read current /proc/stat values
read_cpu_stats() {
    local line
    read -r line < /proc/stat
    # Format: cpu user nice system idle iowait irq softirq steal guest guest_nice
    set -- $line
    # $1="cpu", $2=user, $3=nice, $4=system, $5=idle, $6=iowait, $7=irq, $8=softirq, $9=steal, ${10}=guest, ${11}=guest_nice
    # Output: user nice system idle iowait (only first 5 values needed for idle calc)
    echo "$2 $3 $4 $5 $6"
}

# Calculate total and idle from space-separated values
# Waybar: idle = idle + iowait (indexes 3 and 4 in 0-based array, so $4 and $5 in 1-based)
calc_stats() {
    local total=0
    local idle=$(($4 + $5))  # idle + iowait
    for val in $*; do
        total=$((total + val))
    done
    echo "$total $idle"
}

# Read current stats
curr_stats=$(read_cpu_stats)
debug "Raw /proc/stat values: $curr_stats"
read -r curr_total curr_idle <<< "$(calc_stats $curr_stats)"
debug "Current: total=$curr_total, idle=$curr_idle (idle+iowait)"

# Read previous stats if they exist
if [[ -f "$STATE_FILE" ]]; then
    read -r prev_total prev_idle < "$STATE_FILE"
    debug "Previous: total=$prev_total, idle=$prev_idle"
else
    # First run, save current and return normal state
    echo "$curr_total $curr_idle" > "$STATE_FILE"
    echo '{"text":"","class":"normal","tooltip":"CPU: 0% @ 0.0GHz"}'
    exit 0
fi

# Save current stats for next run
echo "$curr_total $curr_idle" > "$STATE_FILE"

# Calculate deltas
delta_total=$((curr_total - prev_total))
delta_idle=$((curr_idle - prev_idle))
debug "Deltas: total=$delta_total, idle=$delta_idle"

# Calculate usage percentage: 100 * (1 - delta_idle / delta_total)
if [[ $delta_total -gt 0 ]]; then
    # Use awk for floating point calculation
    usage=$(awk "BEGIN {printf \"%.0f\", 100 * (1 - $delta_idle / $delta_total)}")
    debug "Calculation: 100 * (1 - $delta_idle / $delta_total) = $usage%"
else
    usage=0
    debug "Delta total is 0, setting usage to 0%"
fi

# Get current CPU frequency for tooltip
freq=$(awk '/cpu MHz/ {printf "%.1f", $4/1000; exit}' /proc/cpuinfo)

# Determine class based on Option B thresholds
if [[ $usage -ge 90 ]]; then
    class="verycritical"
elif [[ $usage -ge 80 ]]; then
    class="critical"
elif [[ $usage -ge 65 ]]; then
    class="veryhigh"
elif [[ $usage -ge 50 ]]; then
    class="high"
elif [[ $usage -ge 35 ]]; then
    class="verywarm"
elif [[ $usage -ge 20 ]]; then
    class="warm"
else
    class="normal"
fi

# Output JSON for waybar
echo "{\"text\":\" \",\"class\":\"$class\",\"tooltip\":\"CPU: $usage% @ ${freq}GHz\"}"
