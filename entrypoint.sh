#!/bin/bash

git clone https://github.com/JohnSundell/Publish.git
cd Publish
swift build -c release
sudo install .build/release/publish-cli /usr/local/bin/publish
publish generate