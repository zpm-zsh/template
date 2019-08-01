if [[ "$#" -lt 1 ]]; then
  echo "Need file name"
  return 1
fi

cp "${${(%):-%x}:a:h}/files/Bootstrap.html" "${1}.html"

sed -i "s/@1@/${1}/g" "${1}.html"

filename_created="${1}.html"
