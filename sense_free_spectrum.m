function [center_frequency, beginning_index, last_index] = sense_free_spectrum(environment_signal, required_bandwidth, sampling_frequency, threshold)
    [pxx, frequencies] = periodogram(environment_signal, [], [], sampling_frequency);    
    
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