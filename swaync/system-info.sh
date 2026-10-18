#!/usr/bin/env bash

set -u

ram_info() {
    free -h | awk '/^Mem:/ {print $3 " / " $2 " used"}'
}

disk_info() {
    df -h / | awk 'NR == 2 {print $3 " / " $2 " used (" $5 ")"}'
}

cpu_info() {
    local first_total first_idle second_total second_idle total_delta idle_delta usage
    read -r _ user nice system first_idle rest < /proc/stat
    first_total=$((user + nice + system + first_idle))
    sleep 0.2
    read -r _ user nice system second_idle rest < /proc/stat
    second_total=$((user + nice + system + second_idle))
    total_delta=$((second_total - first_total))
    idle_delta=$((second_idle - first_idle))
    [ "$total_delta" -gt 0 ] || total_delta=1
    usage=$((100 * (total_delta - idle_delta) / total_delta))
    printf '%s%% used' "$usage"
}



case "${1:-all}" in
    ram)
        title="Memory"
        body="$(ram_info)"
        ;;
    disk)
        title="Root disk"
        body="$(disk_info)"
        ;;
    cpu)
        title="CPU"
        body="$(cpu_info)"
        ;;
    all)
        title="System"
        body="CPU: $(cpu_info)\nRAM: $(ram_info)\nDisk: $(disk_info)"
        ;;
    *)
        exit 2
        ;;
esac

notify-send \
    --app-name="System" \
    --urgency=low \
    --expire-time=5000 \
    --hint=string:x-canonical-private-synchronous:system-info \
    "$title" "$body"
