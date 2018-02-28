function show_colors
    set_color -c | xargs -I'{}' fish -c "set_color {}; echo '{}'; set_color normal"
end
