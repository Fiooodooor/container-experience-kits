#!/bin/bash

TEST_POSTFIX="$1"

result="Failed"
pass_count=0
echo "---------------------Check glxinfo -------------------"
glxinfo | grep OpenGL
if glxinfo | grep OpenGL | grep "Intel" | grep "Graphics"
then
    (( pass_count+=1 )) || true
else
    result_failed_txt="Get glxinfo: Failed."
    echo "glxinfo: Failed"
fi

echo "---------------------Check clinfo ------------------- "
clinfo  | grep Device
if clinfo  | grep Device | grep "Intel" | grep "Graphics"
then
    (( pass_count+=1 )) || true
else
    result_failed_txt="Get clinfo: Failed. ${result_failed_txt}"
    echo "clinfo: Failed"
fi

echo "---------------------Check vulkaninfo ----------------- "
vulkaninfo | grep deviceName
if vulkaninfo | grep deviceName | grep "Intel" | grep "Graphics"
then
    (( pass_count+=1 )) || true
else
    result_failed_txt="Get vulkaninfo: Failed. ${result_failed_txt}"
    echo "vulkaninfo: Failed"
fi

echo "---------------------Check vainfo --------------------"
vainfo | grep Driver
if vainfo | grep Driver | grep "Intel" | grep "Graphics"
then
    (( pass_count+=1 )) || true
else
    result_failed_txt="Get vainfo: Failed. ${result_failed_txt}"
    echo "vainfo: Failed"
fi

if [[ ${pass_count} -eq 4 ]]
then
    result="Passed"
else
    result="Failed: ${result_failed_txt}"
fi

echo "${result}" | tee "$HOME"/data/test_gpu_result_"$TEST_POSTFIX"
