#!/bin/bash
pactl list cards short # listar os cards disponíveis para identificar o nome correto
CARD="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"
pactl set-card-profile "$CARD" output:stereo-fallback+input:stereo-fallback

echo "Monitorando eventos ACPI do jack de áudio..."
acpi_listen | while read -r event; do
    echo "Evento ACPI: $event"
    if [[ "$event" == *"jack/headphone"* ]]; then
        if [[ "$event" == *"unplug"* ]]; then
             echo "🔊 Fone desconectado → voltando para stereo-fallback"
             pactl set-card-profile "$CARD" output:stereo-fallback+input:stereo-fallback
        elif [[ "$event" == *"plug"* ]]; then
            echo "🎧 Fone conectado → ativando Pro Audio"
            pactl set-card-profile "$CARD" pro-audio
            pactl set-default-source alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.pro-input-7
            pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.pro-output-31
        fi
    fi
done
