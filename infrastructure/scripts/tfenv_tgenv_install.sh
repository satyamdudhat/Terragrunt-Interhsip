#!/bin/bash

# Install tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.tfenv/bin:$PATH"

# Install tgenv        
git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv
echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.tgenv/bin:$PATH"
