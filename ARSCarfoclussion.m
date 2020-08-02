clear;

% the detailed description can be found on the AR expriemntap part in the paper Robust two-dimensional linear discriminant analysis via
% information divergence  

% data contains 7 images of each persion from the first session in readdataAR1
load readdataAR1 data LabelClass
data1=data;
L1=LabelClass;
% data contains 3 images of each person from the first session in ScarfreaddataAR1
 load ScarfreaddataAR1 data LabelClass 
 data2=data;
 L2=LabelClass;
 %data contains 3 images of each person from the first session in ScarfreaddataAR2
load ScarfreaddataAR2 data LabelClass 
 data3=data;
 L3=LabelClass;
 load readdataAR2 data LabelClass
 % data contains 7 images of each persion from the second session in readdataAR2
 for uu=1:10
  [trainsA, labelsA, trainsB, labelsB ] = split(data1, L1, 3);
 

 
% the first phase
%save readdataAR2 data LabelClass 
% save ScarfreaddataAR2 data LabelClass 
%save SunreaddataAR2 data LabelClass count1


   c = length(unique(LabelClass));
   
   

  
   trainS=[trainsA data2 data3];
   trainLabel=[ labelsA; L2;L3];
   testS=data;
   testLabel=LabelClass;

  
%testS=addoccluion(testS,testLabel, ratio, blocksize, 0);
%load test1 trainS testS trainLabel testLabel
%X=randn(5,4,5);
 %y=[1; 1;1;1; 1];
 m=32;
 MaxIter=20;
 Pa1=1;
 Pa2=1;
 % Here we fix the parameters and you can choose other parameters
  trainS1=vectortotensor(trainS);
  testS1=vectortotensor(testS);
 
   % Uni2DRLDA-new is the methods  i denotes the number of extracted
   % features, Pa1, Pa2 are paramters in our methods, W1 is the projection matrix  

 for i=1:m
  [W1,ob] =UniD2RLDA_new(trainS1, trainLabel,i, MaxIter,Pa1, Pa2);
 %b = tensorL21(trainS1,testS1,trainLabel,testLabel,W1(:,1:i),W2(:,1:i));
  b = tensorL21(trainS1,testS1,trainLabel,testLabel,W1(:,1:i),eye(size(trainS1,1),size(trainS1,1)));
   
 Crates(uu,i)=b;

 end
  
  Crates
 
 
 %max(liang1)
  

 
  
 
 %max(liang3)
 
 %max(liang2)
 end

   
