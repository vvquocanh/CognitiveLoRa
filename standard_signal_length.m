function range = standard_signal_length(sampling_frequency)
    lora_signal = LoRa_Tx("", 25e3, 7, 14, sampling_frequency, 0);
    range = length(lora_signal);
end