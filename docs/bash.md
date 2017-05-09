# Bashism

I use a little library to have a common set of utilities out of the box in my
bash scripts, it can be retrieved at https://github.com/lorello/lib.sh

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
    while [ $counter -le 10 ]
    do
    echo $counter
    ((counter++))
    done

process cli options

# Process CLI options
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

A more advanced options is to use [https://github.com/nk412/optparse|optparse]

## Bash dates

A simple date useful for filenaming: YYYY-MM-DD

    $(date +%F)

A full datetime

    $(date +%F-%T)
