function [amplitude_modulated_signal, user_information, sensing_data] = create_secondary_user(amplitude_modulated_signal, signal_length, sampling_frequency, threshold)
    [id, bandwidth, power] = get_user_input();

    lora_signal = create_lora_signal(signal_length, bandwidth, power, sampling_frequency);

    if isempty(lora_signal)
        new_amplitude_modulated_signal = [];
    else
        [amplitude_modulated_signal, new_amplitude_modulated_signal, center_frequency, beginning_index, last_index] = secondary_user_enter(amplitude_modulated_signal, signal_length, lora_signal, bandwidth, sampling_frequency, threshold);
    end
    
    user_information = construct_user_information(id, bandwidth, power, center_frequency, new_amplitude_modulated_signal);
    if isempty(new_amplitude_modulated_signal)
        disp("No free spectrum available for user " + id + ".");
        user_information.is_present = false;
    end
    sensing_data = construct_sensing_data(id, lora_signal, beginning_index, last_index);
end
