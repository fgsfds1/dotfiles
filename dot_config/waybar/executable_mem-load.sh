#!/bin/bash

# Memory usage calculation matching waybar's algorithm
# Reads /proc/meminfo and calculates usage percentage
# Set DEBUG=1 to output debug information

DEBUG="${DEBUG:-0}"

# Debug print function
debug() {
    if [[ "$DEBUG" == "1" ]]; then
        echo "[DEBUG] $1" >&2
    fi
}

# Read values from /proc/meminfo
read_meminfo() {
    local key value
    while read -r key value _; do
        key=${key%:}
        echo "$key $value"
    done < /proc/meminfo
}

# Get specific value from meminfo
get_value() {
    local key=$1
    grep "^$key " <<< "$meminfo" | awk '{print $2}'
}

# Read all meminfo values
meminfo=$(read_meminfo)
debug "Read /proc/meminfo"

# Extract values (all in kB)
memtotal=$(get_value "MemTotal")
swaptotal=$(get_value "SwapTotal")
swapfree=$(get_value "SwapFree")

# Calculate available memory (new kernel method with zfs support)
if get_value "MemAvailable" >/dev/null 2>&1; then
    memavailable=$(get_value "MemAvailable")
    zfs_size=$(get_value "zfs_size" || echo 0)
    memfree=$((memavailable + zfs_size))
    debug "Using MemAvailable method: available=$memavailable, zfs=$zfs_size"
else
    # Old kernel fallback
    memfree_val=$(get_value "MemFree")
    buffers=$(get_value "Buffers")
    cached=$(get_value "Cached")
    sreclaimable=$(get_value "SReclaimable")
    shmem=$(get_value "Shmem")
    zfs_size=$(get_value "zfs_size" || echo 0)
    memfree=$((memfree_val + buffers + cached + sreclaimable - shmem + zfs_size))
    debug "Using fallback method: free=$memfree_val, buffers=$buffers, cached=$cached, sreclaimable=$sreclaimable, shmem=$shmem, zfs=$zfs_size"
fi

# Convert kB to GiB with same formula as waybar: 0.01 * round(kb / 10485.76)
# Where 10485.76 = 2^20 / 100 = 1048576 / 100
kb_to_gib() {
    awk "BEGIN {printf \"%.2f\", 0.01 * int(($1 / 10485.76) + 0.5)}"
}

# Calculate RAM usage
total_ram_gib=$(kb_to_gib $memtotal)
used_ram_kb=$((memtotal - memfree))
used_ram_gib=$(kb_to_gib $used_ram_kb)
avail_ram_gib=$(kb_to_gib $memfree)

# Calculate RAM percentage
if [[ $memtotal -gt 0 && $memfree -ge 0 ]]; then
    used_ram_percentage=$((100 * (memtotal - memfree) / memtotal))
else
    used_ram_percentage=0
fi

# Calculate swap usage
if [[ -n "$swaptotal" && $swaptotal -gt 0 ]]; then
    total_swap_gib=$(kb_to_gib $swaptotal)
    used_swap_kb=$((swaptotal - swapfree))
    used_swap_gib=$(kb_to_gib $used_swap_kb)
    avail_swap_gib=$(kb_to_gib $swapfree)
    used_swap_percentage=$((100 * (swaptotal - swapfree) / swaptotal))
    swap_info="Swap: ${used_swap_gib}G/${total_swap_gib}G"
else
    used_swap_percentage=0
    swap_info="Swap: Off"
fi

debug "RAM: ${used_ram_gib}G/${total_ram_gib}G (${used_ram_percentage}%)"
debug "Swap: $swap_info"

# Determine class based on thresholds
if [[ $used_ram_percentage -ge 90 ]]; then
    class="verycritical"
elif [[ $used_ram_percentage -ge 80 ]]; then
    class="critical"
elif [[ $used_ram_percentage -ge 70 ]]; then
    class="veryhigh"
elif [[ $used_ram_percentage -ge 60 ]]; then
    class="high"
elif [[ $used_ram_percentage -ge 45 ]]; then
    class="verywarm"
elif [[ $used_ram_percentage -ge 30 ]]; then
    class="warm"
else
    class="normal"
fi

# Build tooltip
tooltip="RAM: ${used_ram_gib}G/${total_ram_gib}G, ${swap_info}"

# Output JSON for waybar
echo "{\"text\":\" \",\"class\":\"$class\",\"tooltip\":\"$tooltip\"}"
