#!/bin/bash
export _JAVA_AWT_WM_NONREPARENTING=1
export GDK_SCALE=1 # or 2 depending on DPI
export GDK_BACKEND=wayland,x11
export JETBRAINS_JDK=/idontknow/whatmypath/is
/webstorm-install-dir/bin/webstorm.sh
