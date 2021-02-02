#!/bin/sh

SRC="src"
DIST="dist"

cd `dirname $0`
rm -rf "$DIST/"

cp -r "$SRC/" "$DIST/"

function template() {
	IN_BRACKETS=0
	IN_SCRIPT=0
	while IFS= read -d '' -rn1 chr; do
		if [ "$chr" = "{" ]; then
			if [ "$IN_BRACKETS" = 0 ]; then
				IN_BRACKETS=1
			else
				IN_BRACKETS=0
				IN_SCRIPT=1
				printf "" > /tmp/bush
			fi
		elif [ "$chr" = "}" ] && [ "$IN_SCRIPT" = 1 ]; then
			if [ "$IN_BRACKETS" = 0 ]; then
				IN_BRACKETS=1
			else
				IN_BRACKETS=0
				IN_SCRIPT=0
				. /tmp/bush | head -c -1
			fi
		elif [ "$IN_SCRIPT" = 1 ]; then
			printf "$chr" >> /tmp/bush
		else
			printf "$chr"
		fi
	done
}

for file in `find -L "$DIST/" -type f -not -path '*/\.*'`; do
	template <"$file" >/tmp/bush2
	cat /tmp/bush2 > "$file"
done

for file in `find -L "$DIST/" -type f -path '*/\.*'`; do
	. "$file"
	rm "$file"
done
