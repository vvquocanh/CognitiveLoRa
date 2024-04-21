function [amplitude_modulated_signal, new_amplitude_modulated_signal, center_frequency, beginning_index, last_index] = secondary_user_enter(amplitude_modulated_signal, lora_signal, bandwidth, sampling_frequency, threshold)
    [pxx, frequencies] = periodogram(amplitude_modulated_signal, [], [], sampling_frequency);
    [center_frequency, beginning_index, last_index] = sense_free_spectrum(pxx, frequencies, bandwidth, threshold);
    if center_frequency == 0
        new_amplitude_modulated_signal = [];
    else
        new_amplitude_modulated_signal = ammod(real(lora_signal), center_frequency, sampling_frequency);
        amplitude_modulated_signal = amplitude_modulated_signal + new_amplitude_modulated_signal;
    end
end

function [center_frequency, beginning_index, last_index] = sense_free_spectrum(pxx, frequencies, required_bandwidth, threshold)
    beginning_index = 0;
    last_index = 0;
    current_bandwith = 0;
    for index = 1:length(frequencies)
        if 10*log10(pxx(index)) <= threshold
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