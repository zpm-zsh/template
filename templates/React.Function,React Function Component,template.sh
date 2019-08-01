if [[ "$#" -lt 1 ]]; then
  echo "Need file name"
  return 1
fi

cp "${${(%):-%x}:a:h}/files/React.Function.jsx" "${1}.jsx"

sed -i "s/@1@/${1}/g" "${1}.jsx"

echo "${1}.jsx"
