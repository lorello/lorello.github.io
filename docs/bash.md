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
