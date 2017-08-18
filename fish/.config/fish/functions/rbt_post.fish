function rbt_post -a commit -a review -d "Posts a new review with a dependency on a previous review"
  # TODO list:
  # * Respect a target people variable or something
  # * Find the dependent review by inspecting the previous commit
  # * Sign the commit like with -s but with the Mesos style
  rbt post --markdown --tracking-branch upstream/master --target-groups mesos --target-people kaysoky --depends-on $review --parent $commit^ $commit
end
