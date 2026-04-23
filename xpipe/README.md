Custom XPipe image based on the official Xpipe image but with a couple of modifications:
- Determinate Nix installed
- GNOME keyring installed and autostarted
- Moonlight installed
- RustDesk installed

## GNOME Keyring default keyring setup

To automatically set up a default keyring with a passphrase, set the `GNOME_KEYRING_PASSWORD` environment variable.
