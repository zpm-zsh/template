#!/usr/bin/env bash

email=$(git config --get user.email)
name=$(git config --get user.name)

sed -i "s/__EMAIL__/${email}/g" package.json
sed -i "s/__NAME__/${name}/g" package.json



