F = zeros(1024,4);
starters = uint32(1);
Gx = M;
l = 1; 

%% to find the nearest point on teh averagecurve
i = 0;

while i < 1024
    i = i + 1;
    D(i,2) = find(AverageCurve(:,3) <= D(i,1), 1, 'last' ) ; 
    Curve = D(i,2);
end

%% calculates the expectedToT for every ToT
% expectedToT = xavg = (sqrt(4*a*(ypixel - c) + b^2) + b) / (2 * a)

i = 0;

while i < 1024
    i = i + 1;
    Curve = D(i,2);
    p1 = AverageCurve(Curve,5);
    p2 = AverageCurve(Curve,6);
    p3 = AverageCurve(Curve,7);
    expectedToT = (sqrt(4*p1*(D(i,1)-p3) + p2^2) - p2) / (2 * p1);
    F(i,1)  = expectedToT;
end

%% calculate differencemap


% fdx = F(starters:end,1)-M(starters:end,1) < -1 * M(starters:end,1) + 1;
% 
% if sum(fdx) > 0
%     l = starters;
%     
%     while l < 1024
%         if F(l,1)-M(l,1) < -1 * M(l,1) + 1
%             trick = 0;
%             trick = F(l,1)-M(l,1);
%             trick = trick + 1;
%             F(l,4) = trick;
%         else
%             F(l,4) = F(l,3)-M(l,1);
%         end
%       l = l + 1;
%     end
%     counter = counter + 1
% else
F(starters:end,2) = F(starters:end,1)-M(starters:end,1); % Calculate the difference
F(starters:end,3) = round(F(starters:end,2)); % Make integers
ToT_FF_T_BIG3(starters:end,3,o) = F(starters:end,3); % places the Differencemap in possition 3
% end





