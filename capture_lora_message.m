function message = capture_lora_message(environment_signal, bandwidth, spreading_factor, sampling_frequency, center_frequency)
    message = LoRa_Rx(environment_signal, bandwidth, spreading_factor, 2, sampling_frequency, center_frequency);
end

