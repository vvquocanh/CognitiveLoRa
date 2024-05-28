function lora_signal = create_lora_signal(center_frequency, bandwidth, power, sampling_frequency, message, spreading_factor)
    if nargin < 5
        message = "Hello World";
    end
    if nargin < 6
        spreading_factor = 7;
    end

    lora_signal = LoRa_Tx(message, bandwidth, spreading_factor, power, sampling_frequency, center_frequency);
end

