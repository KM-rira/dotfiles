#!/bin/bash

noteall() {
    ls -tr $HOME/note/*.md| xargs -I {} glow {}
}
