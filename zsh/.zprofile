if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
  export XDG_DATA_DIRS="/usr/local/share:/usr/share"

  #export MOZ_ENABLE_WAYLAND=1
  #exec sway
  exec systemd-cat --identifier=sway sway
fi
