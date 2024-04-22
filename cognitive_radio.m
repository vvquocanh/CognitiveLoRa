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
power_threshold = -60;

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
            disp("'draw_power_diagram': draw the power spectral density diagram.");
            disp("'exit': exit the program.");
        case "create_primary"
            [amplitude_modulated_signal, user_information, secondary_users, secondary_users_sensing_data] = create_primary_user(amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, power_threshold);
           
            if ~isempty(user_information.amplitude_modulated_signal)
                primary_users = [primary_users; user_information];
                figure_title = interpolate_string("Create primary user {user_information.id}");
                draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
            end
        case "remove_primary"
            index = get_index_by_input(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                if primary_users(index).is_present == true
                    amplitude_modulated_signal = amplitude_modulated_signal - primary_users(index).amplitude_modulated_signal;
                end
                figure_title = interpolate_string("Remove primary user {primary_users(index).id}");
                draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
                primary_users(index) = [];
            end
        case "primary_enter"
            index = get_index_by_input(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                if primary_users(index).is_present == false
                    [amplitude_modulated_signal, secondary_users, secondary_users_sensing_data] = primary_user_enter(amplitude_modulated_signal, primary_users(index).amplitude_modulated_signal, signal_length, sampling_frequency, secondary_users, secondary_users_sensing_data, power_threshold);
                    primary_users(index).is_present = true;
                    figure_title = interpolate_string("Primary user {primary_users(index).id} enter");
                    draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
                else
                    disp("Primary user is already present.");
                end
            end
        case "primary_leave"
            index = get_index_by_input(primary_users);

            if index == -1
                disp("There is no primary user with such id.");
            else
                if primary_users(index).is_present == true
                    amplitude_modulated_signal = amplitude_modulated_signal - primary_users(index).amplitude_modulated_signal;
                    primary_users(index).is_present = false;
                    figure_title = interpolate_string("Primary user {primary_users(index).id} leave");
                    draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
                else
                    disp("Primary user is already not present.");
                end
            end
        case "get_primary"
            for i = 1 : length(primary_users)
                disp(primary_users(i));
            end
        case "create_secondary"
            [amplitude_modulated_signal, user_information, sensing_data] = create_secondary_user(amplitude_modulated_signal, signal_length, sampling_frequency, power_threshold);
            if ~isempty(user_information.amplitude_modulated_signal)
                secondary_users = [secondary_users; user_information];
                secondary_users_sensing_data = [secondary_users_sensing_data; sensing_data];
                figure_title = interpolate_string("Create secondary user {user_information.id}");
                draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
            end
        case "remove_secondary"
            user_index = get_index_by_input(secondary_users);
            if user_index == -1
                disp("There is no secondary user with such id.");
            else
                sensing_data_index = get_proper_index(secondary_users(index).id, secondary_users_sensing_data);
                if secondary_users(user_index).is_present == true
                    amplitude_modulated_signal = amplitude_modulated_signal - secondary_users(user_index).amplitude_modulated_signal;
                end
                figure_title = interpolate_string("Remove primary user {primary_users(user_index).id}");
                draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
                secondary_users(user_index) = [];
                secondary_users_sensing_data(sensing_data_index) = [];
            end
        case "secondary_enter"
            user_index = get_index_by_input(secondary_users);
            if user_index == -1
                disp("There is no secondary user with such id.");
            else
                sensing_data_index = get_proper_index(secondary_users(user_index).id, secondary_users_sensing_data);
                if secondary_users(user_index).is_present == false
                    [amplitude_modulated_signal, new_amplitude_modulated_signal, center_frequency, beginning_index, last_index] = secondary_user_enter(amplitude_modulated_signal, signal_length, secondary_users_sensing_data(sensing_data_index).lora_signal, secondary_users(user_index).bandwidth, sampling_frequency, power_threshold); 
                    secondary_users_sensing_data(sensing_data_index).center_frequency = center_frequency;
                    secondary_users_sensing_data(sensing_data_index).beginning_index = beginning_index;
                    secondary_users_sensing_data(sensing_data_index).last_index = last_index;
                    sensing_data_index(user_index).amplitude_modulated_signal = new_amplitude_modulated_signal;
                    sensing_data_index(user_index).is_present = true;
                    figure_title = interpolate_string("Secondary user {secondary_users(user_index).id} enter.");
                    draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
                else
                    disp("Secondary user is already present.");
                end
            end
        case "secondary_leave"
            user_index = get_index_by_input(secondary_users);
            if user_index == -1
                disp("There is no secondary user with such id.");
            else
                if secondary_users(user_index).is_present == true
                    amplitude_modulated_signal = amplitude_modulated_signal - secondary_users(user_index).amplitude_modulated_signal;
                    secondary_users(user_index).is_present = false;
                    figure_title = interpolate_string("Secondary user {secondary_users(user_index).id} leave.");
                    draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
                else
                    disp("Secondary user is already not present.");
                end
            end
        case "get_secondary"
            for i = 1 : length(secondary_users)
                disp(secondary_users(i));
            end
        case "draw_power_diagram"   
            figure_title = interpolate_string("Power spectral density");
            draw_power_density_diagram(amplitude_modulated_signal, sampling_frequency, figure_title);
        otherwise
            disp("Command not found.");
    end
end

% FUNCTION
function range = standard_signal_length(sampling_frequency)
    lora_signal = LoRa_Tx("", 25e3, 7, 14, sampling_frequency, 0);
    range = length(lora_signal);
end

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