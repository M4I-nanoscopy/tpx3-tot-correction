F = zeros(1024,4);
starters = uint32(1);
Gx = M;
l = 1;
syms x


%% to find the nearest point on teh averagecurve
i = 0;

while i < 1024
    i = i + 1;
    if D(i,1) < AverageCurve(1,3)
        D(i,2) = 1;
    else
        D(i,2) = find(AverageCurve(:,3) <= D(i,1), 1, 'last' ) ;
        
    end
end

%% calculates the expectedToT for every ToT
% expectedToT = xavg = (sqrt(4*a*(ypixel - c) + b^2) + b) / (2 * a)

i = fromToT;
if UsePoly == 2
    while i < 1024
        i = i + 1;
        Curve = D(i,2);
        p1 = AverageCurve(Curve,5);
        p2 = AverageCurve(Curve,6);
        p3 = AverageCurve(Curve,7);
        expectedToT = (sqrt(4*p1*(D(i,1)-p3) + p2^2) - p2) / (2 * p1);
        F(i,1)  = expectedToT;
    end
    
elseif UsePoly == 3
    memoryToT = 0;
    while i < 1024
        %         i = i + 1;
        %         Curve = D(i,2);
        %         a = AverageCurve(Curve,5);
        %         b = AverageCurve(Curve,6);
        %         c = AverageCurve(Curve,7);
        %         d = AverageCurve(Curve,8); % v2
        %         y = D(i,1);
        %
        %         expectedToT = (sqrt((-27*d*a^2 + 27*y*a^2 + 9*a*b*c - 2*b^3)^2 + 4*(3*a*c - b^2)^3) - 27*d*a^2 + 27*a^2*y + 9*a*b*c - 2*b^3)^(1/3)/(3*a*2^(1/3)) - (2^(1/3)*(3*a*c - b^2))/(3*a*(sqrt((-27*d*a^2 + 27*y*a^2 + 9*a*b*c - 2*b^3)^2 + 4*(3*a*c - b^2)^3) - 27*d*a^2 + 27*y* a^2 + 9*a*b*c - 2*b^3)^(1/3)) - b/(3*a);
        %         F(i,1)  = expectedToT;
        i = i + 1;
        Curve = D(i,2);
        
        %myfun = @(x,a,b,c,d,findy) a*x^3 + b*x^2 + c*x + d-findy;
        
        a = AverageCurve(Curve,5);
        b = AverageCurve(Curve,6);
        c = AverageCurve(Curve,7);
        d = AverageCurve(Curve,8); % v2
        y = D(i,1);
%         tic
%         KT = double(vpasolve(a*x^3 + b*x^2 + c*x + d-y, [memoryToT memoryToT+20]));
%         toc

%%%%
       %fun = @(x) myfun(x,a,b,c,d,findy);
       %x0 = memoryToT
       %KT = fzero(fun,x0)
       
       NT = roots([a b c d-y]);
       KT = NT(imag(NT)==0);
       KT = sort(KT);
       
        
        
        %%%%
        ji = 0;
        if length(KT) == 1
            expectedToT = KT(1);
        else
            while ji < length(KT)
                ji = ji + 1;
                Dinky = KT(ji);
                if Dinky >= memoryToT
                    expectedToT = KT(ji);
                    break
                else
                    i;

                end
            end
        end
        
        F(i,1)  = expectedToT;
        memoryToT = expectedToT;
    end
else
    error('there was no polynome use set')
end

%% calculate differencemap


F(starters:end,2) = F(starters:end,1)-M(starters:end,1); % Calculate the difference
F(starters:end,3) = round(F(starters:end,2)); % Make integers
ToT_FF_T_BIG3(starters:end,3,o) = F(starters:end,3); % places the Differencemap in possition 3






