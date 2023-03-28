flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

mkdir tmp
cd tmp
wget https://github.com/casey/just/releases/download/1.13.0/just-1.13.0-x86_64-unknown-linux-musl.tar.gz
mkdir -p ~/.local/bin ~/.local/share/man/man1
cp just ~/.local/bin/
cp just.1 ~/.local/share/man/man1
rm *
