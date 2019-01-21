%% normaliseCurve
'load variables'
Variables % load Variables file

%% set tables
ToT_FF_T_BIG2(:,3,:) = 0; %can be removed in final setting
ToT_FF_T_BIG2(:,4,:) = 0; % can be removed in final setting
ToT_FF_size = (4 * 256 * 256); % should be calculated at a sooner point

%% creates a M = 1024 by 1 matrix

o = 1;
while o < toToT+1
    M(o,1) = o;
    o = o + 1;
end
x = M;

clear o 

%% Calculates the normalised function

% goes to x:3:x
% moving mean goes to x:4:x
% summed x:3:x goes to x:5:x

o = 1;

while o < ToT_FF_size
    
    A = ToT_FF_T_BIG2(:,1,o); % makes a single string
    if fromToT == 1
        calc = 0;
    else
        calc = sum(A(1:fromToT)); % calculates the ammount of count from ToT 1 till set start ToT
        A(1:fromToT,1) = 0; % Sets the first ToT values to 0 to a certain value
    end
    totalPixelCount = ToT_FF_T_BIG2(1,2,o) - calc;% - sum(ToT_FF_T_BIG2(1:fromToT,1,o)); %- sum(ToT_FF_T_BIG2(1:fromToT,1,o));
    ToT_FF_T_BIG2(20,2,o) = totalPixelCount; % Puts the cutoff event count in the table
    A = A(:,1)./totalPixelCount; % normalises the events
    ToT_FF_T_BIG2(:,3,o) = A; % puts normalised events at position 3
    xsize = 1024;
    p = 1;
    
    % This loop calculates the cummulative normalised occurance
    while p < xsize + 1
        if p == 1
            ToT_FF_T_BIG2(p,5,o) = ToT_FF_T_BIG2(p,3,o);
        else
            P = p - 1;
            ToT_FF_T_BIG2(p,5,o) = ToT_FF_T_BIG2(p,3,o)+ToT_FF_T_BIG2(P,5,o);
        end
        p = p + 1;
    end
    o = o + 1;
end

clear o p xsize A totalPixelcount calc P

%% call Averagetest
% Calculates the Average ToT response as well as the the curve fits for the
% summation of this line % Creates Table for Curve fit information as well
% as a table with the Averages, cumulative averages
tic
if UsePoly == 2
    AverageTest2_imp % Uses the Polynome to second power fitting (could be buggy)
elseif UsePoly == 3
    AverageTest_poly3 % Uses the Polynome to third power fitting (latest method) 
else
    error('no curefitting "poly" was set')
end

AverageTest_Finished = toc

clearvars AverageTest_Finished
%% Per pixel difference map
% uses histogram fitting

ToT_FF_T_BIG3 = zeros(1024,3,ToT_FF_size); % Creates extra and final table
ToT_FF_T_BIG3(:,1,:) = ToT_FF_T_BIG2(:,3,:); %copies the normalised event occurance in position 1
ToT_FF_T_BIG3(:,2,:) = ToT_FF_T_BIG2(:,2,:); % copies the extra information like total occurance counts in

F = zeros(1024,4);
o = 1;


if new == 1
    memoryToT = 0; % remembers the last Correction ToT
    AverageTable = zeros(3,11000); % Needed for precision
    for i = 1 : length(AverageTable) 
        AverageTable(1,i+1) = i/10000; % fills averageTable
        
        if AverageTable(1,i) < AverageCurve(1,3)
            AverageTable(2,i) = 1; % picks the first curve if it is the first
        else
            AverageTable(2,i) = find(AverageCurve(:,3) <= AverageTable(1,i), 1, 'last' ) ; %Finds the next curve
        end
        Curve = AverageTable(2,i); % picks the required curve
        
        a = AverageCurve(Curve,5); 
        b = AverageCurve(Curve,6);
        c = AverageCurve(Curve,7);
        d = AverageCurve(Curve,8);
        
        %loads the required y
        if AverageTable(1,i) < AverageCurve(1,3)
            y = AverageCurve(1,3); 
        else
            y = AverageTable(1,i)
        end
        
        % calculate the roots / removes imaginary results / sort the order
        NT = roots([a b c d-y]);
        KT = NT(imag(NT)==0);
        KT = sort(KT);
        
        ji = 0;
        if length(KT) == 1
            expectedToT = KT(1); % easy answer if there is only 1
        else
            while ji < length(KT) 
                ji = ji + 1; 
                Dinky = KT(ji);
                if Dinky >= memoryToT % picks the first ToT solution after the last; ToT cannot go negative
                    expectedToT = KT(ji); % hard answer
                    break
                else
                    i; % should not be used but is backup for strange acting pixels 
                end
            end
        end
        
        AverageTable(3,i)  = (expectedToT); 
        memoryToT = expectedToT; 
        
    end
    
    Tryout4 % runs Tryout 4 (newest version)
    
    
    %clear AverageTable
else %outdated
    
    while o < ToT_FF_size + 1
        if ToT_FF_T_BIG2(1,2,o) > 30000
            D = ToT_FF_T_BIG2(:,5,o);
            Tryout3

        else
            o;
        end
        o = o + 1;
    end
    
end
%close(h)
toc
%%
clearvars a b c d Curve Averagecurve_succesfull Avtot Dinky esttime expectedToT F h i ik ikke is ji KATY KT loady M memoryToT N NTNUMERO o s st starters steps titleHandle totalPixelCount Try y
clearvars NUMERO NT minimumCounts AverageTable AverageTest_Finished outlierRemovalStrength
%% Fix Matrix

k= 1;
kstart = 0;
kend = 0;
d = 0

ToT_final_M = zeros(4,256,256,1024);
while k < 5
    
    kstart = kend
    kend = k*256*256
    DINKY = permute(reshape(ToT_FF_T_BIG3(:,3,kstart+1:kend),1024,256,256),[2,3,1]);
    ToT_final_M(k,:,:,:) =  DINKY(:,:,:);
    k = k +1;
    d = 1;
end

ToT_final_M = round(ToT_final_M);

%%
clear totalPixelCount o n B ans ToTpin ix corr_fact_ToT fromToT toToT expectedToT ans Avtot Avvan calc counter Curve d D F Gx intercept kend kstart  starters step steps tester
clearvars AverageTest_Finished k 

