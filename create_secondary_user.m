function [environment_signal, user_information] = create_secondary_user(environment_signal, sampling_frequency, threshold)
    [id, bandwidth, power] = get_basic_signal_input();
    
    [message, spreading_factor] = get_advanced_user_input();
    
    [environment_signal, lora_signal, center_frequency] = secondary_user_enter(environment_signal, id, message, bandwidth, spreading_factor, power, sampling_frequency, threshold);
    
    power = 10*log10(rms(lora_signal).^2);
    user_information = construct_user_information(id, message, bandwidth, spreading_factor, power, center_frequency, lora_signal);
    
    if center_frequency == 910e6
        user_information.is_present = false;
    end
end
