function [environment_signal, secondary_users] = primary_user_enter(environment_signal, lora_signal, sampling_frequency, secondary_users, threshold)
    environment_signal = sum_signal(environment_signal, lora_signal);
    
    [environment_signal, secondary_users] = secondary_user_move(environment_signal, sampling_frequency, secondary_users, threshold);
end


