function [environment_signal, lora_signal, center_frequency] = secondary_user_enter(environment_signal, id, message, bandwidth, spreading_factor, power, sampling_frequency, threshold)
    default_center_frequency = 910e6;
    center_frequency = sense_free_spectrum(environment_signal, bandwidth, sampling_frequency, threshold);
    if center_frequency == 0
        center_frequency = default_center_frequency;
    end
    
    lora_signal = LoRa_Tx(message, bandwidth, spreading_factor, power, sampling_frequency, center_frequency);

    if center_frequency == default_center_frequency
        disp("No free spectrum available for user " + id + ", using the default center frequency 910MHz.");
    else
        environment_signal = sum_signal(environment_signal, lora_signal);
    end
end
