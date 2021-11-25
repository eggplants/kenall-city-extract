#!/usr/bin/env bash

echo "name,count" > RES.CSV
nkf KEN_ALL.CSV |
  awk -F'"?,"?' '
     $8 ~ /^.*市/ && $8 !~ /.+郡/ \
                  || $8 ~ /(郡山|小郡|蒲郡)市/ {
      match($8, /^.*市/)
      m = $7""substr($8, RSTART, RLENGTH)
      if(k[m] != 1)
      {
        a[$7] += 1
        k[m] = 1
      }
    } END {
      for(i in a)
      {
        gsub(i, "", n[i])
        print i","a[i]
        fflush()
      }
    }
  ' | sort -t, -nrk2 >> RES.CSV
