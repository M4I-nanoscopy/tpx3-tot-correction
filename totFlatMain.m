%% Variables This loads the variable file, please fill in any pointers there

'load variables'
Variables % load Variables file
SS = {' '}; % Spacer
%%

ToT_FF_size = (Chipnr * Dim_x * Dim_y); % creates the table size
ToT_FF_T_BIG = zeros(1024,5,ToT_FF_size);
ToT_FF_T_BIG2 = zeros(1024,5,ToT_FF_size);

% %% Load multiple files
% jString = 0;
% iString = 33;
% 
%    while jString < iString
%
%        tic
%         jString = jString +1;
%         if jString == 2;
%             yes = 'yes'
%         else
%         jString2 = strcat(NumberingFormat,num2str(jString));
%         jString2 = jString2(end-4:end);
%         filename = char(strcat(UserDIR, MainFILE, '_', jString2, FileTYPE))
%         Hits = h5read(filename, '/hits');
%         loady = toc
%         tic
%         totFlatfield2 %Runs the totFlatfield2 script
%         ff = toc
%         end
%    end
%    ToT_FF_T_BIG2 = ToT_FF_T_BIG;
%    jString = 0;

%% Load multiple files ToT hit files

jString = 0;
iString = NumberofFiles;
count = 0;


while jString < iString
    
    tic
    jString = jString +1;
    if jString == 2;
        yes = 'yes'
    else
        jString2 = strcat(NumberingFormat,num2str(jString));
        jString2 = jString2(end-1:end);
        filename = char(strcat(UserDIR, MainFILE, '_', jString2, FileTYPE))
        data = h5read(filename, '/freq_tot');
        count = count + jString;
        if count == 1
            data2 = data;
        else
            data2 = data2 + data;
        end
        loady = toc
    end
end
%% creates data_bases and basic info
ToT_FF_T_BIG2(:,1,:) = data2(:,:);
ToT_FF_T_BIG2(1,2,:) = sum(ToT_FF_T_BIG2(:,1,:));
ToT_FF_T_BIG2(20,2,:) = ToT_FF_T_BIG2(1,2,:);

jString = 0;
%% Calls the NormaliseCurve scripts to caclualte the ToT correctionmap

normaliseCurve

%% write out result
WriteIO 

%%
clear ans BadP VasP_T Chipnr count Dim_X Dim_y fromToT new NumberingFormat NumberofFiles resultfile stepAvg strength ToT_FF_size toToT UsePoly Dim_x BadP_T ToT_T_BIG UserDIR FileTUPE iString data data2 Hits jString jString2 filename SS MainFILE loady ff FileTYPE ToA_T ToT_T x_T y_T ChipID_T
clearvars data data2 iString jString jString2 loady