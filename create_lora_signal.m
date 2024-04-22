function lora_signal = create_lora_signal(signal_length, bandwidth, power, sampling_frequency)
    for spreading_factor = 12 : -1 : 7
        signal = LoRa_Tx("Hello World!", bandwidth, spreading_factor, power, sampling_frequency, 0);
        if length(signal) <= signal_length
            lora_signal = signal;
            return;
        end
    end

    lora_signal = [];
end

