function is_available = check_current_spectrum(environment_signal, center_frequency, bandwidth, sampling_frequency, threshold)
    [pxx, frequencies] = periodogram(environment_signal, [], [], sampling_frequency);
    is_available = true;
    
    frequency_index = find_frequency_index(frequencies, center_frequency);
    
    left_pointer = frequency_index;
    right_pointer = frequency_index;

    while (frequencies(right_pointer) - frequencies(left_pointer)) < bandwidth
        if 10*log10(pxx(index)) > threshold
            is_available = false;
            return
        end
        if mod(right_pointer - left_pointer, 2) == 0
            left_pointer = left_pointer - 1;
        else
            right_pointer = right_pointer + 1;
        end
    end
end

function frequency_index = find_frequency_index(frequencies, center_frequency)
    frequency_index = 0;
    for index = 1 : length(frequencies)
        if frequencies(index) == center_frequency
            frequency_index = index;
            return
        elseif frequencies(index) > center_frequency
            if (frequencies(index) - center_frequency) < (center_frequency - frequencies(index - 1))
                frequency_index = index;
            else
                frequency_index = index - 1;
            end
        end
    end
end

