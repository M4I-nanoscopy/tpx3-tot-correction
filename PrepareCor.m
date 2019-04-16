%% Prepare Correction Curves
if RunCrossCorrect == 1
    while k < 2
        k = k + 1;
        if k == 1
            AverageCurve_N = AverageCurve;
        end
        if k == 2
            AverageCurve_N = AverageCurve_C;
        end
        memoryToT = 0; % remembers the last Correction ToT
        AverageTable = zeros(3,11000); % Needed for precision
        for i = 1 : length(AverageTable)
            AverageTable(1,i+1) = i/10000; % fills averageTable
            
            if AverageTable(1,i) < AverageCurve_N(1,3)
                AverageTable(2,i) = 1; % picks the first curve if it is the first
            else
                AverageTable(2,i) = find(AverageCurve_N(:,3) <= AverageTable(1,i), 1, 'last' ) ; %Finds the next curve
            end
            Curve = AverageTable(2,i); % picks the required curve
            
            a = AverageCurve_N(Curve,5);
            b = AverageCurve_N(Curve,6);
            c = AverageCurve_N(Curve,7);
            d = AverageCurve_N(Curve,8);
            
            %loads the required y
            if AverageTable(1,i) < AverageCurve_N(1,3)
                y = AverageCurve_N(1,3);
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
        
        if k == 1
            AverageTable_NC = AverageTable;
        end
        if k == 2
            AverageTable_C = AverageTable;
        end
        
    end
else
    while k < 1
        k = k + 1;
        if k == 1
            AverageCurve_N = AverageCurve;
        end
        if k == 2
            AverageCurve_N = AverageCurve_C;
        end
        memoryToT = 0; % remembers the last Correction ToT
        AverageTable = zeros(3,11000); % Needed for precision
        for i = 1 : length(AverageTable)
            AverageTable(1,i+1) = i/10000; % fills averageTable
            
            if AverageTable(1,i) < AverageCurve_N(1,3)
                AverageTable(2,i) = 1; % picks the first curve if it is the first
            else
                AverageTable(2,i) = find(AverageCurve_N(:,3) <= AverageTable(1,i), 1, 'last' ) ; %Finds the next curve
            end
            Curve = AverageTable(2,i); % picks the required curve
            
            a = AverageCurve_N(Curve,5);
            b = AverageCurve_N(Curve,6);
            c = AverageCurve_N(Curve,7);
            d = AverageCurve_N(Curve,8);
            
            %loads the required y
            if AverageTable(1,i) < AverageCurve_N(1,3)
                y = AverageCurve_N(1,3);
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
        
        if k == 1
            AverageTable;
        end
        if k == 2
            AverageTable_C = AverageTable;
        end
        
    end
end