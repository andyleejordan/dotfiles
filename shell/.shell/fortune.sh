(
    fortune_args="-s"
    cowsay_args="-f tux"
    if hash fortune 2>/dev/null; then
        cmd="fortune $fortune_args"
        if hash cowsay 2>/dev/null; then
            cmd="cowsay $cowsay_args $($cmd)"
        fi
    fi
    $cmd
)
