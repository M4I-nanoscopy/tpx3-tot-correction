%% Variables file!
%tester

%% load file
%Filename (witout numbering, needs underscore after file name before numbering)
MainFILE = 'TOA-TOT-norm_145_50THL_20s_hits' % ('TOA-TOT-norm_145_50THL_20s_hits')
%Directory
UserDIR = '/Users/ericva/Desktop/TikTok/FF50_out/'
FileTYPE = '.h5' % (.h5)
NumberingFormat = '000000' % ('000000')

%% Preperation
%smoothing spline
strength = 13 %smoothing of curves over number of pixels (Not being used anymore)
%very important removes ToT' of all datasets from being processed for
%correction (13)
fromToT = 6 %start ToT %used to clear very small toT values (6)
toToT = 1024 % end ToT % could be used to set a final correction point (1024)

%% bad pixels

BadP = 2 %(number of bad pixels) (10)
BadP_T = [118983 121208] % add bad pixels

%% For Average curve
stepAvg = 10 % Curve fitting bandstep (10)
%Llp = 40 % Lower limit percentage (40)
%Ulp = 90 % upper limit percentage (90)

%% Save Location and file name

resultfile = '/Users/ericva/Desktop/Pinky/tot_correct_300kV_050.h5' % full save location

