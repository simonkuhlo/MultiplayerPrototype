#!/bin/sh
echo -ne '\033c\033]0;MultiplayerFPSTest\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/TurboUnstable_v0_3_0.x86_64" "$@"
