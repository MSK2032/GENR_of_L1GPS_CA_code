% Code to generate CA for a particular SV ID 

Gi  = ones(1,10); % initialing g1 shift register 
Gii = ones(1,10); % initialing g1 shift register 
L=10;D=5; % L= Desired length of the PRN, D = Desired delay
SVID = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;32;32;33;34;35;36;37];
x = [2;3;4;5;1;2;1;2;3;2;3;5;6;7;8;9;1;2;3;4;5;6;1;4;5;6;7;8;1;2;3;4;5;4;1;2;4];
y = [6;7;8;9;9;10;8;9;10;3;4;6;7;8;9;10;4;5;6;7;8;9;3;6;7;8;9;10;6;7;8;9;10;10;7;8;10];
CPST = table(SVID,x,y) %Code Phase Selection Table
n=numel(y);
z = input('Enter SV ID number');
for i = 1:n
    if z==SVID(i,1)
        x = x(i,1)
        y = y(i,1)
    end
end
xGii=Gii;
for i=1:L
     newBitGi=xor(Gi(3),Gi(10));  % performing 3rd and 10th bit xor
     Gone(1,i)=Gi(1,10); % generating output G1
     Gi= [newBitGi Gi(1:9)]; % shifting g1 register right 
    
  
      xi=xor(Gii(2),Gii(3));% performing 2,3,6,8,9 and 10th bit xor
      xii=xor(xi,Gii(6));
      xiii=xor(xii,Gii(8));
      xiv=xor(xiii,Gii(9));
      newBitGii=xor(xiv, Gii(10));
      Gtwoi(1,i)=xor(Gii(x), Gii(y));% generating output G2i by performing  x and y bit xor for PRN 1
      Gtwo(1,i)=Gii(1,10); % genearting output G2
      Gii= [newBitGii Gii(1:9)];% shifting g2 register right 
end
CA_code = bitxor(Gone, Gtwoi) % genearting output XGi