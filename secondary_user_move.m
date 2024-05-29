function [environment_signal, secondary_users] = secondary_user_move(environment_signal, sampling_frequency, secondary_users, threshold)
    for index = 1 : length(secondary_users)
        if secondary_users(index).is_present == false
            continue;
        end

        temp_environment_signal = sum_signal(environment_signal, secondary_users(index).signal, true);
        is_spectrum_available = check_current_spectrum(temp_environment_signal, secondary_users(index).center_frequency, secondary_users(index).bandwidth, sampling_frequency, threshold);

        if ~is_spectrum_available
            environment_signal = temp_environment_signal;
            [environment_signal, lora_signal, center_frequency] = secondary_user_enter(environment_signal, ...
                secondary_users(index).id, ...
                secondary_users(index).message, ...
                secondary_users(index).bandwidth, ...
                secondary_users(index).spreading_factor, ...
                secondary_users(index).power, ...
                sampling_frequency, threshold);
            if center_frequency == 0
                secondary_users(index).is_present = false;
            else
                secondary_users(index).signal = lora_signal;
                secondary_users(index).center_frequency = center_frequency;
            end
        end
    end
end

