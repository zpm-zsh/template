if [[ "$#" -lt 1 ]]; then
  echo "Need file name"
  return 1
fi

cp "${${(%):-%x}:a:h}/files/script.sh" "${1}.sh"

sed -i "s/@1@/${1}/g" "${1}.sh"

filename_created="${1}.sh"
