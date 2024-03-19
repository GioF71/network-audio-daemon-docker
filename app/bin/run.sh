#!/bin/bash

if [[ -n "${NAA_NAME}" ]]; then
    export NETWORKAUDIOD_NAME="${NAA_NAME}"
fi

/usr/sbin/networkaudiod

