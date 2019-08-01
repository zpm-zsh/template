if [[ "$#" -lt 2 ]]; then
  echo "Need 2 arguments: project name, author name"
  return 1
fi

cp "${${(%):-%x}:a:h}/files/README.npm.md" "README.md"

sed -i "s/@1@/${1}/g" "README.md"
sed -i "s/@2@/${2}/g" "README.md"

filename_created="README.md"
