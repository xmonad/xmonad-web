---
---

# In your environment - Gnome

### Ubuntu / Debian

A Gnome session for xmonad is part of the distribution package, however it is out of date. You can use the [`gnome-session-xmonad`](https://launchpad.net/~gekkio/+archive/ubuntu/xmonad) PPA to get an updated version.

### Other Distributions

If your distribution is running Gnome and X similar to Ubuntu then you will need an Xsession file, Gnome session file, and (if that is your init system) a systemd session configuration. The following file listings are from [`gnome-session-xmonad` source](https://github.com/Gekkio/gnome-session-xmonad).

- Xsession: `/usr/share/xsessions/gnome-xmonad.desktop`

  ``` ini
    [Desktop Entry]
    Name=GNOME + XMonad
    Comment=This session logs you into GNOME + XMonad
    Exec=/usr/bin/gnome-session --systemd --session=gnome-flashback-xmonad --disable-acceleration-check
    TryExec=xmonad
    Type=Application
    DesktopNames=GNOME-Flashback;GNOME;
    X-Ubuntu-Gettext-Domain=gnome-flashback
  ```

- Gnome session: `/usr/share/gnome-session/sessions`

  ``` ini
    [GNOME Session]
    Name=GNOME + XMonad
    RequiredComponents=xmonad;gnome-flashback;gnome-panel;org.gnome.SettingsDaemon.A11ySettings;org.gnome.SettingsDaemon.Color;org.gnome.SettingsDaemon.Datetime;org.gnome.SettingsDaemon.Housekeeping;org.gnome.SettingsDaemon.Keyboard;org.gnome.SettingsDaemon.MediaKeys;org.gnome.SettingsDaemon.Power;org.gnome.SettingsDaemon.PrintNotifications;org.gnome.SettingsDaemon.Rfkill;org.gnome.SettingsDaemon.ScreensaverProxy;org.gnome.SettingsDaemon.Sharing;org.gnome.SettingsDaemon.Smartcard;org.gnome.SettingsDaemon.Sound;org.gnome.SettingsDaemon.UsbProtection;org.gnome.SettingsDaemon.Wacom;org.gnome.SettingsDaemon.XSettings;
  ```

- systemd session configuration: `/usr/lib/systemd/user/gnome-session@gnome-xmonad.target.d`

  ``` ini
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

### Common Problems

* `gnome-terminal` uses new rendering facilities for its titlebar, which means it won't be hidden.
  * `gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"` seems to fix this.

* window layout changing isn't working (e.g. <SUPER> <SPACE> to switch from columns to rows)
  * Almost certainly some default Gnome or Ubuntu keybindings eating the <SUPER> key (In older versions of Ubuntu there was something in `org.gnome.settings-daemon.plugins.media-keys` but this will most likely change over time)

* In Ubuntu 20.04, the `gnome-panel` starts disappearing
  * `gnome-panel --replace` will bring it back.
  * [This issue comment](https://github.com/regolith-linux/regolith-desktop/issues/276#issuecomment-625851388) has a reliable fix but you lose desktop icons:
    * `gsettings set org.gnome.gnome-flashback desktop false`
    * `gsettings set org.gnome.gnome-flashback root-background true`

* In Ubuntu 20.04, the `gnome-panel` isn't dark any more.
  * `gsettings set org.gnome.desktop.interface icon-theme "ubuntu-mono-dark"`
  * `gsettings set org.gnome.desktop.interface gtk-theme Yaru-dark`

### Historical Versions of Ubuntu

[The wiki](https://wiki.haskell.org/Xmonad/Using_xmonad_in_Gnome) has signifcant material on how to configure XMonad with Gnome for Ubuntu versions prior to 16.04 Xenial (LTS).
