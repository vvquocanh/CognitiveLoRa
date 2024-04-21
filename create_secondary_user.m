function user_information = create_secondary_user(amplitude_modulated_signal, signal_length, sampling_frequency, threshold)
    [id, bandwidth, power] = get_user_input();

    lora_signal = create_lora_signal(signal_length, bandwidth, power, sampling_frequency);

    if isempty(lora_signal)
        new_amplitude_modulated_signal = [];
    else
        [pxx, frequencies] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
        center_frequency = sense_free_spectrum(pxx, frequencies, bandwidth, threshold);
        if center_frequency == 0
            disp("No free spectrum available.");
            new_amplitude_modulated_signal = [];
        else
            new_amplitude_modulated_signal = ammod(real(lora_signal), center_frequency, sampling_frequency);
        end
    end
    
    user_information = construct_user_information(id, bandwidth, power, center_frequency, new_amplitude_modulated_signal);
end

function center_frequency = sense_free_spectrum(pxx, frequencies, required_bandwidth, threshold)
    beginning_index = 0;
    last_index = 0;
    current_bandwith = 0;
    for index = 1:length(frequencies)
        if pxx(index) <= threshold
            if beginning_index == 0
                beginning_index = index;
            end
            if last_index == 0
                last_index = index;
            else
                last_index = last_index + 1;
            end
            current_bandwitdh = current_bandwith + frequencies(last_index) - frequencies(beginning_index);
            if current_bandwitdh > required_bandwidth
                center_frequency = (frequencies(beginning_index) + frequencies(last_index)) / 2;
                return;
            end
        else
            beginning_index = 0;
            last_index = 0;
            current_bandwith = 0;
        end
    end

    center_frequency = 0;
end
