function rbt_update -a commit -a review -d "Updates a review for a single commit"
  rbt post --markdown --tracking-branch upstream/master --review-request-id $review --parent $commit^ $commit
end
