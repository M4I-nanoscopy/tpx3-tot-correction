%% Variables file!


%% load file
%Filename (witout numbering, needs underscore after file name before numbering)
MainFILE = 'TOA-TOT-norm_145_50THL_20s_hits';
%Directory
UserDIR = '/Users/ericva/Desktop/TikTok/FF50_out/';
FileTYPE = '.h5';
NumberingFormat = '000000';

%% Preperation
%smoothing spline
strength = 13; %smoothing of curves over number of pixels (Not being used anymore)
%very important removes ToT' of all datasets from being processed for
%correction
fromToT = 2; %start ToT %used to clear very small toT values
toToT = 1024; % end ToT % could be used to set a final correction point

%% bad pixels

BadP = 2; %(number of bad pixels)
BadP_T = [118983 121208]; % add bad pixels

%% For Average curve
Llp = 40; % Lower limit percentage 
Ulp = 90; % upper limit percentage

