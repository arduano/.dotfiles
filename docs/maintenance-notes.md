# Maintenance Notes

This file is for operational state that is intentionally not encoded directly in
the NixOS configuration.

## Bambu Studio Flatpak

Bambu Studio is currently best kept as the Flathub package. The native Nixpkgs
package has lagged behind Flathub, and Bambu's Linux path depends on runtime
details that are easier to keep with Flatpak.

Known manual fixes:

```sh
# Keep Bambu on Xwayland and avoid known WebKit renderer problems.
flatpak override --user com.bambulab.BambuStudio \
  --nosocket=wayland \
  --socket=x11 \
  --socket=fallback-x11 \
  --filesystem=host \
  --env=GDK_BACKEND=x11 \
  --env=WEBKIT_DISABLE_DMABUF_RENDERER=1 \
  --env=WEBKIT_DISABLE_COMPOSITING_MODE=1 \
  --env=SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
```

If Bambu's 3D viewport is blank, grey, or otherwise broken after an NVIDIA
driver update, make sure Flatpak has the exact matching NVIDIA GL runtime:

```sh
driver="$(nvidia-smi --query-gpu=driver_version --format=csv,noheader | head -n1 | tr . -)"
flatpak install --user flathub "org.freedesktop.Platform.GL.nvidia-${driver}//1.4"
```

If Bambu menu text renders as square missing-glyph boxes, bypass the Flathub
entrypoint's forced `LC_ALL=C.UTF-8` locale:

```sh
flatpak run \
  --command=bambu-studio \
  --env=LC_ALL=en_AU.utf8 \
  --env=LANG=en_AU.UTF-8 \
  com.bambulab.BambuStudio
```

Useful font-cache reset commands if text rendering regresses:

```sh
flatpak run --command=fc-cache com.bambulab.BambuStudio -f -v
mv ~/.var/app/com.bambulab.BambuStudio/config/BambuStudio/cache/fonts.cereal \
  ~/.var/app/com.bambulab.BambuStudio/config/BambuStudio/cache/fonts.cereal.bak
```
