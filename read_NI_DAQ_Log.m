function [ speed, torque ] = read_NI_DAQ_Log( dyno_DAQ_logfile )
%read_dyno_DAQ Read dynamometer torque and speed measurements from logfile
%   This script reads CSV logfiles of the type written by NI_DAQ_Log.py.
%
%	It returns two timeseries variables, DynoSpeed and Torque.

%TODO: is this safe by default in MATLAB?
file = fopen( dyno_DAQ_logfile );

%date,speed,torque
format = '%s %f %f';
C = textscan( file, format, 'Delimiter', ',', 'HeaderLines', 1 );

times	= C{1};
speeds	= C{2};
torques = C{3};

% Convert time strings to date numbers, then date numbers to elapsed
% seconds
times	= datenum( times, 'yyyy-mm-dd HH:MM:SS.FFF' );
start	= datestr( times(1) );
times	= times * 3600 * 24;
times	= times - times(1);

speed = timeseries( speeds, times );
speed.TimeInfo.StartDate	= start;
speed.DataInfo.Units		= 'RPM';
speed.Name					= 'Dynamometer speed';

torque = timeseries( torques, times );
torque.TimeInfo.StartDate	= start;
torque.DataInfo.Units		= 'N m';
torque.Name					= 'Dynamometer torque';

end

