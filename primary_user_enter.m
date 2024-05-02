function [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = primary_user_enter(amplitude_modulated_signal, user_amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    amplitude_modulated_signal = amplitude_modulated_signal + user_amplitude_modulated_signal;
    
    [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = secondary_users_move(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold);
end


