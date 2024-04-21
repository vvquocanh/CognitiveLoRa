function amplitude_modulated_signal = primary_user_enter(amplitude_modulated_signal, user_amplitude_modulated_signal, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    expected_amplitude_modulated_signal = amplitude_modulated_signal + user_amplitude_modulated_signal;


end

function amplitude_modulated_signal = secondary_users_handling(amplitude_modulated_signal, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    for index = 1 : length(secondary_users)
        amplitude_modulated_signal_without_secondary_user = amplitude_modulated_signal - secondary_users(index).amplitude_modulated_signal;
        is_spectrum_available = check_current_spectrum(amplitude_modulated_signal_without_secondary_user, secondary_users_sensing_data(index).beginning_index, secondary_users_sensing_data(index).last_index, threshold, sampling_frequency);

        if ~is_spectrum_available
            amplitude_modulated_signal = amplitude_modulated_signal - secondary_users(index).amplitude_modulated_signal;
            
        end
    end
end

