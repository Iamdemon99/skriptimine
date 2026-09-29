fail_olemas() {
    local fail="$1"
    if [ -f "$fail" ]; then
        return 0
    else
        return 1
    fi
}

if fail_olemas "/etc/passwd"; then
    echo "Fail on olemas."
else
    echo "Faili ei leitud."
fi
