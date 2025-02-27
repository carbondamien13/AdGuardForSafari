#!/bin/bash

set -e

# copy scriptlets.js
cp node_modules/@adguard/scriptlets/dist/scriptlets.js ../AdGuard/AdvancedBlocking

# copy extended-css.js
cp node_modules/extended-css/dist/extended-css.js ../AdGuard/AdvancedBlocking

# copy assistant.embedded.js
cp node_modules/assistant/dist/assistant.embedded.js ../AdGuard/Extension
