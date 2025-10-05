#!/usr/bin/env bash

set -euo pipefail

SRC_BASE="${SRC_BASE:-${HOME}/src}"
SRC_INDEX="${SRC_INDEX:-${SRC_BASE}/.index}"

log() {
    local msg="$*"
    echo "$msg" | stderr
}

stderr() {
    cat >&2
}

promptYes() {
    local choice
    read -r -p "$1, continue [y/n]? " choice
    if ! [[ $choice == "Y" || $choice == "y" ]]; then
        exit 1
    fi
}

help() {
    cat <<EOF
Usage: $0 <command> [args...]
Commands:
    get <url>    Clone a git repository from URL
    go [query]   Navigate to a project directory (with optional search)
    find [query] Search for project directories
    reindex      Rebuild the project index
    help         Show this help message
EOF
}

get() {
    local url="$1"
    local dest
    
    if ! validate_url "$url"; then
        log "Invalid URL: $url"
        return 1
    fi

    dest="${SRC_BASE}/$(get_rel_path_from_url "$url")"

    if [[ ! -d "$dest" ]]; then
        promptYes "Cloning $url into $dest" | stderr
        git clone "$url" "$dest" | stderr
        reindex
    else
        log "Directory already exists: $dest"
    fi

    promptYes "Go to $dest" | stderr
    go "$dest"
}

validate_url() {
    local url="$1"
    return 0   
}

get_rel_path_from_url() {
    local url="$1"
    
    # Remove .git suffix if present
    url="${url%.git}"
    
    # Handle SSH format: git@host:owner/repo
    if [[ "$url" =~ git@[^:]+:(.+) ]]; then
        echo "${BASH_REMATCH[1]}"
    # Handle HTTPS format: https://host/owner/repo
    elif [[ "$url" =~ https://[^/]+/(.+) ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        # Fallback to basename for other formats
        echo "$(basename "$url")"
    fi
}

go() {
    local dir="$1"
    local shell="${2:-$SHELL}"
    pushd "$dir" > /dev/null
    "${shell}"
    popd > /dev/null
}

find() {
    local query

    if [[ $# -gt 0 ]]; then
        query="--query=$*"
    else
        query=""
    fi

    if should_reindex; then
        reindex
    fi

    fzf ${query} -1 < "${SRC_INDEX}"
}

reindex() {
    log "Reindexing repositories in ${SRC_BASE}..."
    fd -t d -H '^\.git$' "${SRC_BASE}" --exec dirname {} \; > "${SRC_INDEX}"
    log "Found $(cat "${SRC_INDEX}" | wc -l) repositories"
}

should_reindex() {
    if [[ ! -f "${SRC_INDEX}" ]]; then
        log "Index file does not exist."
        return 0
    fi
    if [[ $(date -r "${SRC_INDEX}" +%Y%m%d) != $(date +%Y%m%d) ]]; then
        log "Index file is outdated."
        return 0
    fi
    return 1
}

case "${1:-""}" in

    get)
        shift 1
        get "$@"
        ;;
    go)
        shift 1
        dest=$(find "$@")
        go "$dest"
        ;;
    find)
        shift 1
        find "$@"
        ;;
    reindex)
        shift 1
        reindex "$@"
        ;;
    help) 
        shift 1
        help
        ;;
    *) 
        echo "Unknown command: ${1:-""}" >&2
        help
        exit 1
        ;;
esac