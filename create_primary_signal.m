function lora_signal = create_primary_signal(center_frequency, bandwidth, power, sampling_frequency)
    default_message = "Hello World!";
    default_spreading_factor = 7;

    lora_signal = LoRa_Tx(default_message, bandwidth, default_spreading_factor, power, sampling_frequency, center_frequency);
end

