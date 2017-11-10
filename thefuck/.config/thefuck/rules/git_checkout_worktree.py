import re
from thefuck.specific.git import git_support

# Matches `git checkout <branch>` when it is checked out in another worktree.
@git_support
def match(command):
    return ('checkout' in command.script
            and 'fatal:' in command.output
            and 'is already checked out at' in command.output)

# Fixes the command to `cd` to the worktree instead.
@git_support
def get_new_command(command):
    directory_name = re.findall(
        r"fatal: '[^']+' is already checked out at '([^']+)'" , command.output)[0]
    return 'cd {}'.format(directory_name)
