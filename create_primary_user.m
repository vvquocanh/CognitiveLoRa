function [amplitude_modulated_signal, user_information] = create_primary_user(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    [id, bandwidth, power] = get_user_input();

    center_frequency = input("Enter signal center frequency (kHZ): ");
    center_frequency = center_frequency * 1000;
    
    lora_signal = create_lora_signal(signal_length, bandwidth, power, sampling_frequency);
    
    if isempty(lora_signal)
        new_amplitude_modulated_signal = [];
        disp("Fail to create primary user " + id + ".");
    else
        new_amplitude_modulated_signal = ammod(real(lora_signal), center_frequency, sampling_frequency);
        amplitude_modulated_signal = primary_user_enter(amplitude_modulated_signal, new_amplitude_modulated_signal, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold);
    end
    
    user_information = construct_user_information(id, bandwidth, power, center_frequency, new_amplitude_modulated_signal);
end

