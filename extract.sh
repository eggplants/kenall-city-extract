#!/usr/bin/env bash

echo "[Preparing....]"

if ! command -v awk grep nkf sha1sum unzip wget &> /dev/null; then
  echo "install: awk grep nkf sha1sum unzip wget" >&2
  exit 1
fi

if ! [ -f KEN_ALL.CSV ]; then
  wget https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip
  unzip ken_all.zip
  rm ken_all.zip
fi

if ! [ -f ANS.CSV ]; then
  wget https://git.io/J1Sy0 -O ANS.CSV
fi

if ! [[ "$(sha1sum KEN_ALL.CSV)" =~ ^e3d4f3e47e4801eb4a4815df4f6ecc690497436f ]]; then
  echo "KEN_ALL.CSV is invalid." >&2
  rm KEN_ALL.CSV
  exit 1
elif ! [[ "$(sha1sum ANS.CSV)" =~ ^86a44424552484a26cb056955e44b9fca5de121e ]]; then
  echo "ANS.CSV is invalid." >&2
  rm ANS.CSV
  exit 1
fi

echo "[Parsing......]"

: > mismatch
echo "name,count" > RES.CSV

nkf KEN_ALL.CSV |
  awk -F'"?,"?' '
    $8 ~ /^.*市/ && $8 !~ /.+郡/ || $8 ~ /(郡山|小郡|蒲郡)市/ {
            match($8, /^.*市/)
            m = $7 "" substr($8, RSTART, RLENGTH)
            if (k[m] != 1) {
                    a[$7] += 1
                    k[m] = 1
                    n[$7] = n[$7] "/" m
            }
    }

    END {
            for (i in a) {
                    gsub(i, "", n[i])
                    print i "," a[i] "," n[i] "/"
            }
    }
  ' | sort -t, -nrk2 >> RES.CSV

echo "[Checking.....]"

while read -r pref cnt detail; do
  if ! grep -q "${pref},${cnt}" ANS.CSV; then
    echo -n "[out]: "
    echo "${pref},${cnt},${detail}"
    echo -n "[ans]: "
    grep "$pref" ANS.CSV
    echo "==="
    echo >> mismatch
  fi
done < <(tr < RES.CSV , \ | sed 1d)

correct="$(wc < mismatch -l)"
echo -n "[Wrong answers]: ${correct}/$(wc < RES.CSV -l) lines"

if [ "$correct" -eq 0 ]; then
  echo " => OK!"
  exit 0
else
  echo " => NG!"
  exit 1
fi
