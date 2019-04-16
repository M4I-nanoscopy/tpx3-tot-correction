%% Creates the special map

Variables

functionaliser_T = zeros(1,Dim_x*Dim_y*Chipnr);
Length = length(functionaliser_T);

i = 0 ;
count = 0;
while i < Length
    i = i + 1;
    r = i/Dim_x;
    if  ((255 < r) && (r <= 256)) || ((511 < r) && (r <= 512)) || ((767 < r) && (r <= 768)) || ((1023 < r) && (r <= 1024))
        functionaliser_T(1,i) = 1;
    end
    
    if r < 256
        if r - count == 1/256
            functionaliser_T(1,i) = 1;
            count = count + 1;
            if count == 256 
               functionaliser_T(1,i) = 2;

            end
        end
        
    end
    
    if r > 256 && r < 513        
        if r - count == 256/256
            functionaliser_T(1,i) = 1;
            count = count + 1
            
            if count == 512 
               functionaliser_T(1,i) = 2;
               
            end
        end
        
    end
    
    if r > 512 && r < 769 
        if r - count == 1/256
            functionaliser_T(1,i) = 1;
            count = count + 1;
            if count == 768
               functionaliser_T(1,i) = 2;

            end
        end        
    end
    
    if r > 768        
        if r - count == 256/256
            functionaliser_T(1,i) = 1;
            count = count + 1
            
            if count == 1024 
               functionaliser_T(1,i) = 2;
               
            end
        end
        
    end
    

end

save(functionaliser_T)



% k= 1;
% kstart = 0;
% kend = 0;
% d = 0;
% 
% ToT_final_M = zeros(4,256,256,1);
% 
% while k < 5
%     
%     kstart = kend;
%     kend = k*256*256;
%     DINKY = permute(reshape(functionaliser_T(1,kstart+1:kend),1,256,256),[2,3,1]);
%     ToT_final_M(k,:,:,:) =  DINKY(:,:,:);
%     if k == 1 
%         TRY1(:,:) = DINKY(:,:,1);
%     end
%         if k ==2
%         TRY2(:,:) = DINKY(:,:,1);
%         end
%         if k == 3 
%         TRY3(:,:) = DINKY(:,:,1);    
%         end
%         if k == 4 
%         TRY4(:,:) = DINKY(:,:,1);
%         end
%         
%     k = k +1;
%     d = 1;
% end