function [environment_signal, user_information, secondary_users] = create_primary_user(environment_signal, sampling_frequency, secondary_users, threshold)
    [id, bandwidth, power] = get_basic_signal_input();

    center_frequency = input("Enter signal center frequency (kHZ): ");
    center_frequency = center_frequency * 1000;
    
    lora_signal = create_primary_signal(center_frequency, bandwidth, power, sampling_frequency);

    [environment_signal, secondary_users] = primary_user_enter(environment_signal, lora_signal, sampling_frequency, secondary_users, threshold);
   
    user_information = construct_user_information(id, bandwidth, power, center_frequency, lora_signal);
end

