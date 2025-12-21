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

function git_status;
    set -l added ''
    set -l staged ''
    set -l deleted ''
    set -l modified ''
    set -l untracked ''

    git status -s 2>/dev/null | while read -l line
        set -l xy (echo $line | cut -b -2)

        if string match -q "*A*" $line
            set added 'α'
        end

        if string match -q "*D*" $line
            set deleted 'Δ'
        end

        if string match -q "*M*" $line
            set modified 'δ'
        end

        if string match -q -r "^[^ ?]^[ ?]" $line
            set staged 'σ'
        end

        if string match -q -r "\?\?" $line
            set untracked 'ψ'
        end
    end

    string join "" \
        "$(set_color yellow)$untracked" \
        "$(set_color blue)$added" \
        "$(set_color red)$deleted" \
        "$(set_color yellow)$modified" \
        "$(set_color green)$staged" \ 

end

function fish_prompt;
	set -l color "blue"
	set -l symbol "ν"

	if test $status -ne 0
		set symbol "ε"
		set color "red"
	end

	switch $fish_bind_mode
		case default
			set symbol "η"
			set color "green"
		case visual
			set symbol "η"
			set color "yellow"
		case replace replace_one
			set symbol "ρ"
			set color "magenta"
	end

	printf "
$(short_pwd) $(git_branch) $(git_status) $error
$(set_color $color)$symbol 
"
end
