# ---------------------------------------------------------------------------- #
# Source this file in your .bashrc, e.g. with:                                 #
# source .cdbm.bashrc                                                          #
# ---------------------------------------------------------------------------- #

# if bash, check bash version is at least 4
if [[ -z "$BASH_VERSION" ]] || [[ "${BASH_VERSION%%.*}" -lt 4 ]]; then
  echo "Requires Bash version 4+"
  exit 1
fi

CDBM_CACHE_PATH="$HOME/.mkbm"

function cdbm_readcache () {
  declare -n _bookmarks=$1
  while read line; do
    if [[ ! -z $line ]] && [[ ! -z ${line%% *} ]] && [[ ! -z ${line#* } ]]; then
      _bookmarks["${line%% *}"]="${line#* }"
    fi
  done < "$CDBM_CACHE_PATH"
}

function cdbm_writecache () {
  for name in "${!bookmarks[@]}"; do
    echo "${name} ${bookmarks[$name]}" >> "$CDBM_CACHE_PATH"
  done
}

function cdbm () {
  # read bookmark list
  declare -A bookmarks
  cdbm_readcache bookmarks

  # check bookmark exists
  if [[ ! -z "$1" ]]; then
    if [[ ! -z "${bookmarks[$1]}" ]]; then
      cd "${bookmarks[$1]}"
    else
      echo "Bookmark '$1' does not exist"
    fi
  else
    echo ""
    echo "Usage: $0 <bookmark name>"
    echo ""
    echo "Available bookmarks are:"
    for name in "${!bookmarks[@]}"; do
      echo -e "\t${name} -> ${bookmarks[$name]}"
    done
    echo ""
  fi
  return
}

function rmbm () {
  # usage message if parameters misalign
  : ${1:?"Usage: $0 <bookmark name>"}

  # read bookmark list
  declare -A bookmarks
  cdbm_readcache bookmarks

  # unset bookmark as per parameter
  unset bookmarks['$1']

  # truncate bookmark file
  # write updated entries list
  : > "$CDBM_CACHE_PATH"
  cdbm_writecache
  return
}

function mkbm () {
  # usage message if parameters misalign
  usage="Usage: $0 <bookmark name> <path>"
  : ${1:?$usage}
  : ${2:?$usage}

  # read bookmark list
  declare -A bookmarks
  cdbm_readcache bookmarks

  # update bookmark as per parameters
  bookmarks["$1"]="$2"

  # truncate bookmark file
  # write updated entries list
  : > "$CDBM_CACHE_PATH"
  cdbm_writecache
  return
}
