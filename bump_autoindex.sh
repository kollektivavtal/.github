#!/bin/zsh

cd autoindex

highest_tag=$(git tag -l | grep -E 'v[0-9]+' | sort -V | tail -n 1)
echo "Highest tag: ${highest_tag}"

# if [[ $highest_tag =~ v([0-9]+) ]]; then
  # current_version=${match[1]}
  # new_version=$((current_version + 1))
  # new_tag="v${new_version}"
# else
  # echo "Error: No valid tag found. Exiting."
  # exit 1
# fi
# echo "New tag: ${new_tag}"
# git tag "$new_tag"
# git push origin "$new_tag"

cd ..


for dir in ./20*/ ./year; do
  if [ -d "$dir" ]; then
    echo "$dir"
    find "$dir" -type f -exec sh -c 'LC_CTYPE=C sed -i "" -E "s/kollektivavtal\/autoindex@v[0-9]+/kollektivavtal\/autoindex@${1}/g" "$2"' _ "$highest_tag" {} \;

    cd "$dir"
    if git diff --quiet; then
      echo "No changes in $dir."
    else
      git --no-pager diff
      git commit -am "Bump autoindex to ${highest_tag}"
      git push
    fi
    cd ..
  fi
done

