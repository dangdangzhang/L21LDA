load readdataAR1 data LabelClass
data1=data;
L1=LabelClass;
 load SunreaddataAR1 data LabelClass 
 data2=data;
 L2=LabelClass;
load SunreaddataAR2 data LabelClass 
 data3=data;
 L3=LabelClass;
  load readdataAR2 data LabelClass
  
  m=32;
 MaxIter=20;
 Pa1=1;
 Pa2=1;

 for uu=1:10
  [trainsA, labelsA, trainsB, labelsB ] = split(data1, L1, 3);
 

 
% the first phase
%save readdataAR2 data LabelClass 
% save ScarfreaddataAR2 data LabelClass 
%save SunreaddataAR2 data LabelClass count1


   c = length(unique(LabelClass));
   
   

  
   trainS=[trainsA data2 data3];
   trainLabel=[labelsA; L2;L3];
   testS=data;
   testLabel=LabelClass;

  
%testS=addoccluion(testS,testLabel, ratio, blocksize, 0);
%load test1 trainS testS trainLabel testLabel
%X=randn(5,4,5);
 %y=[1; 1;1;1; 1];
 
  trainS1=vectortotensor(trainS);
  testS1=vectortotensor(testS);
   

 
  

 for i=1:m
  [W1,ob] =UniD2RLDA_new(trainS1, trainLabel,i, MaxIter,Pa1, Pa2);
 %b = tensorL21(trainS1,testS1,trainLabel,testLabel,W1(:,1:i),W2(:,1:i));
  b(uu,i) = tensorL21(trainS1,testS1,trainLabel,testLabel,W1(:,1:i),eye(size(trainS1,1),size(trainS1,1)));
 
 end

 
 %clear b;
 %max(liang2)
 end
   save sunARExperiment4 b
   
