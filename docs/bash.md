# Bashism

I use a little library to have a common set of utilities out of the box in my
bash scripts, it can be retrieved at https://github.com/lorello/lib.sh

## Checking strings

    # -z (string length is zero) and -n (string length is not zero) are
    # preferred over testing for an empty string
    if [[ -z "${my_var}" ]]; then
        do_something
    fi


## Loops

Loop on a rows of a text file

    #!/bin/sh
    list=/tmp/blacklists/porn/domains
    cat $list | while read domains
    do
        echo $domains
    done

Loop on a counter

    counter=1
    while (( $counter < 10 ))
    do
        echo $counter
        ((counter++))
    done

Loop on a list of items

    modules=(json httpserver jshint)
    for module in "${modules[@]}"; do
        npm install -g "$module"
    done

Looping 

    for ((i = 0; i < n; i++)); do
        ...
    done

## Array loops

```
names=(
  "Aaron Maxwell"
  "Wayne Gretzky"
  "David Beckham"
  "Anderson da Silva"
)
IFS=$'\n\t'
for name in ${names[@]}; do
  echo "$name"
done
```

## Loops on files containing spaces

```
OIFS="$IFS"
IFS=$'\n'
for file in $(find . -type f -name "*.csv")
do
   echo "file = '$file'"
done
IFS="$OIFS"
```


## Process CLI options
	aaa=''
	bbb=''
	ccc=''

	while [ $# -gt 0 ]
	do
	  case $1 in
	    -h) print_help ;;
	    --help) print_help ;;
	    -a) aaa=$2 ; shift 2 ;;
	    -b) bbb=$2 ; shift 2 ;;
	    -c) ccc=$2 ; shift 2 ;;
	    *) shift 1 ;;
	  esac
	done


Another way

	verbose='false'
	aflag=''
	bflag=''
	files=''
	while getopts 'abf:v' flag; do
	  case "${flag}" in
	    a) aflag='true' ;;
	    b) bflag='true' ;;
	    f) files="${OPTARG}" ;;
	    v) verbose='true' ;;
	    *) error "Unexpected option ${flag}" ;;
	  esac
	done

A more advanced options is to use [https://github.com/nk412/optparse|optparse]

## Bash dates

A simple date useful for filenaming: YYYY-MM-DD

    $(date +%F)

A full datetime

    $(date +%F-%T)

## Builtin bashism instead of external binaries

    fqdn='computer1.daveeddy.com'

    IFS=. read -r hostname domain tld <<< "$fqdn"
    echo "$hostname is in $domain.$tld"
    # => "computer1 is in daveeddy.com"

## [[ vs [

There is also the [long version](http://mywiki.wooledge.org/BashFAQ/031)

    [[ a > b ]]

    [[ -n $var && -f $var ]] && echo "$var is a file"

    [[ $var = img* && ($var = *.png || $var = *.jpg) ]] && \
        echo "$var starts with img and ends with .jpg or .png"

    [[ $name = a* ]] || echo "name does not start with an 'a': $name"

    [[ $(date) =~ ^Fri\ ...\ 13 ]] && echo "It's Friday the 13th!"


## Debug

The following code uses the DEBUG trap to inform the user about what command is about to be executed and wait for his confirmation do to so. Put this code in your script, at the location you wish to begin stepping:

    trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG

Give va value to TRACE to add -x flag to execution:

    [[ "$TRACE" ]] && set -x

## Some style

    meaningful_function_names() { ... }


    addition=$((${X} + ${Y}))
    substitution="${string/#foo/bar}"

Case formatting

	case "${expression}" in
	  a)
	    variable="..."
	    some_command "${variable}" "${other_expr}" ...
	    ;;
	  absolute)
	    actions="relative"
	    another_command "${actions}" "${other_expr}" ...
	    ;;
	  *)
	    error "Unexpected expression '${expression}'"
	    ;;
	esac

Sources: [Google](https://google.github.io/styleguide/shell.xml), 
[Progrium](https://github.com/progrium/bashstyle)
