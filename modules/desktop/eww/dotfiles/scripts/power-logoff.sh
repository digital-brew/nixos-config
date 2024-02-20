#!/usr/bin/env bash

eww open dashboard --toggle &&
eww update power-dropdown-opened=false &&

loginctl kill-user $(whoami)