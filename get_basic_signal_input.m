function [id, bandwidth, power] = get_basic_signal_input()
    id = input("Enter user id: ", "s");
    
    bandwidth = input("Enter signal bandwidth (kHZ, minumum 25kHZ): ");
    bandwidth = bandwidth * 1000;
    if bandwidth < 25e3
        bandwidth = 25e3;
    end
    
    power = input("Enter power (dBm): ");
    if power > 20
        power = 20;
    end
end

