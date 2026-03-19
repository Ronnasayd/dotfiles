#!/bin/bash
# pactl list cards | grep -i "Active Profile"
pactl list cards short # listar os cards disponíveis para identificar o nome correto
CARD="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"
MIC="alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.pro-input-7"
SINK="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.pro-output-31"

pactl set-card-profile "$CARD" HiFi

echo "Monitorando eventos ACPI do jack de áudio..."
acpi_listen | while read -r event; do
    echo "Evento ACPI: $event"
    if [[ "$event" == *"jack/headphone"* ]]; then
        if [[ "$event" == *"unplug"* ]]; then
            echo "🔊 Fone desconectado → voltando para HiFi"
            pactl set-card-profile "$CARD" HiFi
        elif [[ "$event" == *"plug"* ]]; then
            echo "🎧 Fone conectado → ativando Pro Audio"
            pactl set-card-profile "$CARD" pro-audio
            pactl set-default-source "$MIC"
            pactl set-default-sink "$SINK"
            pactl set-source-volume "$MIC" 100%
        fi
    fi
done &

# Fica vigiando o volume do mic para sempre
echo "Vigiando volume do microfone..."
pactl subscribe | while read -r event; do
    if [[ "$event" == *"'change' on source"* ]]; then
        VOL=$(pactl get-source-volume "$MIC" 2>/dev/null | grep -oP '\d+(?=%)' | head -1)
        if [[ -n "$VOL" && "$VOL" -lt 100 ]]; then
            echo "⚠️ Volume caiu para ${VOL}% → restaurando para 100%"
            pactl set-source-volume "$MIC" 100%
        fi
    fi
done
