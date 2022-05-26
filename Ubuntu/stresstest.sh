#!/bin/sh

wget https://github.com/nakabonne/ali/releases/download/v0.7.2/ali_0.7.2_linux_amd64.deb
sudo apt install ./ali_0.7.2_linux_amd64.deb

ali --rate=50 --duration=1m --method=POST https://search.lagenhetsbyte.se
