function short_pwd;
    set -l toplevel (git rev-parse --show-toplevel 2> /dev/null)

    if test $status -eq 0 
        set -l root (string split -m 1 -r / $toplevel | tail -n 1)
        set -l path (string replace $toplevel $root $PWD)
        echo "$(set_color cyan)$(string replace $HOME "~" $path)$(set_color normal)"
        return
    end

    set path (
        string replace $HOME '~' $PWD | 
        string split / |
        tail -n 3 |
        string join /
    )
    echo "$(set_color cyan)$path$(set_color normal)"
end

function git_branch;
	git rev-parse --show-toplevel &> /dev/null

	if test $status -ne 0 
		return
	end
	
	echo "on $(set_color purple) $(git symbolic-ref --short HEAD)$(set_color normal)"
end

function fish_prompt;
	# set -l last_status $status
	#
	# set -l error
	# if test $last_status -ne 0
	# 	set error "$(set_color red)ε$last_status$(set_color normal)"
	# end

	set -l color "blue"
	set -l symbol "δ"

	if test $status -ne 0
		set symbol "ε"
		set color "red"
	end

	switch $fish_bind_mode
		case default
			set symbol "ν"
			set color "green"
		case visual
			set symbol "ν"
			set color "yellow"
		case replace replace_one
			set symbol "ρ"
			set color "magenta"
	end

	printf "
$(short_pwd) $(git_branch) $error
$(set_color $color)$symbol 
"
end
