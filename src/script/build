#!/bin/bash

. ./src/script/var.sh

if [ ! -d build ]
then
    mkdir -v build
fi

if [ ! -d build/$THEME_NAME ]
then
    mkdir -pv build/$THEME_NAME/{gtk-3.0,gtk-2.0,gnome-shell}
fi

if [ ! -d build/$THEME_NAME-Dark ]
then
    mkdir -pv build/$THEME_NAME-Dark/{gtk-3.0,gtk-2.0,gnome-shell}
fi



if [ ! "$(which sassc 2> /dev/null)" ]; then
   echo sassc needs to be installed to generate the css.
   exit 1
fi

echo Generating the css...

sassc $SASSC_OPT src/gtk-3.0/gtk-contained.scss         build/$THEME_NAME/gtk-3.0/gtk.css
#sassc $SASSC_OPT src/gtk-3.0/gtk-contained-dark.scss    build/$THEME_NAME/gtk-3.0/gtk-dark.css
sassc $SASSC_OPT src/gtk-3.0/gtk-contained.scss         build/$THEME_NAME/gtk-3.0/gtk-dark.css
sassc $SASSC_OPT src/gtk-3.0/gtk-contained-dark.scss    build/$THEME_NAME-Dark/gtk-3.0/gtk.css

cp -rv src/gtk-3.0/assets build/$THEME_NAME/gtk-3.0
cp -rv src/gtk-3.0/assets build/$THEME_NAME-Dark/gtk-3.0

cp -rv src/gtk-2.0/light/* build/$THEME_NAME/gtk-2.0/
cp -rv src/gtk-2.0/dark/* build/$THEME_NAME-Dark/gtk-2.0/

sassc $SASSC_OPT src/gnome-shell/gnome-shell.scss       build/$THEME_NAME/gnome-shell/gnome-shell.css
sassc $SASSC_OPT src/gnome-shell/gnome-shell-dark.scss  build/$THEME_NAME-Dark/gnome-shell/gnome-shell.css
