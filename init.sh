#!/bin/sh

dirs=(
	~/Desktop
	~/Documents
	~/Downloads
	~/Library
	~/Library/Favorites
	~/Movies
	~/Music
	~/Pictures
	~/Public
	/Applications
)
for d in ${dirs[@]}
do
	cd $d
	mv .localized .localized.disable
done
