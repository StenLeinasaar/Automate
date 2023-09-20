#!/bin/bash

# Function to display an error message and exit
display_error() {
    echo -e "\033[91mError: $1\033[0m"
    exit 1
}

# Load the configuration file and check its existence
config_file="LinuxSetup/config_linux.sh"
if [ ! -e "$config_file" ]; then
    display_error "Configuration file not found: $config_file"
fi

# Source the configuration file
source "$config_file"

# Check if required variables are set in the configuration
required_vars=("vs_code")
for var in "${required_vars[@]}"; do
    if [ -z "${config[$var]}" ]; then
        display_error "Required variable '$var' is not set in the configuration file."
    fi
done

vs_code="${config['vs_code']}"



####  Make sure neccesary package manager exists. #######


# Function to install a package manager if it is missing
install_package_manager() {
    local package_manager="$1"
    if ! command -v "$package_manager" &>/dev/null; then
        echo "$package_manager is not installed. Attempting to install..."
        
        # Install the package manager based on the Linux distribution
        case "$distro" in
            "ubuntu" | "debian")
                sudo apt-get update
                sudo apt-get install -y "$package_manager"
                ;;
            "fedora")
                sudo yum install -y "$package_manager"
                ;;
            "opensuse")
                sudo zypper install -y "$package_manager"
                ;;
            "arch")
                sudo pacman -Syu --noconfirm "$package_manager"
                ;;
            "solus")
                sudo eopkg install -y "$package_manager"
                ;;
            *)
                echo "Unsupported package manager for $distro: $package_manager"
                exit 1
                ;;
        esac

        echo "$package_manager has been installed."
    fi
}

# Determine the Linux distribution
if [ -f /etc/os-release ]; then
    distro="$(cat /etc/os-release | grep -w "ID" | tr "=" " " | awk {'print $2'})"
else
    echo "Unsupported Linux distribution or missing /etc/os-release file."
    exit 1
fi

# Call the function to check and install the package manager based on the distribution
case "$distro" in
    "ubuntu" | "debian")
        install_package_manager "apt-get"
        ;;
    "fedora")
        install_package_manager "dnf"
        ;;
    "opensuse")
        install_package_manager "zypper"
        ;;
    "arch")
        install_package_manager "pacman"
        ;;
    "solus")
        install_package_manager "eopkg"
        ;;
    *)
        echo "Unsupported Linux distribution: $distro"
        exit 1
        ;;
esac



### Check if package manager exists


#####  Visual Studio Code Download + Personalize ######

if ! command -v code &>/dev/null; then
    echo "Visual Studio Code is not installed. Please install it first."
    exit 1
else
    source $vs_code
fi







