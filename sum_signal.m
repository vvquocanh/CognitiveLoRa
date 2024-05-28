function environment_signal = sum_signal(environment_signal, lora_signal, is_minus = false)
    desired_length = max(length(environment_signal), length(lora_signal));

    environment_signal = padding_zero(environment_signal, desired_length);
    lora_signal = padding_zero(lora_signal, desired_length);
    
    if is_minus
        environment_signal = environment_signal - lora_signal;
    else
        environment_signal = environment_signal + lora_signal;
    end
end

function new_signal = padding_zero(signal, desired_length)
    if length(signal) < desired_length
        new_signal = zeros(1, desired_length);
        for index = 1 : length(signal)
            new_signal(index) = signal(index);
        end
        return
    end
    new_signal = signal;
end
