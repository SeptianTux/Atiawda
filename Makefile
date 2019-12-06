C=sassc
FLAGS=-M -t nested
#FLAGS=-M -t compact
THEME_NAME=Atiawda
BUILD_DIR=build

.PHONY: build

.ONESHELL:
SHELL = /bin/bash

prepare:
		if [ ! -d build ]; then \
			mkdir build; \
		fi
		if [ ! -d $(BUILD_DIR)/$(THEME_NAME) ]; then \
			mkdir -p $(BUILD_DIR)/$(THEME_NAME)/{gtk-3.0,gtk-2.0,gnome-shell}; \
		fi
		if [ ! -d $(BUILD_DIR)/$(THEME_NAME)-Dark ]; then \
			mkdir -p $(BUILD_DIR)/$(THEME_NAME)-Dark/{gtk-3.0,gtk-2.0}; \
		fi
		if [ ! `which sassc 2> /dev/null` ]; then \
			echo -e "\n\nsassc needs to be installed to generate the css.\n\n"; \
			exit 1;
		fi

build:
		$(C) $(FLAGS) src/gtk-3.0/gtk-contained.scss $(BUILD_DIR)/$(THEME_NAME)/gtk-3.0/gtk.css
		$(C) $(FLAGS) src/gtk-3.0/gtk-contained.scss $(BUILD_DIR)/$(THEME_NAME)/gtk-3.0/gtk-dark.css
		$(C) $(FLAGS) src/gtk-3.0/gtk-contained-dark.scss $(BUILD_DIR)/$(THEME_NAME)-Dark/gtk-3.0/gtk.css
		cp -r src/gtk-3.0/assets $(BUILD_DIR)/$(THEME_NAME)/gtk-3.0
		cp -r src/gtk-3.0/assets $(BUILD_DIR)/$(THEME_NAME)-Dark/gtk-3.0
		cp -r src/gtk-2.0/light/* $(BUILD_DIR)/$(THEME_NAME)/gtk-2.0/
		cp -r src/gtk-2.0/dark/* $(BUILD_DIR)/$(THEME_NAME)-Dark/gtk-2.0/
		$(C) $(FLAGS) src/gnome-shell/gnome-shell-dark.scss $(BUILD_DIR)/$(THEME_NAME)/gnome-shell/gnome-shell.css

clean:
		if [ -d $(BUILD_DIR)/$(THEME_NAME) ]; then \
			rm -r $(BUILD_DIR)/$(THEME_NAME); \
		fi
		if [ -d $(BUILD_DIR)/$(THEME_NAME)-Dark ]; then \
			rm -r $(BUILD_DIR)/$(THEME_NAME)-Dark; \
		fi

install-only: 
		if [ $$EUID -eq 0 ]; then \
			if [ -d /usr/share/themes/$(THEME_NAME) ]; then \
				rm -r /usr/share/themes/$(THEME_NAME); \
			fi
			if [ -d /usr/share/themes/$(THEME_NAME)-Dark ]; then \
				rm -r /usr/share/themes/$(THEME_NAME)-Dark; \
			fi
			cp -R $(BUILD_DIR)/* /usr/share/themes
		else \
			if [ -d ~/.themes/$(THEME_NAME) ]; then \
				rm -r ~/.themes/$(THEME_NAME); \
			fi
			if [ -d ~/.themes/$(THEME_NAME)-Dark ]; then \
				rm -r ~/.themes/$(THEME_NAME)-Dark; \
			fi
			if [ ! -d ~/.themes ]; then \
				mkdir -v ~/.themes; \
			fi
			cp -r $(BUILD_DIR)/* ~/.themes; \
		fi

install: clean prepare build install-only

uninstall:
		if [ $$EUID -eq 0 ]; then \
			if [ -d /usr/share/themes/$(THEME_NAME) ]; then \
				rm -r /usr/share/themes/$(THEME_NAME); \
			fi
			if [ -d /usr/share/themes/$(THEME_NAME)-Dark ]; then \
				rm  -r /usr/share/themes/$(THEME_NAME)-Dark; \
			fi
		else
			if [ -d ~/.themes/$(THEME_NAME) ]; then \
				rm -r ~/.themes/$(THEME_NAME); \
			fi
			if [ -d ~/.themes/$(THEME_NAME)-Dark ]; then \
				rm -r ~/.themes/$(THEME_NAME)-Dark; \
			fi
		fi




