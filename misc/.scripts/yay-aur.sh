#!/bin/bash

# Pass -y to skip the PKGBUILD review step

# First, review the PKGBUILDs, then quit before installing all
if [[ $1 != -y ]]; then
    yay -aSu --noupgrademenu --noremovemake --answerclean=None --answerdiff=All || true
fi

# Individually install only AUR packages which are in need of upgrade
for pkg in $(yay -aQuq); do  # For all AUR packages needing upgrade
    is_dependency=''  # pacman installs as --asexplicit by default

    if [[ $(pacman -Qdtq "$pkg") ]]; then  # the package is installed as a dependency
        echo "Updating $pkg as a dependency..."
        is_dependency=--asdeps  # pacman flag to mark as installed as dependency
    else
        echo "Updating $pkg..."
    fi

    # yay will still confirm if any diffs are shown even with --noconfirm so pass --noanswerdiff
    # https://github.com/Jguer/yay/issues/830
    yay -aS --needed $is_dependency --noconfirm --answerdiff=None --noredownload "$pkg"
done

# Show if any upgrades are still needed (ie, something failed above)
yay -aQu
