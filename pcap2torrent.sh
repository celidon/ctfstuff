#!/bin/bash
while read i
  do k=$(echo \( `echo $i | grep -o , | wc -l` + 1\) /3 | bc)
    for j in `seq 1 $k`
      do echo $i | cut -d, -f$j,`echo $j+$k | bc`,`echo $j+$k+$k | bc`
      done
  done <<< $(tshark -r $1 -R 'bittorrent.piece.data' -2 -T fields -e bittorrent.piece.index -e bittorrent.piece.begin -e bittorrent.piece.data -E separator=,) | sort | cut -d, -f3 | echo -n -e $(tr -d '[:space:]' | sed 's/../\\x&/g') > $2
