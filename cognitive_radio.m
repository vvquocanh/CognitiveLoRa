clear;
clc;
close all;

disp("LoRa - Cognitive Radio simulation.");

%FREQUENCY SPECTRUM
frequency_spectrum_range = input("\nEnter the frequency spectrum range (kHz): ");
sampling_frequency = frequency_spectrum_range * 2 * 1000;
signal_length = standard_signal_length(sampling_frequency);

%USERS
primary_users = [];
secondary_users = [];

%AMPLITUDE MODULATED SIGNAL
amplitude_modulated_signal = zeros(1, signal_length);
pxx = [];

%COMMAND HANDLER
while true
    command = input("\nEnter command: ", "s");
    switch command
        case "exit"
            break;
        case "help"
            disp("'create_primary': create a primary user.");
            disp("'get_primary': print the information of all of the primary users.");
            disp("'remove_primary': remove a primary user.");
            disp("'primary_leave': the primary user is not present.");
            disp("'primary_enter': the primary user is present.");
            disp("'exit': exit the program.");
        case "create_primary"
            user_information = create_primary_user(signal_length, sampling_frequency);
            if isempty(user_information.amplitude_modulated_signal)
                disp("Fail to create primary user.");
            else
                primary_users = [primary_users; user_information];
                pxx = get_pxx(amplitude_modulated_signal, user_information.amplitude_modulated_signal, sampling_frequency, false);
                amplitude_modulated_signal = amplitude_modulated_signal + user_information.amplitude_modulated_signal;
            end
        case "get_primary"
            for i = 1 : length(primary_users)
                disp(primary_users(i));
            end
        case "remove_primary"
            index = get_proper_index(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                pxx = get_pxx(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, sampling_frequency, true);
                amplitude_modulated_signal = amplitude_modulated_signal - primary_users(index).amplitude_modulated_signal;
                primary_users(index) = [];
            end
        case "primary_leave"
            index = get_proper_index(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                pxx = get_pxx(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, sampling_frequency, true);
                amplitude_modulated_signal = amplitude_modulated_signal - primary_users(index).amplitude_modulated_signal;
                primary_users(index).is_present = false;
            end
        case "primary_enter"
            index = get_proper_index(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                pxx = get_pxx(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, sampling_frequency, false);
                amplitude_modulated_signal = amplitude_modulated_signal + primary_users(index).amplitude_modulated_signal;
                primary_users(index).is_present = true;
            end
        case "create secondary"
            
        otherwise
            disp("Command not found.");
    end
end

% FUNCTION
function index = get_proper_index(users)
    id = input("Enter user id: ", "s");
    
    index = -1;
    for i = 1 : length(users)
        if users(i).id == id
            index = i;
        end
    end
end