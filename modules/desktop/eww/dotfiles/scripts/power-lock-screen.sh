#!/usr/bin/env bash

eww open dashboard --toggle &&
eww update power-dropdown-opened=false &&

swaylock \
    --image /home/moonlander/Pictures/wallpapers/backiee-81597-landscape.jpg \
    --clock \
    --indicator \
    --indicator-radius 100 \
    --indicator-thickness 3 \
    --effect-vignette 0.5:0.5 \
    --ring-color 5CCFE6 \
    --key-hl-color F28779 \
    --line-color 00000000 \
    --text-color FFAD66 \
    --inside-color 1F2430 \
    --separator-color D4BFFF \
    --text-wrong-color FFAD66 \
    --inside-wrong-color 1F2430 \
    --line-wrong-color 5CCFE6 \
    --text-ver-color FFAD66 \
    --inside-ver-color 1F2430 \
    --line-ver-color 5CCFE6 \
    --grace 0 \
    --fade-in 0.6