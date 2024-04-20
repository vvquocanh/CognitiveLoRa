function [id, bandwidth, power] = get_user_input()
    id = input("Enter user id: ", "s");
    
    bandwidth = input("Enter signal bandwidth (kHZ, minumum 25kHZ): ");
    bandwidth = bandwidth * 1000;
    if bandwidth < 25e3
        bandwidth = 25e3;
    end
    
    power = input("Enter power (dBm): ");
end

