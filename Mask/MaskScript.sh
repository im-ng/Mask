#!/bin/sh

#  MaskScript.sh
#  Mask
#
#  Created by ng on 29/07/20.
#  Copyright © 2020 ng. All rights reserved.
defaults write com.apple.finder CreateDesktop $1
killall Finder
    