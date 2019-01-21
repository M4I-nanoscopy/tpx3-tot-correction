
AverageTest2 = zeros(1024,3);
l = 1;
k = 1;
o = 1;

%% Test code
%ToT_FF_size = (4 * 256 * 256);
% creates a M = 1024 by 1 matrix
% while o < 1024+1
%     M(o,1) = o;
%     o = o + 1;
% end
% x = M;


%% Needs to be checked and implemntated
k = 0;
if BadP > 0
 while k < BadP
     k = k +1
     ToT_FF_T_BIG2(:,3,BadP(k))=0; % removes only the info for the Avg curve
     ToT_FF_T_BIG2(1,2,BadP(k))=0; % sets the number of counts of the pixel to 0
 end
end

meanAllCounts = mean(ToT_FF_T_BIG2(20,2,:));
medianAllCounts = median(ToT_FF_T_BIG2(20,2,:));
stdAllCounts = std(ToT_FF_T_BIG2(20,2,:));

stdAllCountsF = outlierRemovalStrength * stdAllCounts; %  0.15 = 1/3th?

lowerB = meanAllCounts - stdAllCountsF;
upperB = meanAllCounts + stdAllCountsF;
lowerBm = medianAllCounts - stdAllCountsF;
upperBm = medianAllCounts + stdAllCountsF;
% make sure only those with certain amount of counts (MAYBE make it at
% least 50% of average???
idx = ToT_FF_T_BIG2(20,2,:)<lowerBm | ToT_FF_T_BIG2(20,2,:) > upperBm;
%    idx = ToT_FF_T_BIG2(20,2,:)<10000;
counter = ToT_FF_size - sum(idx(:));

if counter < ToT_FF_size/2
    %dispPerc = uint16((counter/ToT_FF_size)*100)
    text = strcat('The ammount of pixels used to calculate the average is les then 50% reconsider the outlier strength, Press a key !')
    disp(text)
    pause
end

%%
k = 1;
l = 1;
TEST = 0;
while k < 1024
    while l < ToT_FF_size + 1
        if idx(1,1,l) == 0
            TEST = TEST + ToT_FF_T_BIG2(k,3,l);
        end
        l = l + 1;
    end
    AverageTest2(k,1) = TEST;
    TEST = 0;
    l = 1;
    k = k +1;
end
%% Test case to smooth the AverageCurve to fix the jumping
AverageTest2(:,2) = movmean(AverageTest2(:,1)./ (counter), strength);



%% old
%AverageTest2(:,5) = AverageTest2(:,1)./ (counter);
%xsize = 1024;
%%
p = 1;
while p < 1024%xsize + 1
    if p == 1
        AverageTest2(p,3) = AverageTest2(p,2);
        
    else
        P = p - 1;
        AverageTest2(p,3) = AverageTest2(p,2)+AverageTest2(P,3);
    end
    
    p = p + 1;
end

%%

AverageTest2(:,3) = AverageTest2(:,3);
maxy = max(AverageTest2(:,3));
AverageTest2(:,3) = AverageTest2(:,3);

AverageTest2(:,4) = AverageTest2(:,3)./max(AverageTest2(:,3));


%% get curves v2.0
O = zeros(1024,1);

% Still need to fix the 0 line

%stepAvg = 10; % step for curve fitting
Avvan = fromToT; %start point
ij = 0; %counter
Avtot = Avvan + stepAvg; %end point for each step
intercept = 0;
% ZeroFixer = zeros(1024,1);
% M2 = zeros(1024,1);
% M2(2:1024,1) = M(1:1023,1)
% ZeroFixer(2:1024,1) = AverageTest2(1:1023,4)


while intercept <  0.99999
    ij = ij + 1;
    O(Avvan:Avtot,1) = 1;
    Try = createFit_poly3(M,AverageTest2(:,4), O); %calls funtion createFit,
    % which tries to fit a polynome to the 3th order to the Average
    % Curve for each step
    %AverageCurve(ij,1:4) = [Avvan,Avtot,ZeroFixer(Avvan,1),ZeroFixer(Avtot,1)];
    AverageCurve(ij,1:4) = [Avvan,Avtot,AverageTest2(Avvan,4),AverageTest2(Avtot,4)];
    coeffy = coeffvalues(Try); % places the polynomal corves in coeffy
    AverageCurve(ij,5:8) = coeffy; % places the coeffy information in the AverageCurve Table
    %intercept = coeffy(1,4) %creates the exit for the while loop. When the fitting curve nears 1
    intercept = (AverageCurve(ij,3));
    O(Avvan:Avtot,1) = 0;
    Avvan = Avtot; % cretes a new step start
    Avtot = Avvan + stepAvg; % creates a new step stop
end
Averagecurve_succesfull = 'done'
%%
clearvars xsize x A k l p P strength TEST x  p1 p2 p3 maxy coeffy ij lowerB lowerBm upperB upperBm meanAllCounts stdAllCounts stdAllCountsF medianAllCounts
clearvars ans Averagecure_Succesfull AverageTest_Finished Avtit Avvan count counter dispPerc idx intercept o O outing stepAvg text totalPixelcount 