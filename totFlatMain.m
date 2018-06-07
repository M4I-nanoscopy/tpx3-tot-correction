%% Variables

'load variables'
Variables % load Variables file
SS = {' '};
%%

ToT_FF_size = (4 * 256 * 256);
ToT_FF_T_BIG = zeros(1024,5,ToT_FF_size);
ToT_FF_T_BIG2 = zeros(1024,5,ToT_FF_size);

%% Load multiple files
jString = 0;
iString = 30;

   while jString < iString

       tic
        jString = jString +1;
        if jString == 2;
            yes = 'yes'
        else
        jString2 = strcat('000000',num2str(jString));
        jString2 = jString2(end-5:end);
        filename = char(strcat(UserDIR, MainFILE, '_', jString2, FileTYPE))    
        Hits = h5read(filename, '/hits');
        loady = toc
        tic
        totFlatfield2 %Runs the totFlatfield2 script
        ff = toc
        end
   end
   
   jString = 0;
   
%% Calls the NormaliseCurve scripts to caclualte the ToT correctionmap

normaliseCurve

WriteIO


%%
clear UserDIR FileTUPE iString jString jString2 filename SS MainFILE loady ff FileTYPE ToA_T ToT_T x_T y_T ChipID_T
 