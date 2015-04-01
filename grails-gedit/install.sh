#!/bin/sh

#Added directory structure verification

if [ "$1" = "--home" ]; then
	MIME_PACKAGES="$HOME/.local/share/mime/packages/"
	GTKSOURCEVIEW="$HOME/.local/share/gtksourceview-3.0/language-specs/"
	TAGLIST="$HOME/.local/share/gedit/plugins/taglist/"
	BASH_COMPLETION="$HOME/.local/etc/bash_completion.d/"
	PLUGINS="$HOME/.local/share/gedit/plugins/"
	SNIPPETS="$HOME/.local/share/gedit/plugins/snippets/"
	STYLES="$HOME/.local/share/gtksourceview-3.0/styles/"
	SCRIPTS="$HOME/.local/bin/"
	MIME_DIR="$HOME/.local/share/mime/"
else
	MIME_PACKAGES="/usr/share/mime/packages/"
	GTKSOURCEVIEW="/usr/share/gtksourceview-2.0/language-specs/"
	TAGLIST="/usr/share/gedit/plugins/taglist/"
	BASH_COMPLETION="/etc/bash_completion.d/"
	PLUGINS="/usr/share/gedit/plugins/"
	SNIPPETS="/usr/share/gedit/plugins/snippets/"
	STYLES="/usr/share/gtksourceview-3.0/styles/"
	SCRIPTS="/usr/local/bin/"
	MIME_DIR="/usr/share/mime"
fi

if [ "$1" = "--home" ]; then
    sudo=""
else
    sudo="sudo"
fi

if [ ! -d $MIME_PACKAGES ]; then
	echo "$MIME_PACKAGES doesn't exist. Creating..."
	$sudo mkdir -p $MIME_PACKAGES
fi

if [ "$1" = "--home" ]; then
	if [ ! -d $GTKSOURCEVIEW ]; then
		echo "$GTKSOURCEVIEW doesn't exist. You may need to install missing requirments. Creating..."
		mkdir -p $GTKSOURCEVIEW
	fi
else
	if [ ! -d $GTKSOURCEVIEW ]; then
		#Let's try version 3 first.
		GTKSOURCEVIEW="/usr/share/gtksourceview-3.0/language-specs/"
		if [ ! -d $GTKSOURCEVIEW ]; then
			echo "$GTKSOURCEVIEW doesn't exist. You may need to install missing requirments. Creating..."
			sudo mkdir -p $GTKSOURCEVIEW
		fi
	fi
fi

if [ ! -d $TAGLIST ]; then
	echo "$TAGLIST doesn't exist. Creating..."
	$sudo mkdir -p $TAGLIST
fi

if [ ! -d $PLUGINS ]; then
	echo "$PLUGINS doesn't exist. Creating..."
	$sudo mkdir -p $PLUGINS
fi

if [ ! -d $SNIPPETS ]; then
	echo "$SNIPPETS doesn't exist. Creating..."
	$sudo mkdir -p $SNIPPETS
fi

if [ ! -d $BASH_COMPLETION ]; then
	echo "$BASH_COMPLETION doesn't exist. Creating..."
	$sudo mkdir -p $BASH_COMPLETION
fi


#All directories should exist now, proceed with copy
$sudo cp ./groovy-mime.xml $MIME_PACKAGES
$sudo cp ./groovy.lang $GTKSOURCEVIEW
$sudo cp ./gsp-mime.xml $MIME_PACKAGES
$sudo cp ./gsp.lang $GTKSOURCEVIEW
$sudo cp ./grails_commands $BASH_COMPLETION
$sudo cp ./gred $SCRIPTS
$sudo chmod +x $SCRIPTS/gred
$sudo cp ./Grails.tags.gz $TAGLIST
#copy the styles
$sudo cp ./styles/*.xml $STYLES
#copy the snippets xml files
$sudo cp ./snippets/groovy.xml $SNIPPETS
$sudo cp ./snippets/gsp.xml $SNIPPETS

$sudo update-mime-database $MIME_DIR
echo "Install succesfull!\r\n"
