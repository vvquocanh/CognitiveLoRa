clear;
clc;
close all;

disp("LoRa - Cognitive Radio simulation.");

% FREQUENCY SPECTRUM
frequency_spectrum_range = input("\nEnter the frequency spectrum range (kHz): ");
sampling_frequency = frequency_spectrum_range * 2 * 1000;
signal_length = standard_signal_length(sampling_frequency);

% USERS
primary_users = [];
secondary_users = [];
secondary_users_sensing_data = [];

% AMPLITUDE MODULATED SIGNAL
amplitude_modulated_signal = zeros(1, signal_length);

% COGNITIVE RADIO
power_threshold = -70;

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
            disp("'create_secondary': create a secondary user.");
            disp("'exit': exit the program.");
        case "create_primary"
            user_information = create_primary_user(signal_length, sampling_frequency);
            if isempty(user_information.amplitude_modulated_signal)
                disp("Fail to create primary user.");
            else
                primary_users = [primary_users; user_information];
                amplitude_modulated_signal = process_signal(amplitude_modulated_signal, user_information.amplitude_modulated_signal, sampling_frequency, false);
            end
        case "get_primary"
            for i = 1 : length(primary_users)
                disp(primary_users(i));
            end
        case "remove_primary"
            index = get_index_by_input(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                amplitude_modulated_signal = process_signal(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, sampling_frequency, true);
                primary_users(index) = [];
            end
        case "primary_leave"
            index = get_index_by_input(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                amplitude_modulated_signal = process_signal(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, sampling_frequency, true);
                primary_users(index).is_present = false;
            end
        case "primary_enter"
            index = get_index_by_input(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                amplitude_modulated_signal = process_signal(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, sampling_frequency, false);
                primary_users(index).is_present = true;
            end
        case "create_secondary"
            [user_information, sensing_data] = create_secondary_user(amplitude_modulated_signal, signal_length, sampling_frequency, power_threshold);
            if isempty(user_information.amplitude_modulated_signal)
                disp("Fail to create primary user.");
            else
                secondary_users = [secondary_users; user_information];
                secondary_users_sensing_data = [secondary_users_sensing_data; sensing_data];
                amplitude_modulated_signal = process_signal(amplitude_modulated_signal, user_information.amplitude_modulated_signal, sampling_frequency, false);
            end
        otherwise
            disp("Command not found.");
    end
end

% FUNCTION
function index = get_index_by_input(users)
    id = input("Enter user id: ", "s");

    index = get_proper_index(id, users);
end

function index = get_proper_index(id, users)
    index = -1;
    for i = 1 : length(users)
        if users(i).id == id
            index = i;
        end
    end
end