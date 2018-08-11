clear
echo "
   _________ __       __       ____               _           __ 
  / ____/ (_) /______/ /_     / __ \_________    (_)__  _____/ /_
 / / __/ / / __/ ___/ __ \   / /_/ / ___/ __ \  / / _ \/ ___/ __/
/ /_/ / / / /_/ /__/ / / /  / ____/ /  / /_/ / / /  __/ /__/ /_  
\____/_/_/\__/\___/_/ /_/  /_/   /_/   \____/_/ /\___/\___/\__/  
                                           /___/
";

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/glitch"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/glitch"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.glitch"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[+] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[-] A directory glitch was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/glitch*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/glitch*"
        fi
    else
        echo "[-] If you want to install you must remove previous installations [-] ";
        echo "[-] Installation failed! [-] ";
        exit
    fi
fi
echo "[+] Cleaning up old directories...";
if [ -d "$ETC_DIR/YourAnonMafia" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/YourAnonMafia"
    else
        sudo rm -rf "$ETC_DIR/YourAnonMafia"
    fi
fi

echo "[+] Installing ...";
echo "";
git clone --depth=1 https://github.com/YourAnonMafia/glitch "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/glitch.py" '${1+"$@"}' > "$INSTALL_DIR/glitch";
chmod +x "$INSTALL_DIR/glitch";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/glitch" "$BIN_DIR"
    cp "$INSTALL_DIR/glitch.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/glitch" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/glitch.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/glitch";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[+] Tool installed successfully! [+]";
    echo "";
    echo "[+]====================================================================[+]";
    echo "[+]      All is done!! You can execute tool by typing glitch !         [+]";
    echo "[+]====================================================================[+]";
    echo "";
else
    echo "[-] Installation failed! [-] ";
    exit
fi
