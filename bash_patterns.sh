# advanced bash scripting patterns
# https://www.gnu.org/software/bash/manual/bash.html#Bourne-Shell-Variables

# COMPLETIONS
## ARRAYS
arr=(1 2 3)
echo "${arr[@]}" # 1 2 3
# a bare array references its first element only
echo "$arr" # 1
echo "${arr[0]}" # 1
echo "${arr[2]}" # 3
# append
arr+=( 4 )
echo "${arr[@]}" # 1 2 3 4
# reverse
b=("$(printf "%s\n" "${arr[@]}"|tac)")
echo "${b[@]}" # 4 3 2 1


## BASH_SOURCE
# bash souce is an array containing the path to the source script
# even when that file hase beed sourced
# https://stackoverflow.com/questions/35006457/choosing-between-0-and-bash-source

## BASH_LINENO
## FUNCNAME
## BASH_REMATCH
# the =~ operator performs a regex match and stores the result in the BASH_REMATCH array
# ${BASH_REMATCH[0]} (or just $BASH_REMATCH) contains the whole match, while
# captured groups follow in order

## PIPESTATUS
# getting the status from the middle of a pipe
false | true
echo "${PIPESTATUS[@]}" # 1 0
# "${PIPESTATUS[-1]}" is equivalent to "$?", but "${?[@]} is invalid

## SCOPING
# variables and functions have different scopes, which allows pseudo- singleton classes (state+behavior)

# here's a nicer syntax instead of typing BASH_REMATCH all the time
match() { [[ "$1" =~ $2 ]] && match=("${BASH_REMATCH[@]}"); }
match "here's a 123 string" '[[:num:]]*' && echo $match # 123

## USER INPUT
# read and select
