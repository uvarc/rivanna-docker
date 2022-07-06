# Wine

https://www.winehq.org/

- Fedora 35 as base image
- Includes `wine-mono`

## Usage on Rivanna

This container image does not provide any preinstalled Windows applications. It provides Wine for you to perform your own installations on Rivanna.

### Wine Setup

1. Start a FastX MATE session or a Desktop session.

1. Pull the container image (using version 7.0.0 as an example):

    ```bash
    singularity pull docker://uvarc/wine:7.0.0
    ```

1. Create a directory for Wine installations. This is typically `~/.wine`, but you may choose any location that you have write permissions.

    ```bash
    mkdir ~/.wine
    ```

1. Set `WINEPREFIX` as the directory in the previous step upon lauching the container, e.g.:

    ```bash
    singularity shell --env WINEPREFIX=~/.wine wine_7.0.0.sif
    ```

1. Your prompt should change to `Singularity>` which indicates you are now inside the container. If you are running this for the first time, execute: `winecfg`. This step can take several minutes.

    1. If prompted, install wine-mono.
    1. Select "Install for all users".
    1. At the end you will see a window. Select the appropriate Windows version. You can choose to customize other options but usually the default should work.

### Application installation

1. Download/transfer the installer to Rivanna.

1. Run the installer through the container in FastX MATE or Desktop. For example, if there is an `INSTALL.exe` in your home directory:

    ```bash
    singularity run --env WINEPREFIX=~/.wine wine_7.0.0.sif ~/INSTALL.exe
    ```

1. Make note of where the application is installed.

### Run application

The `C:` drive is equivalent to `$WINEPREFIX/drive_c`.

```bash
singularity run --env WINEPREFIX=~/.wine wine_7.0.0.sif ~/.wine/drive_c/path/to/exe
```

Most applications are installed under `Program Files (x86)`. You will need to escape all spaces and brackets like this: `Program\ Files\ \(x86\)`.
