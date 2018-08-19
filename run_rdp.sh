#!/bin/sh
xfreerdp /v:$(cat ip):3389 /w:1600 /h:900 /bpp:32 +clipboard +fonts /gdi:hw /rfx /rfx-mode:video /sound:sys:pulse +menu-anims +window-drag /d:$(cat domain) /u:$(cat username) -toggle-fullscreen /rfx
