#!/usr/bin/env zsh

function template(){
  if [[ "$#" -lt 1 ]]; then
    echo "Usage: template template args"
    return 1
  fi
  
  filename_orig="$(echo ${${(%):-%x}:a:h}/templates/${1},*,*,*([1]))"
  shift
  template_dir="$(dirname ${filename_orig})"
  template_name="$(basename ${filename_orig} | awk -F',' '{print $1}')"
  args_length="$(basename ${filename_orig} | awk -F',' '{print $3}')"
  filename="$(basename ${filename_orig} | awk -F',' '{print $4}')"
  
  if [[ "$#" -lt $args_length ]]; then
    echo "Need ${args_length} arguments for template"
    if [[ -f "${template_dir}/${template_name},help.txt" ]]; then
      cat "${template_dir}/${template_name},help.txt"
    fi
    return 1
  fi
  
  if [[ -f "${template_dir}/${template_name},pre.sh" ]]; then
    bash "${template_dir}/${template_name},pre.sh" $@
  fi
  
  if [[ -n $1 ]]; then
    filename="${filename/_1_/"$1"}"
  fi
  
  if [[ -n $2 ]]; then
    filename="${filename/_2_/"$2"}"
  fi
  
  if [[ -n $3 ]]; then
    filename="${filename/_3_/"$3"}"
  fi
  
  if [[ -n $4 ]]; then
    filename="${filename/_4_/"$4"}"
  fi
  
  if [[ -n $5 ]]; then
    filename="${filename/_5_/"$5"}"
  fi
  
  if [[ -n $6 ]]; then
    filename="${filename/_6_/"$6"}"
  fi
  
  if [[ -n $7 ]]; then
    filename="${filename/_7_/"$7"}"
  fi
  
  cp "${filename_orig}" "${filename}"
  
  if [[ -n $1 ]]; then
    sed -i "s/__1__/${1}/g" "${filename}"
  fi
  
  if [[ -n $2 ]]; then
    sed -i "s/__2__/${2}/g" "${filename}"
  fi
  
  if [[ -n $3 ]]; then
    sed -i "s/__3__/${3}/g" "${filename}"
  fi
  
  if [[ -n $4 ]]; then
    sed -i "s/__4__/${4}/g" "${filename}"
  fi
  
  if [[ -n $5 ]]; then
    sed -i "s/__5__/${5}/g" "${filename}"
  fi
  
  if [[ -n $6 ]]; then
    sed -i "s/__6__/${6}/g" "${filename}"
  fi
  
  if [[ -n $7 ]]; then
    sed -i "s/__7__/${7}/g" "${filename}"
  fi
  
  if [[ -f "${template_dir}/${template_name},post.sh" ]]; then
    bash "${template_dir}/${template_name},post.sh" $@
  fi
  
  echo "${c[cyan]}Created: ${c[yellow]}${filename}"
  
}
