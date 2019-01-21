%% Variables file!
%tester
new = 1 % means it runs the newest fitting version; Suggested KEEP 1)

%% load file
%Filename (witout numbering, needs underscore after file name before numbering)
MainFILE = 'ikkrum20_freq_tot' % ('TOA-TOT-norm_145_50THL_20s_hits')
%Directory
UserDIR = '/Users/ericva/Downloads/'
FileTYPE = '.h5' % (.h5)
NumberingFormat = '00000' % ('000000')
NumberofFiles = 1


%% Preperation'
%smoothing spline
strength = 5 %smoothing of curves over number of pixels for the Average curve.
%very important removes ToT' of all datasets from being processed for
%correction (13)
fromToT = 3 %start ToT %used to clear very small toT values (6)
toToT = 1024 % end ToT % could be used to set a final correction point (1024)

outlierRemovalStrength = 0.05

minimumCounts = 30000 %minimum counts for a pixel to be considered for a correction 

%% bad pixels

BadP = 0 %2%(number of bad pixels) (10)
BadP_T = []%[118983 121208] % add bad pixels

%% For Average curve
stepAvg = 3 % Curve fitting bandstep (3) can fail at other settings
UsePoly = 3 % polynomal curve factor (poly 2 or 3 supported) poly 2 is considered to be inferior


%% Chip information
Dim_x = 256
Dim_y = 256
Chipnr = 4


%% Save Location and file name

resultfile = '/Users/ericva/Desktop/Maastricht/300um_Maastricht_Ikrum20.h5' % full save location

