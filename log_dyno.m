function [ output_args ] = log_dyno(comPort, tscollection)
%LOG_DYNO Summary of this function goes here
%   Detailed explanation goes here
    s = serial(comPort);
    set(s, 'BaudRate', 115200);
    fopen(s);
    time = zeros(1000);
    data = zeros(1000);
    i = 1;
    while 1
        fprintf(s, '
        time(i) = datenum(datestr(now,'HH:MM:SS.FFF'));
        data(i) = i;
        i = i + 1;
        state = exist('stop', 'file');
        if(state == 2)
            delete('stop');
            break
        end
    end
    
    dynoTimeseries = timeseries(time, data)
    %Add to tscollection
    
    fclose(s);
    delete(s)
    clear s

end

