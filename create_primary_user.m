function [environment_signal, user_information, secondary_users] = create_primary_user(environment_signal, sampling_frequency, secondary_users, threshold)
    [id, bandwidth, power] = get_user_input();

    center_frequency = input("Enter signal center frequency (kHZ): ");
    center_frequency = center_frequency * 1000;
    
    lora_signal = create_primary_signal(center_frequency, bandwidth, power, sampling_frequency);

    % if isempty(lora_signal)
    %     new_amplitude_modulated_signal = [];
    %     disp("Fail to create primary user " + id + ".");
    % else
    %     % new_amplitude_modulated_signal = zeros(1, signal_length);
    %     % temp_amplitude_modulated_signal = ammod(real(lora_signal), center_frequency, sampling_frequency);
    %     % actual_power = 10 *log10(rms(temp_amplitude_modulated_signal).^2);
    %     % for i = 1:length(temp_amplitude_modulated_signal)
    %     %     new_amplitude_modulated_signal(i) = temp_amplitude_modulated_signal(i);
    %     % end
    %     % [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = primary_user_enter(amplitude_modulated_signal, new_amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold);
    % end

    [environment_signal, secondary_users] = primary_user_enter(environment_signal, lora_signal, sampling_frequency, secondary_users, threshold);
   
    user_information = construct_user_information(id, bandwidth, power, center_frequency, lora_signal);
end

