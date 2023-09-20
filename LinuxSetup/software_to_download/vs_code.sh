#!/bin/bash

# Check the Linux distribution and version
if [ -f /etc/os-release ]; then
    source /etc/os-release
    case $ID in
        "ubuntu" | "debian")
            # For Ubuntu and Debian-based systems
            curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb
            sudo dpkg -i vscode.deb
            rm vscode.deb
            ;;
        "fedora")
            # For Fedora-based systems
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            sudo dnf install code
            ;;
        "centos")
            # For CentOS-based systems
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            sudo yum install code
            ;;
        "arch")
            # For Arch Linux
            yay -S visual-studio-code-bin
            ;;
        "opensuse")
            # For openSUSE-based systems
            sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
            sudo zypper refresh
            sudo zypper install code
            ;;
        "solus")
            # For Solus Linux
            sudo eopkg install code
            ;;
        *)
            echo "Unsupported Linux distribution: $ID"
            exit 1
            ;;
    esac
else
    echo "Unsupported Linux distribution or missing /etc/os-release file."
    exit 1
fi

echo "Visual Studio Code has been installed successfully."

    # Install VS Code
    sudo apt-get update
    sudo apt-get install code

    echo "Visual Studio Code has been installed successfully."
else
    echo "Unsupported Linux distribution or missing /etc/os-release file."
    exit 1
fi


# example how to download the stuff

# code --install-extension coenraads.bracket-pair-colorizer




