function environment_signal = sum_signal(environment_signal, lora_signal, is_minus)
    if nargin < 3
        is_minus = false;
    end

    desired_length = max(length(environment_signal), length(lora_signal));

    environment_signal = [environment_signal; zeros(desired_length - length(environment_signal), 1)];
    lora_signal = [lora_signal; zeros(desired_length - length(lora_signal), 1)];
    
    if is_minus
        environment_signal = environment_signal - lora_signal;
    else
        environment_signal = environment_signal + lora_signal;
    end
end
