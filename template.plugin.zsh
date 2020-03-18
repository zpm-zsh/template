#!/usr/bin/env zsh
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if [[ $PMSPEC != *f* ]] {
  fpath+=( "${0:h}/functions" )
}

autoload -Uz template

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
