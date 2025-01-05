#!/bin/bash

sketchybar --add item media center \
           --set media label.color="${ACCENT_COLOR}" \
                       label.max_chars=75 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon=" "             \
                       icon.color="${ACCENT_COLOR}"   \
                       background.drawing=off \
                       script="${PLUGIN_DIR}/media.sh" \
           --subscribe media media_change

