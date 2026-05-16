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

## Snapmaker Orca AppImage

As of May 2026 on `main-pc` with NVIDIA `595.71.05`, Snapmaker Orca's preview
renderer is not stable with accelerated rendering under Plasma Wayland.

Observed matrix:

- Full Plasma X11 session with GPU GLX: works with good preview FPS.
- Plasma Wayland with software GL: works, but preview is very slow.
- Plasma Wayland with NVIDIA/GLX-style GPU forcing: crashes while opening
  preview after slicing.
- Plasma Wayland with native Zink over NVIDIA Vulkan: crashes.
- Plasma Wayland with Xwayland plus Zink over NVIDIA Vulkan: crashes.

The common crash signature is:

```text
MESA: error: zink: couldn't allocate memory
MESA: error: ZINK: vkMapMemory failed (VK_ERROR_MEMORY_MAP_FAILED)
```

The Nix wrappers keep explicit launchers for future retesting:

```sh
snapmaker-orca-slicer
snapmaker-orca-slicer-software
snapmaker-orca-slicer-gpu
snapmaker-orca-slicer-zink
snapmaker-orca-slicer-xwayland-zink
```

Current default behavior is intentionally conservative: use GPU in a full X11
session, otherwise use software GL. If Mesa, NVIDIA, or Snapmaker Orca changes
substantially, retest the explicit GPU/Zink launchers before changing the
default Wayland behavior.
