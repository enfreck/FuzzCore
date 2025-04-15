#!/bin/bash

echo '$nrconf{restart} = "l";' | sudo tee /etc/needrestart/conf.d/no-prompt.conf
sudo systemctl restart needrestart

# Install dependencies
sudo apt-get update
sudo apt-get -y install git python3-pip

# Ensure pip is installed and upgraded
pip3 install --upgrade pip


#Download AFL++
if [ -d "./AFLplusplus" ]; then

    echo "AFL directory already exists"

else

    sudo apt-get install -y build-essential python3-dev automake cmake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev # try to install llvm 14 and install the distro default if that fails   

    sudo apt-get install -y python3-pip # for Unicorn mode

    sudo apt-get install -y lld-14 llvm-14 llvm-14-dev clang-14

    sudo apt-get install -y gcc-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-plugin-dev libstdc++-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-dev   

    sudo apt-get install -y ninja-build # for QEMU mode

    sudo apt-get install -y cpio libcapstone-dev # for Nyx mode

    sudo apt-get install -y wget curl # for Frida mode

    pip install matplotlib

    pip install pandas

    git clone https://github.com/AFLplusplus/AFLplusplus

    cd ./AFLplusplus

    git reset --hard c7ced56066953dd352ab1de341e486f9ec5e29d8 #set AFL to the correct version based on github  

    # Check and create symbolic links for clang and clang++
    if [ ! -L /usr/bin/clang ]; then
        echo "Creating symbolic link for clang..."
        sudo ln -s /usr/lib/llvm-14/bin/clang /usr/bin/clang
    else
        echo "Symbolic link for clang already exists."
    fi

    if [ ! -L /usr/bin/clang++ ]; then
        echo "Creating symbolic link for clang++..."
        sudo ln -s /usr/lib/llvm-14/bin/clang++ /usr/bin/clang++
    else
        echo "Symbolic link for clang++ already exists."
    fi

    # Check llvm-config link
    if [ ! -L /usr/bin/llvm-config ]; then
        echo "Creating symbolic link for llvm-config..."
        sudo ln -s /usr/bin/llvm-config-14 /usr/bin/llvm-config
    else
        echo "Symbolic link for llvm-config already exists."
    fi

    # Check and create symbolic link for llvm-profdata
    if [ ! -L /usr/bin/llvm-profdata ]; then
        echo "Creating symbolic link for llvm-profdata..."
        sudo ln -s /usr/lib/llvm-14/bin/llvm-profdata /usr/bin/llvm-profdata
    else
        echo "Symbolic link for llvm-profdata already exists."
    fi

    # Check and create symbolic link for llvm-cov
    if [ ! -L /usr/bin/llvm-cov ]; then
        echo "Creating symbolic link for llvm-cov..."
        sudo ln -s /usr/lib/llvm-14/bin/llvm-cov /usr/bin/llvm-cov
    else
        echo "Symbolic link for llvm-cov already exists."
    fi


    make LLVM_CONFIG=/usr/bin/llvm-config source-only

    cd ../

fi


 #Download Verilator 

wget https://github.com/verilator/verilator/archive/v5.016.tar.gz 

sudo apt-get install libsystemc libsystemc-dev 

tar -xzvf v5.016.tar.gz 

cd verilator-5.016/ 

autoupdate 

autoconf 

./configure 

make 

make test 

sudo make install 

verilator --version 

cd ../../Fuzz/ 

#Clone FuzzCore
# git clone https://github.com/FuzzCore.git 
