#!/bin/bash

ls -t $HOME/note/*.md| xargs -I {} glow {}
