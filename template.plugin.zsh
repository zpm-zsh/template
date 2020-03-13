#!/usr/bin/env zsh
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
typeset -g _zpm_template__base_dir=${0:h}

function template() {
  emulate -L zsh
  setopt +o nomatch

  if [[ "$#" -lt 1 ]]; then
    echo "Usage: template template args"
    return 1
  fi

  local template_folder="$(echo ${_zpm_template__base_dir}/templates/${1},*,*([1]))"

  shift

  arr_mod=("${(@s/,/)___template:t}")

  args_length="${arr_mod[3]}"

  if [[ "$#" -lt $args_length ]]; then
    echo "Need ${args_length} arguments for template"
    if [[ -f "${template_folder}/help.txt" ]]; then
      cat "${template_folder}/help.txt"
    fi
    return 1
  fi

  if [[ -f "${template_folder}/pre.sh" ]]; then
    bash "${template_folder}/pre.sh" $PWD $@
  fi

  for file in "${template_folder}/files/"*; do
    if [[ -e "$file" ]]; then
      filename=$(basename $file)
      for i in `seq 1 ${args_length}`; do
        filename="${filename/_${i}_/${(P)i}}"
      done

      cp "${file}" "${PWD}/${filename}"

      for i in `seq 1 ${args_length}`; do
        sed -i "s/__${i}__/${(P)i}/g" "${PWD}/${filename}"
      done
    fi
  done

  if [[ -f "${template_folder}/post.sh" ]]; then
    bash "${template_folder}/post.sh" $PWD $@
  fi

  echo "${c[cyan]}Done"
}

_templates_list=()
for ___template in ${0:h}/templates/*,*,*; do
  arr_mod=("${(@s/,/)___template:t}")

  name="${arr_mod[1]}"
  description="${arr_mod[2]}"
  arg_length="${arr_mod[3]}"
  _templates_list+="${name}:${description}, ${arg_length} arg(s)"
done

function _template() {
  _arguments \
    '*:: :->subcmds' && return 0

  if (( CURRENT == 1 )); then
    _describe -t commands 'Templates' _templates_list
    return
  fi
}

compdef _template template
