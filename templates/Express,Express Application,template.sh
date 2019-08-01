if [[ "$#" -lt 1 ]]; then
  echo "Need project name"
  return 1
fi

mkdir "$1"
cd "$1"
npm init -y

cp "${${(%):-%x}:a:h}/files/express.js" "index.js"

npm i -D express helmet

sed -i "s/@1@/${1}/g" "index.js"

