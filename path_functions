# Function to take array of paths and add them (cleanly) to the front
function path_front {
    # reverse the args so first path is added last (front-most)
    # uses #36 from http://www.catonmat.net/blog/sed-one-liners-explained-part-one/
    # for emulated tac through sed
    for dir in $(echo $@ | tr " " "\n" | sed '1!G;h;$!d'); do
	# removes arg from PATH and removes extraneous colons
	PATH=$(echo $PATH | sed -E -e "s,(^|:)${dir}(:|$),:,g" \
	    -e "s,(^:)|(:$),,g")
	# adds arg to front of PATH
        PATH="${dir}:$PATH"
    done
}

# Function to take array of paths and them (cleanly) to the back
function path_back {
    # no reverse here, last path given is added last (very end)
    for dir; do
	# removes arg from PATH and removes extraneous colons
	PATH=$(echo $PATH | sed -E -e "s,(^|:)${dir}(:|$),:,g" \
	    -e "s,(^:)|(:$),,g")
	# adds arg to front of PATH
	PATH="$PATH:${dir}"
    done
}
