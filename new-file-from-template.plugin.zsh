#!/usr/bin/env zsh

function template(){
  if [[ "$#" -lt 1 ]]
  then
    echo "Usage: ..."
  fi
   
  filename="$(basename ${${(%):-%x}:a:h}/templates/${1},*([1]) | awk -F',' '{print $3}')"

  filename_orig="$(echo ${${(%):-%x}:a:h}/templates/${1},*([1]))"

  if [[ -n $2 ]]; then
    filename="${filename/@1@/"$2"}"
  fi

  if [[ -n $3 ]]; then
    filename="${filename/@2@/"$3"}"
  fi

  if [[ -n $4 ]]; then
    filename="${filename/@3@/"$4"}"
  fi

  if [[ -n $5 ]]; then
    filename="${filename/@4@/"$5"}"
  fi

  if [[ -n $6 ]]; then
    filename="${filename/@5@/"$6"}"
  fi

  if [[ -n $7 ]]; then
    filename="${filename/@6@/"$7"}"
  fi

  cp "$filename_orig" "$filename"


  if [[ -n $2 ]]; then
    sed -i "s/@1@/${2}/g" "$filename"
  fi

  if [[ -n $3 ]]; then
    sed -i "s/@2@/${3}/g" "$filename"
  fi

  if [[ -n $4 ]]; then
    sed -i "s/@3@/${4}/g" "$filename"
  fi

  if [[ -n $5 ]]; then
    sed -i "s/@4@/${5}/g" "$filename"
  fi

  if [[ -n $6 ]]; then
    sed -i "s/@5@/${6}/g" "$filename"
  fi

  if [[ -n $7 ]]; then
    sed -i "s/@6@/${7}/g" "$filename"
  fi

}

