#!/bin/bash
cat manager.json | jq -r '.groups[3].extensions[]' | xargs -I{} google-chrome https://chromewebstore.google.com/detail/{}
