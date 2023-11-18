% To remove the warning messages for using old syntax
warning('off','fuzzy:general:warnDeprecation_Newfis') 
warning('off','fuzzy:general:warnDeprecation_Addvar')
warning('off','fuzzy:general:warnDeprecation_Addmf')
warning('off','fuzzy:general:warnDeprecation_Evalfis')
warning('off','fuzzy:general:warnDeprecation_Addrule')
% Clears the Command Window of clutter
clc

% A declaration of new FIS
a = newfis('Loan Approval')


% Declaring a new variable - this is an INPUT(1)
a= addvar(a,'input','Gender',[0 3]);

% Populating the 1st input variable with membership functions
a = addmf(a, 'input', 1, 'Male', 'gaussmf', [0.25 1]);
a = addmf(a,'input',1,'Female','gaussmf',[0.25 2]);


% Declaring a new variable - this is an INPUT(2)
a = addvar(a, 'input', 'Marital Status', [0 7]);

% Populating the 2nd input variable with membership functions
a = addmf(a, 'input', 2, 'Single', 'trapmf', [0.5 0.75 1.25 1.5]); 
a = addmf(a, 'input', 2, 'Married', 'trapmf', [1.5 1.75 2.25 2.5]);
a = addmf(a, 'input', 2, 'Divorced', 'trapmf', [2.5 2.75 3.25 3.5]); 
a = addmf(a, 'input', 2, 'Seperated', 'trapmf', [3.5 3.75 4.25 4.5]);
a = addmf(a, 'input', 2, 'co-habiting', 'trapmf', [4.5 4.75 5.25 5.5]); 
a = addmf(a, 'input', 2, 'Other', 'trapmf', [5.5 5.75 6.25 6.5]); 


% Declaring a new variable - this is an INPUT(3)
a = addvar(a, 'input', 'DEPENDANTS', [0 6]);

% Populating the 3rd input variable with membership functions
a = addmf(a, 'input', 3, 'low Dependance', 'gaussmf', [0.7 1]);
a = addmf(a, 'input', 3, 'Mild Dependance', 'gaussmf', [0.7 3]);
a = addmf(a, 'input', 3, 'High Dependance', 'gaussmf',  [0.7 5]);


% Declaring a new variable - this is an INPUT(4)
a = addvar(a, 'input', 'EDUCATION', [0 4]);

% Populating the 3rd input variable with membership functions
a = addmf(a, 'input', 4, 'Graduate', 'gaussmf', [0.3 1]);
a = addmf(a, 'input', 4, 'Post Graduate', 'gaussmf', [0.3 2]);
a = addmf(a, 'input', 4, 'Doctorate', 'gaussmf',  [0.3 3]);

a = addvar(a, 'input', 'SELF-EMPLOYED', [0 3]);

% Populating the 2nd input variable with membership functions
a = addmf(a, 'input', 5, 'YES', 'gbellmf', [0.25 2.5 1]); 
a = addmf(a, 'input', 5, 'NO', 'gbellmf', [0.25 2.5 2]); 

%Make This GaussMF but take a screenshot before and explain
a = addvar(a, 'input', 'Applicantincome', [0 11000]);

a = addmf(a, 'input', 6, 'Very Low', 'gaussmf', [500 500]);
a = addmf(a, 'input', 6, 'Low', 'gaussmf', [500 2000]); 
a = addmf(a, 'input', 6, 'Medium', 'gaussmf', [500 4000]);
a = addmf(a, 'input', 6, 'High', 'gaussmf', [750 6000]);
a = addmf(a, 'input', 6, 'Very High', 'gaussmf', [750 9100]);


a = addvar(a, 'input', 'Coapplicantincome', [0 5000]);

a = addmf(a, 'input', 7, 'Low', 'gbellmf', [650 2.5 750]);
a = addmf(a, 'input', 7, 'Medium', 'gbellmf', [650 2.5 2500]);
a = addmf(a, 'input', 7, 'High', 'gbellmf', [650 2.5 4100]);

a = addvar(a, 'input', 'LoanAmount X1000', [0 500])

a = addmf(a, 'input', 8, 'Class C', 'gbellmf', [650 2.5 750]);
a = addmf(a, 'input', 8, 'Class B', 'gbellmf', [650 2.5 2500]);
a = addmf(a, 'input', 8, 'Class A', 'gbellmf', [650 2.5 4100]);

a = addvar(a, 'input', 'Loan_Amount_Term', [0 50])

a = addmf(a, 'input', 9, 'short-term', 'trapmf', [0 20 20 30]);
a = addmf(a, 'input', 9, 'Longterm', 'trapmf', [20 40 40 50]);

a = addvar(a, 'input', 'Credit_History', [0 30])

a = addmf(a, 'input', 10, 'Not-Defaulted', 'trimf', [0 10 20]);
a = addmf(a, 'input', 10, 'Defaulted', 'trimf', [10 20 30]);

a = addvar(a, 'input', 'Propert_Area', [0 4])

a = addmf(a, 'input', 11, 'Urban', 'gaussmf', [0.3 1]);
a = addmf(a, 'input', 11, 'Semi-Urban', 'gaussmf', [0.3 2]);
a = addmf(a, 'input', 11, 'Rural', 'gaussmf', [0.3 3]);

% Declaring a new variable - this is an OUTPUT(1)
a=addvar(a,'output','Approval Status',[0 100]);

% Populating the output variable with membership functions
a = addmf(a, 'output', 1, 'Approved', 'trapmf', [0 25 25 50]);
a = addmf(a,'output',1,'Not-Approved','trapmf',[50 75 75 100]); 
.

% The rulebase
%       i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 o1 w op
rule1 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule2 = [2 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule3 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule4 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule5 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule6 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule7 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule8 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule9 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule10 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule11 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];
rule12 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1];


ruleList = [rule1];


a = addrule(a, ruleList);

showrule(a)

ruleview(a)

% The subplots to visualise the system
figure(1)
subplot(1,1,1), plotmf(a, 'input', 9)

figure(2)
subplot(1,1,1), plotmf(a, 'output', 1)