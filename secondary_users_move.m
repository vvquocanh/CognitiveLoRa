function [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = secondary_users_move(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, threshold)
    for user_index = 1 : length(secondary_users)
        if secondary_users(user_index).is_present == false
            continue;
        end

        sensing_data_index = get_proper_index(secondary_users(user_index).id, secondary_users_sensing_data);

        temp_amplitude_modulated_signal = amplitude_modulated_signal - secondary_users(user_index).amplitude_modulated_signal;
        is_spectrum_available = check_current_spectrum(temp_amplitude_modulated_signal, secondary_users_sensing_data(sensing_data_index).beginning_index, secondary_users_sensing_data(sensing_data_index).last_index, threshold, sampling_frequency);

        if ~is_spectrum_available
            [amplitude_modulated_signal, new_amplitude_modulated_signal, center_frequency, beginning_index, last_index] = secondary_user_enter(temp_amplitude_modulated_signal, signal_length, secondary_users_sensing_data(sensing_data_index).lora_signal, secondary_users(user_index).bandwidth, sampling_frequency, threshold);
            if center_frequency == 0
                disp("No free spectrum available for user " + secondary_users(user_index).id + ".");
                secondary_users(user_index).is_present = false;
            else
                secondary_users(user_index).amplitude_modulated_signal = new_amplitude_modulated_signal;
                secondary_users(user_index).center_frequency = center_frequency;
                secondary_users_sensing_data(sensing_data_index).beginning_index = beginning_index;
                secondary_users_sensing_data(sensing_data_index).last_index = last_index;
            end
        end
    end
end

function index = get_proper_index(id, users)
    index = -1;
    for i = 1 : length(users)
        if users(i).id == id
            index = i;
            return;
        end
    end
end

