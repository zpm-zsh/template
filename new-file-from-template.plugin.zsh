#!/usr/bin/env zsh

function template(){
  if [[ "$#" -lt 1 ]]; then
    echo "Usage: ..."
  fi
  
  filename="$(echo ${${(%):-%x}:a:h}/templates/${1},*,template.sh([1]))"
  
  shift
  
  filename_created=''
  source "$filename" $@
  
  if [[ -n "$filename_created" ]]; then
    echo "${c[cyan]}Created: ${c[yellow]}${filename_created}"
  fi

}
