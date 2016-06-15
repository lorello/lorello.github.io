# Bashism

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
