%% TRYOUT 4

F = zeros(1024,4);
starters = uint32(1);


%% creates waitbar

%h = waitbar(0,'Please wait...');
h = waitbar(0, 'Please Wait');
set(findall(h), 'Units', 'Normalized')
set(h, 'Units', 'Pixels', 'Position', [100 100 500 100])
titleHandle = get(findobj(h,'Type','axes'),'Title');
set(titleHandle,'FontSize',18)

KATY = ToT_FF_T_BIG2(1,2,:) > minimumCounts;
steps = sum(KATY);

s = clock;
tic
st = 0;

for ik = 1:ToT_FF_size
    % F(:,1) = ToT_FF_T_BIG2(:,5,ik)
    
    if ToT_FF_T_BIG2(1,2,ik) > minimumCounts
        F = zeros(1024,4);
        
        
        
        for ikke = 1:1024
            N = AverageTable(3,find(AverageTable(1,:) <= ToT_FF_T_BIG2(ikke,5,ik), 1, 'last' ));
            F(ikke,1) = N;
        end
        % waitbar info
        st = st + 1;
        if st == 1
            is = etime(clock,s);
            esttime = is * steps/1;
            
        end
        if st == 100
            is = etime(clock,s);
            esttime = is * steps/100;
            
        end
        if st == 1000
            is = etime(clock,s);
            esttime = is * steps/1000;
            
        end
        
        % this is the core of the corrcetion
        F(starters:end,2) = F(starters:end,1)-M(starters:end,1); % Calculate the difference
        F(starters:end,3) = round(F(starters:end,2)); % Make integers
        ToT_FF_T_BIG3(starters:end,3,ik) = F(starters:end,3); % places the Differencemap in possition 3
        
        % waitbar info
        NUMERO = num2str(ik);
        h = waitbar(ik/steps, h, ['remaining time = ',num2str((esttime-etime(clock,s))/60,'%4.0f'),' min      #', NUMERO, '      ' num2str((ik/ToT_FF_size)*100,'%4.1f'),'%'],'WindowStyle','modal');
        
    end
end

close(h)