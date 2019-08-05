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
  
 
  for i in `seq 1 ${args_length}`; do
    filename="${filename/_${i}_/${(P)i}}"
  done

  if [[ -f "${template_dir}/${template_name},pre.sh" ]]; then
    bash "${template_dir}/${template_name},pre.sh" $filename $@
  fi  

  cp "${filename_orig}" "${filename}"
  
  for i in `seq 1 ${args_length}`; do
    sed -i "s/__${i}__/${(P)i}/g" "${filename}"
  done
  
  if [[ -f "${template_dir}/${template_name},post.sh" ]]; then
    bash "${template_dir}/${template_name},post.sh" $filename $@
  fi
  
  echo "${c[cyan]}Created: ${c[yellow]}${filename}"
  
}
