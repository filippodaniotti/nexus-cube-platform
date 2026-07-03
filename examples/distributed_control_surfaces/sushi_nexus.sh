#!/bin/bash

# Launch Sushi with a configuration file that loads a VST synthesizer
# Only output ports are needed

CONFIG_ROOT=$HOME/.config/sushi
PLUGIN_ROOT=$HOME/.local/share/vst3

# Close sushi if open
pkill -SIGINT -f sushi
sleep 1

# Launch Sushi with pw-jack
pw-jack /usr/bin/sushi --jack --base-plugin-path $PLUGIN_ROOT -c "$CONFIG_ROOT/nexus.json"  &

SUSHI_PID=$!

# Sushi audio output to system playback
sleep 5 
echo "Connecting Output Ports"
pw-link sushi:audio_output_0 alsa_output.platform-soc_107c000000_sound.stereo-fallback:playback_FL
pw-link sushi:audio_output_1 alsa_output.platform-soc_107c000000_sound.stereo-fallback:playback_FR
pw-link cube-keyboard:netump_out "Midi-Bridge:Sushilisten:in (playback)"
pw-link cube-phone:netump_out  "Midi-Bridge:Sushilisten:in (playback)"
pw-link cube-keyboard:netump_out cube-phone:netump_in 
pw-link cube-phone:netump_out cube-keyboard:netump_in
echo "Done connecting"

wait $SUSHI_PID
