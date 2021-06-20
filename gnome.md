---
---

# In your environment - Gnome

### Ubuntu / Debian

A Gnome session for xmonad is part of the distribution package, however it is out of date. You can use the [`gnome-session-xmonad`](https://launchpad.net/~gekkio/+archive/ubuntu/xmonad) PPA to get an updated version.

### Other Distributions

If you're distribution is running Gnome and X similar to Ubuntu then you will need a Xsession file, Gnome session file, and a systemd session configuration. The following file listings are from [`gnome-session-xmonad` source](https://github.com/Gekkio/gnome-session-xmonad).

Xsession: `/usr/share/xsessions/gnome-xmonad.desktop`  
```
[Desktop Entry]
Name=GNOME + XMonad
Comment=This session logs you into GNOME + XMonad
Exec=/usr/bin/gnome-session --systemd --session=gnome-flashback-xmonad --disable-acceleration-check
TryExec=xmonad
Type=Application
DesktopNames=GNOME-Flashback;GNOME;
X-Ubuntu-Gettext-Domain=gnome-flashback
```

Gnome session: `/usr/share/gnome-session/sessions`  
```
[GNOME Session]
Name=GNOME + XMonad
RequiredComponents=xmonad;gnome-flashback;gnome-panel;org.gnome.SettingsDaemon.A11ySettings;org.gnome.SettingsDaemon.Color;org.gnome.SettingsDaemon.Datetime;org.gnome.SettingsDaemon.Housekeeping;org.gnome.SettingsDaemon.Keyboard;org.gnome.SettingsDaemon.MediaKeys;org.gnome.SettingsDaemon.Power;org.gnome.SettingsDaemon.PrintNotifications;org.gnome.SettingsDaemon.Rfkill;org.gnome.SettingsDaemon.ScreensaverProxy;org.gnome.SettingsDaemon.Sharing;org.gnome.SettingsDaemon.Smartcard;org.gnome.SettingsDaemon.Sound;org.gnome.SettingsDaemon.UsbProtection;org.gnome.SettingsDaemon.Wacom;org.gnome.SettingsDaemon.XSettings;
```

systemd session configuration: `/usr/lib/systemd/user/gnome-session@gnome-xmonad.target.d`  
```
[Unit]
Wants=org.gnome.SettingsDaemon.A11ySettings.target
Wants=org.gnome.SettingsDaemon.Color.target
Wants=org.gnome.SettingsDaemon.Datetime.target
Wants=org.gnome.SettingsDaemon.Housekeeping.target
Wants=org.gnome.SettingsDaemon.Keyboard.target
Wants=org.gnome.SettingsDaemon.MediaKeys.target
Wants=org.gnome.SettingsDaemon.Power.target
Wants=org.gnome.SettingsDaemon.PrintNotifications.target
Wants=org.gnome.SettingsDaemon.Rfkill.target
Wants=org.gnome.SettingsDaemon.ScreensaverProxy.target
Wants=org.gnome.SettingsDaemon.Sharing.target
Wants=org.gnome.SettingsDaemon.Smartcard.target
Wants=org.gnome.SettingsDaemon.Sound.target
Wants=org.gnome.SettingsDaemon.UsbProtection.target
Wants=org.gnome.SettingsDaemon.Wacom.target
Wants=org.gnome.SettingsDaemon.XSettings.target

Requires=gnome-flashback.target
Requires=indicators-pre.target

# here we list the indicators that we want to load
Wants=indicator-application.service
Wants=indicator-bluetooth.service
Wants=indicator-datetime.service
Wants=indicator-keyboard.service
Wants=indicator-messages.service
Wants=indicator-power.service
Wants=indicator-printers.service
Wants=indicator-session.service
Wants=indicator-sound.service
```

### Historical Versions of Ubuntu

[The wiki](https://wiki.haskell.org/Xmonad/Using_xmonad_in_Gnome) has signifcant material on how to configure XMonad with Gnome for Ubuntu versions prior to 16.04 Xenial (LTS).
