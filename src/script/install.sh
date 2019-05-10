#!/bin/bash

. ./src/script/var.sh

if [ $EUID -eq 0 ]
then
    if [ -d /usr/share/themes/$THEME_NAME ]
    then
        rm -rv /usr/share/themes/$THEME_NAME
    fi

    if [ -d /usr/share/themes/$THEME_NAME-Dark ]
    then
        rm -rv /usr/share/themes/$THEME_NAME-Dark
    fi

    cp -R ./build/* /usr/share/themes
else
    if [ -d ~/.themes/$THEME_NAME ]
    then
        rm -rv ~/.themes/$THEME_NAME
    fi

    if [ -d ~/.themes/$THEME_NAME-Dark ]
    then
        rm -rv ~/.themes/$THEME_NAME-Dark
    fi

    if [ ! -d ~/.themes ]
    then
        mkdir -v ~/.themes
    fi

    cp -rv ./build/* ~/.themes
fi


