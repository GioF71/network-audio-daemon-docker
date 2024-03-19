#!/bin/bash

# install the downloaded package
dpkg -i /app/release/naa.deb
rm /app/release/naa.deb
rm -Rf /app/release/

