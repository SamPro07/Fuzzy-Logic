% To remove the warning messages for using old syntax
warning('off','fuzzy:general:warnDeprecation_Newfis') 
warning('off','fuzzy:general:warnDeprecation_Addvar')
warning('off','fuzzy:general:warnDeprecation_Addmf')
warning('off','fuzzy:general:warnDeprecation_Evalfis')

% Clears the Command Window of clutter
clc

% A declaration of new FIS
a = newfis('Control Unit')
%a = newfis('Control Unit', 'DefuzzificationMethod', 'som')

%Default options for FIS
%                                                         AND OR    Impl Agg  Defuzzification
%a=newfis('Control Unit','mamdani','min','max', 'min','max','centroid');

%Different options for FIS
%                                                         AND OR    Impl Agg  Defuzzification
%a=newfis('Control Unit','mamdani','prod','probor', 'prod','max','centroid');

% Declaring a new variable - this is an INPUT(1)
a=addvar(a,'input','Day of Year',[0 365]);

% Populating the 1st input variable with membership functions
a = addmf(a, 'input', 1, 'Winter(1)', 'gaussmf', [25 0]);
a = addmf(a, 'input', 1, 'Spring', 'gaussmf', [25 105.5]);
a = addmf(a, 'input', 1, 'Summer', 'gaussmf', [25 197.5]);
a = addmf(a, 'input', 1, 'Autumn', 'gaussmf', [25 289]);
a = addmf(a, 'input', 1, 'Winter(2)', 'gaussmf', [25 365]);

% Declaring a new variable - this is an INPUT(2)
a = addvar(a, 'input', 'Time of Day', [0 1440]);

% Populating the 2nd input variable with membership functions
a = addmf(a, 'input', 2, 'Twilight(1)', 'trapmf', [0 0 60 240]); 
a = addmf(a, 'input', 2, 'Morning', 'trapmf', [120 300 660 780]); 
a = addmf(a, 'input', 2, 'Afternoon', 'trapmf', [660 780 1020 1140]); 
a = addmf(a, 'input', 2, 'Evening', 'trapmf', [1020 1140 1320 1440]);
a = addmf(a, 'input', 2, 'Twilight(2)', 'trapmf', [1200 1380 1440 1440]); 

% Declaring a new variable - this is an INPUT(3)
a = addvar(a, 'input', 'Temp', [-20 40]);

% Populating the 3rd input variable with membership functions
a = addmf(a, 'input', 3, 'Very Cold', 'trapmf', [-20, -20, -1, 0]);
a = addmf(a, 'input', 3, 'Cold', 'trapmf', [-2, 0, 4, 6]);
a = addmf(a, 'input', 3, 'Moderate', 'trapmf',  [4, 6, 10, 12]);
a = addmf(a, 'input', 3, 'Warm', 'trapmf',  [10, 14, 18, 22]);
a = addmf(a, 'input', 3, 'Very Warm', 'trapmf',  [18, 22, 40, 40]);

% Declaring a new variable - this is an OUTPUT(1)
a=addvar(a,'output','Heating (%)',[-5 100]);

% Populating the output variable with membership functions
a = addmf(a, 'output', 1, 'Off', 'trapmf', [-5 -5 0 0]);
a = addmf(a,'output',1,'Low','trimf',[0 15 33]); 
a = addmf(a,'output',1,'Moderate','trimf',[33 49.5 66]); 
a = addmf(a,'output',1,'High','trapmf',[66 83 100 100]);

% The rule declarations
rule1 = [1 1 2 3 1 1];
rule2 = [1 1 3 3 1 1];

rule3 = [5 5 2 3 1 1];
rule4 = [5 5 3 3 1 1];

rule5 = [5 1 2 3 1 1];
rule6 = [5 1 3 3 1 1];

rule7 = [1 5 2 3 1 1];
rule8 = [1 5 3 3 1 1]; 

% One input: Very Cold; Out = High
rule9 = [0 0 1 4 1 1]; 

% One input: Very Warm; Out = Off
rule10 = [0 0 5 1 1 1]; 

%Mrn & Vc = High
rule11 = [0 2 1 4 1 1]; 

%Mrn & C = High
rule12 = [0 2 2 4 1 1]; 

%Mrn & W = Low
rule13 = [0 2 4 2 1 1]; 

% Aft time & Temp
rule14 = [0 3 1 4 1 1]; 
rule15 = [0 3 2 4 1 1];
rule16 = [0 3 3 3 1 1];
rule17 = [0 3 4 2 1 1];
rule18 = [0 3 5 1 1 1];


% A matrix to hold the rule arrays
ruleList = [rule1; rule2; rule3; rule4; rule5; rule6; rule7; rule8; rule9; rule10;...
    rule11; rule12; rule13; rule14; rule15; rule16; rule17; rule18];

% Print the rules to the command window
showrule(a)

% Add the rules to the fis
a = addrule(a, ruleList);

% A varaible to hold the excel file
data = ('ControlUnitData.xlsx');

% Read in the values and store the in testData
testData = xlsread(data);

% A for loop to process the data and output the results
for i=1:size(testData,1)
        output = evalfis([testData(i, 1), testData(i, 2), testData(i, 3) ], a);
        fprintf('%d) In(1): %.2f, In(2) %.2f, In(3) %.2f => Out: %.2f \n\n',i,testData(i, 1),testData(i, 2),testData(i, 3), output);  
        xlswrite('ControlUnitData.xlsx', output, 1, sprintf('F%d',i+1));
end

% The ruleview allows you to see the rule-base
ruleview(a)

% The subplots to visualise the system
figure(1)
subplot(4,1,1), plotmf(a, 'input', 1)
subplot(4,1,2), plotmf(a, 'input', 2)
subplot(4,1,3), plotmf(a, 'input', 3)
subplot(4,1,4), plotmf(a, 'output', 1)
