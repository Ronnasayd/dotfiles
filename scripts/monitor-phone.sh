#!/bin/bash
# pactl list cards | grep -i "Active Profile"
pactl list cards short # listar os cards disponíveis para identificar o nome correto
CARD="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"
pactl set-card-profile "$CARD" HiFi

echo "Monitorando eventos ACPI do jack de áudio..."
acpi_listen | while read -r event; do
    echo "Evento ACPI: $event"
    if [[ "$event" == *"jack/headphone"* ]]; then
        if [[ "$event" == *"unplug"* ]]; then
             echo "🔊 Fone desconectado → voltando para stereo-fallback"
             pactl set-card-profile "$CARD" HiFi
        elif [[ "$event" == *"plug"* ]]; then
            echo "🎧 Fone conectado → ativando Pro Audio"
            pactl set-card-profile "$CARD" pro-audio

            MIC="alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.pro-input-7"
            SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.pro-output-31"

            pactl set-default-source "$MIC"
            pactl set-default-sink "$SINK"

            # volume do microfone no máximo (100%)
            # pactl set-source-volume "$MIC" 100%

            # opcional: permitir boost (até 150% ou mais)
            pactl set-source-volume "$MIC" 150%
        fi
    fi
done
