function [amplitude_modulated_signal, user_information, secondary_users, secondary_users_sensing_data] = create_primary_user(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    [id, bandwidth, power] = get_user_input();

    center_frequency = input("Enter signal center frequency (kHZ): ");
    center_frequency = center_frequency * 1000;
    
    lora_signal = create_lora_signal(signal_length, bandwidth, power, sampling_frequency);
    
    if isempty(lora_signal)
        new_amplitude_modulated_signal = [];
        disp("Fail to create primary user " + id + ".");
    else
        new_amplitude_modulated_signal = zeros(1, signal_length);
        temp_amplitude_modulated_signal = ammod(real(lora_signal), center_frequency, sampling_frequency);
        for i = 1:length(temp_amplitude_modulated_signal)
            new_amplitude_modulated_signal(i) = temp_amplitude_modulated_signal(i);
        end
        [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = primary_user_enter(amplitude_modulated_signal, new_amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold);
    end
    
    user_information = construct_user_information(id, bandwidth, power, center_frequency, new_amplitude_modulated_signal);
end

