# Defined in /tmp/fish.i25b7P/get_current_git_branch.fish @ line 1
function get_current_git_branch
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end
