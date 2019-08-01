if [[ "$#" -lt 1 ]]; then
  echo "Need file name"
  return 1
fi

cp "${${(%):-%x}:a:h}/files/JavaScript.js" "${1}.js"

sed -i "s/@1@/${1}/g" "${1}.js"

echo "${1}.js"
