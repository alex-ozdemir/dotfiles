#!/usr/bin/env zsh

function rstudio {
    dir=$1
    if [[ -z $dir ]]
    then
        dir=$(pwd)
    fi
    config=~/.config/rstudio/rstudio-prefs.json 
    if [[ ! -a $config ]]
    then
        mkdir -p ${config:h}
        echo '{}' > $config
    fi
    cat $config | jq ". + {initial_working_directory:\"${dir:a:gs/\//\\\//}\"}" | sponge $config
    rstudio-bin
}
