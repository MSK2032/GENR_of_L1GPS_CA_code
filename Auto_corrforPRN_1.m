% Code to generate CA for SV ID 1 and checking correlation
Gi  = ones(1,10); % initialing g1 shift register 
Gii = ones(1,10); % initialing g1 shift register 
xGii=Gii;
L=1023;D=5; % L= Desired length of the PRN, D = Desired delay
for i=1:L
     newBitGi=xor(Gi(3),Gi(10));  % performing 3rd and 6th bit xor
     Gone(1,i)=Gi(1,10); % generating output G1
     Gi= [newBitGi Gi(1:9)]; % shifting g1 register right 
    
  
      xi=xor(Gii(2),Gii(3));% performing 2,3,6,8,9 and 10th bit xor
      xii=xor(xi,Gii(6));
      xiii=xor(xii,Gii(8));
      xiv=xor(xiii,Gii(9));
      newBitGii=xor(xiv, Gii(10));
      Gtwoi(1,i)=xor(Gii(2), Gii(6));% generating output G2i by performing  2nd and 6th bit xor for PRN 1
      Gtwo(1,i)=Gii(1,10); % genearting output G2
      Gii= [newBitGii Gii(1:9)];% shifting g2 register right 
end
Gone;
Gtwo;
Gtwoi;
xGi = bitxor(Gone, Gtwoi); % genearting output XGi
CA_c= (xGi==0)*(1) + (xGi==1)*(-1); %coversion of PRN to +-1 for correlation process
CA1= CA_c;
[cor_seq lags]=xcorr(CA1, CA1);
plot(lags,cor_seq);
xlabel('lag')
ylabel('Correlation Measure')
title('Autocorrelation of PRN')