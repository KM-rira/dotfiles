#!/bin/bash

noteall() {
    ls -t $HOME/note/*.md| xargs -I {} glow {}
}
