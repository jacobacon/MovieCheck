#!/usr/local/bin/bash
SEARCH_FOLDER="/media/Movies/*"

for f in /media/Movies/* /media/Movies/**/* ; 
do
	if [[ $f =~ \.mp4$ ]] || [[ $f =~ \.mkv$ ]]  || [[ $f =~ \.m4v$ ]]  || [[ $f =~ \.avi$ ]]; then
		if grep -Fxq "$f" clean.txt
			then		
				echo $f is already clean.
			else
				LOGDIR=$(dirname "${f}")
				echo $LOGDIR
				ffmpeg -v error -i "$f" -f null - 2>"$LOGDIR/error.log"
					if [ -s "$LOGDIR/error.log" ]; then
						echo $f >> dirty.txt
					else
						echo $f >> clean.txt
						rm -rf "$LOGDIR/error.log"
					fi
		fi
	fi

done
