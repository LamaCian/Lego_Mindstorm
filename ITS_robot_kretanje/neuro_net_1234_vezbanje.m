clc,clear, close all
%Initialise input vectors
i1=[0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0]';
i2=[0 1 1 1 0 1 0 0 0 1 0 0 0 0 1 0 0 1 1 0 0 1 0 0 0 1 0 0 0 0 1 1 1 1 1 0 0 0 0 0]';
i3=[1 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 0 1 1 0 0 0 0 0 1 1 0 0 0 1 0 1 1 1 0 0 0 0 0 0]';
i4=[1 0 0 1 0 1 0 0 1 0 1 0 0 1 0 1 1 1 1 1 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0]';
i=[i1 i2 i3 i4];
%Initialise output vectors
o1=[1 0 0 0]';
o2=[0 1 0 0]';
o3=[0 0 1 0]';
o4=[0 0 0 1]';
o=[o1 o2 o3 o4];
%
%Define the range of input vector
%kk=[zeros(size(i,1),1) ones(size(i,1),1)];
%Define the structure of feedforward neural nework
net=newff(i,o,[20,20,4],{'logsig','logsig','logsig'},'trainlm'); 
%kada se definise mreza broj definisanih slojeva mora da bude jednak broju 
%definisanih prenosnih funkicija, u ovom slucaju za [20,20,4]ide 3x'logsig'
%
y=sim(net,i);
%Training parameters
net.trainParam.show=100;
net.trainParam.lr=0.5;
net.trainParam.epochs=1000;
net.trainParam.goal=1e-9;
%Initialise training
net=train(net,i,o);
%prilikom treniranje moze da se unese drugi naziv (net1=train...) u odnosu na naziv 
%prilikom definisanja mreze (net=newff...), sa tim da taj naziv stoji i na
%izlazu (y=sim(net1,...))
%
%View training results
y=sim(net,i(:,:))

