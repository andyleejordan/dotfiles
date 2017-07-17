function fish_greeting
  command -sq fortune
  and set cmd fortune -s

  command -sq cowsay
  and set cmd cowsay -f bud-frogs "($cmd)"

  eval $cmd
end
