#!/usr/bin/env bash

working_dir="$(pwd)"

## Exit if dependences are not installed
missing_deps=""
command -v gh > /dev/null || missing_deps+="gh "
command -v git > /dev/null || missing_deps+="git "
command -v ssh > /dev/null || missing_deps+="openssh "
command -v gitleaks > /dev/null || missing_deps+="gitleaks "
command -v jq > /dev/null || missing_deps+="jq "

if [[ -n "${missing_deps[@]}" ]]
then
    echo "Please install the following dependencies: ${missing_deps[@]}"
    exit 1
fi

## Show usage if --help or -h are passed or if no arguments are passed
if [[ -z $@ ]] || echo $@ | grep -qE '\-h|\-\-help'
then
    echo "usage: $0 https://github.com/example/repo https://github.com/example/repo2"
    exit 0
else
    urls="$@"
fi

## Check if logged into Github CLI -- login if not
gh auth status 2>&1 >/dev/null  | grep -q 'Logged in' || gh auth login
if ! gh auth status 2>&1 >/dev/null  | grep -q 'Logged in'
then
    echo 'Error encounterd, please login to Github CLI with `gh auth login`'
    exit 2
fi


## Function to check if argument is repository
check_repo () {
    url="$1"
    ## Check if repo is hosted at github.com and is a valid git repo 
    echo ${url} | grep -Eqo "github\.com\/(.*)" \
	&& user=$(echo ${url} | grep -Eo "github\.com\/(.*)" | cut -d '/' -f 2) \
	&& repo=$(echo ${url} | grep -Eo "github\.com\/(.*)" | cut -d '/' -f 3) \
	&& git ls-remote ${url} && valid_url="true"

    ## Check if url is a user's profile
    [[ -z ${repo} ]] && [[ -n ${user} ]] && echo ${url} | grep -Eqo "github\.com\/(.*)" \
	&& gh repo list --limit 1000000 ${user}  && user_profile_url='true'
}

## Function to clone uri locally to scan
clone_repo () {
    url="$1"
    path="$2"
    [[ ${valid_url} == 'true' ]] && git clone ${url} ${path}
}

## Scan individual repository
scan_repo () {
    repo="$1"
    cd /tmp/${repo}
    gitleaks detect --report-path /tmp/$(date "+%Y-%d-%m_%H:%M_${repo}_gitleaks.json") --verbose
}

## Enumerate all public repositories for provided user profile
enum_user_repos () {
    user="$1"
    repo_full_list="$(gh repo list --limit 999999 --json name --visibility public ${user} | jq -r '.[].name')"
    while read repo
    do
	repo_list+="${repo} "
    done < <(printf "${repo_full_list}")
}

scan_user_repos () {
    user="$1"
    repo_list="$2"
    while read repo
    do
	valid_url=""
	check_repo "https://github.com/${user}/${repo}"
	[[ ${valid_url} == 'true' ]] && clone_repo "https://github.com/${user}/${repo}" /tmp/${repo} \
	    && scan_repo ${repo}
	[[ -n ${repo} ]] && [[ ${valid_url} == 'true' ]] && rm -rf /tmp/${repo}
    done < <(printf "${repo_full_list}")
}

## If arguments were supplied, begin scanning! 
if [[ -n ${urls} ]]
then
    ## Iterate over each url passed as arguments
    for url in ${urls}
    do
	user=""
	repo=""
	valid_url=""
	user_profile_url=""

	## Check if url is repository or a profile
	echo ${url} | grep -Eqo "github\.com\/(.*)" \
	    && check_repo ${url}
	## If url points at repository then scan
	[[ -n ${repo} ]] && [[ ${valid_url} == "true" ]] && clone_repo ${url} /tmp/${repo} \
	    && scan_repo ${repo}
	## Remove repository after scan
	[[ -n ${repo} ]] && [[ ${valid_url} == "true" ]] && rm -rf /tmp/${repo}

	## If url is profile then grab all public repositories and scan all of them
	repo_list=""
	[[ ${user_profile_url} == 'true' ]] && [[ -n ${user} ]] && enum_user_repos ${user} \
	    && scan_user_repos ${user} ${repo_list}
    done
fi

cd ${working_dir}
