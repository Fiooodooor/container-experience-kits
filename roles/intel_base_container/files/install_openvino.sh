#!/bin/bash

OPENVINO_VERSION="$1"

compare_md5_checksum() {
    local file_path=$1
    local expected_md5=$2

    # Calculate the MD5 checksum of the file
    local calculated_md5
    calculated_md5=$(md5sum "$file_path" | awk '{print $1}')

    # Compare the calculated MD5 checksum with the expected value
    if [ "$calculated_md5" = "$expected_md5" ]; then
        echo "MD5 checksum for $file_path matches. The file is intact."
    else
        echo "MD5 checksum for $file_path does not match. The file may be altered or corrupted."
        exit 1 
    fi
}

echo "openvino version is : $OPENVINO_VERSION"

if [ "${OPENVINO_VERSION}" = "default" ]; then
    # the latest openvino 2022.3 lts release is 2022.3.1
    # default use openvino 2022.3.0 for dlsreamer 2022.3.0 compatiblity
    OPENVINO_VERSION=2022.3.0
fi
echo "openvino version is : $OPENVINO_VERSION"


if [ "${OPENVINO_VERSION}" = "2023.1.0" ]; then

    curl -L -o openvino_2023.1.0.tgz \
        https://storage.openvinotoolkit.org/repositories/openvino/packages/2023.1/linux/l_openvino_toolkit_ubuntu22_2023.1.0.12185.47b736f63ed_x86_64.tgz
    compare_md5_checksum openvino_2023.1.0.tgz 6818d7da2cf04cf0777138ff24d69511
    tar -xzvf openvino_2023.1.0.tgz
    mv l_openvino_toolkit_ubuntu22_2023.1.0.12185.47b736f63ed_x86_64 /opt/intel/openvino_2023.1.0
    ln -s /opt/intel/openvino_2023.1.0 /opt/intel/openvino_2023
    ln -s /opt/intel/openvino_2023.1.0 /opt/intel/openvino

elif [ "${OPENVINO_VERSION}" = "2023.0.0" ]; then

    curl -L -o openvino_2023.0.0.tgz \
        https://storage.openvinotoolkit.org/repositories/openvino/packages/2023.0/linux/l_openvino_toolkit_ubuntu22_2023.0.0.10926.b4452d56304_x86_64.tgz
    compare_md5_checksum openvino_2023.0.0.tgz 78fceeb2a84713a8bcbd4798a5272787
    tar -xzvf openvino_2023.0.0.tgz
    mv l_openvino_toolkit_ubuntu22_2023.0.0.10926.b4452d56304_x86_64 /opt/intel/openvino_2023.0.0
    ln -s /opt/intel/openvino_2023.0.0 /opt/intel/openvino_2023
    ln -s /opt/intel/openvino_2023.0.0 /opt/intel/openvino

else

    curl -L -o openvino_2022.3.0.tgz \
        https://storage.openvinotoolkit.org/repositories/openvino/packages/2022.3/linux/l_openvino_toolkit_ubuntu20_2022.3.0.9052.9752fafe8eb_x86_64.tgz
    compare_md5_checksum openvino_2022.3.0.tgz f727761fd9759f8ea214f5991dae3e79
    tar -xzvf openvino_2022.3.0.tgz
    mv l_openvino_toolkit_ubuntu20_2022.3.0.9052.9752fafe8eb_x86_64 /opt/intel/openvino_2022.3.0
    ln -s /opt/intel/openvino_2022.3.0 /opt/intel/openvino_2022
    ln -s /opt/intel/openvino_2022.3.0 /opt/intel/openvino

fi

cd /opt/intel/openvino || exit
./install_dependencies/install_openvino_dependencies.sh -y
apt-get install -y libtbb2
