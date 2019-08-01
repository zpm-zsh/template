if [[ "$#" -lt 1 ]]; then
  echo "Need file name"
  return 1
fi

cp "${${(%):-%x}:a:h}/files/Markdown.md" "${1}.md"

sed -i "s/@1@/${1}/g" "${1}.md"

echo "${1}.md"
