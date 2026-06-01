#!/usr/bin/env bash
: <<DOCXX
A scrable-like slot machine game
Author: morgan@morganism.dev
Date: Mon  1 Jun 2026 02:01:41 BST
DOCXX

git clone https://github.com/morganism/reelwords.git

cd reelwords

bundle install

rake spec

./reelwords.play
