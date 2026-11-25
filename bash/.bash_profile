source ~/.config/bash/env.bash

source ~/.config/bash/login.bash

if [[ $PS1 ]]; then
  source ~/.config/bash/interactive.bash
fi
