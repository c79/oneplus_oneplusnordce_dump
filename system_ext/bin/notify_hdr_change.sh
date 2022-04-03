#!/system/bin/sh

case $1 in
    "enable") cmd display enable-hdr-mode
    ;;
    "disable") cmd display disable-hdr-mode
    ;;
esac
