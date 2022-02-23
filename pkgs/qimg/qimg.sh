urlencode() {
	# urlencode <string>
	local old_lc_collate=$LC_COLLATE
	LC_COLLATE=C

	local length="${#1}"
	for (( i = 0; i < length; i++ )); do
		local c="${1:i:1}"
		case $c in
			[a-zA-Z0-9.~_-]) printf "$c" ;;
			*) printf '%%%02X' "'$c" ;;
		esac
	done

	LC_COLLATE=$old_lc_collate
}

if [ $# -eq 0 ]; then
	echo -e "No arguments specified. Usage: qimg <filename>\nqimg hello.txt\necho \"Hello, world!\" | qimg hello.txt"
	return 1
fi
key="$(cat ~/.ssh/id_rsa | sha1sum | cut -d " " -f 1 | xxd -r -p | base64 | cut -c -27)"
if tty -s; then
	response=$(curl --progress-bar -F "key=$key" -F "file=@\"$1\"" 'https://qimg.techjargaming.com/upload.php')
else
	response=$(curl --progress-bar -F "key=$key" -F "file=@-;filename=\"$1\"" 'https://qimg.techjargaming.com/upload.php')
fi
if [[ "$response" =~ "\|" ]]; then
	filename="$(echo "$response" | sed -r 's/(.*)\|(.*)/\1/')"
	realname="$(basename "$1")"
	if [[ $filename == *"."* ]]; then
		extension="${filename##*.}"
	fi
	if [ -n "$extension" ] || [ "${filename: -1}" == "." ]; then
		extension=".${extension}"
	fi

	url="https://qimg.techjargaming.com/${filename%.*}/$(urlencode "${realname%.*}${extension}")"
	delurl="https://qimg.techjargaming.com/delete/$(echo $response | sed -r 's/(.*)\|(.*)/\2/')"
	echo "$delurl" >&2
	echo "$url"
	if command -v xclip >/dev/null; then
		printf -- '%s' "$url" | xclip -sel clip >/dev/null 2>&1
	fi
	if command -v wl-copy >/dev/null; then
		wl-copy "$url" >/dev/null 2>&1
	fi
else
	echo "Upload error: $response"
fi

