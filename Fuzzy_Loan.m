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
% Rule 1: If applicant has a good credit history and a high income, regardless of other factors, then the loan is likely to be approved.
rule1 = [0 0 0 0 0 4 0 0 0 1 0 1 1 1]; % (High income and good credit history lead to approval)
%Rule 2: If applicant is self-employed with a very high income but poor credit history, the loan may still be approved.
rule2 = [0 0 0 0 2 5 0 0 0 2 0 1 1 1]; % (Self-employed with very high income and poor credit)
%Rule 3: If applicant has a low income, regardless of other factors, the loan is less likely to be approved.
rule3 = [0 0 0 0 0 2 0 0 0 0 0 2 1 1]; % (Low income leads to non-approval)
%Rule 4: Married applicants with stable income and good credit history are more likely to get approval.
rule4 = [0 2 0 0 0 3 0 0 0 1 0 1 1 1]; % (Married with stable income and good credit)
%Rule 5: Single applicants with high dependants and low income are less likely to be approved.
rule5 = [0 1 3 0 0 2 0 0 0 0 0 2 1 1]; % (Single with high dependants and low income)
%Rule 6: Applicants with a doctorate, high income, and good credit history have a high chance of approval.
rule6 = [0 0 0 3 0 4 0 0 0 1 0 1 1 1]; % (Doctorate, high income, good credit)
%Rule 7: Applicants with no dependants, moderate income, and living in urban areas are likely to get approved.
rule7 = [0 0 1 0 0 3 0 0 0 0 1 1 1 1]; % (No dependants, moderate income, urban area)
%Rule 8: Self-employed individuals with a high loan amount and poor credit history are less likely to be approved.
rule8 = [0 0 0 0 2 0 0 3 0 2 0 2 1 1]; % (Self-employed, high loan amount, poor credit)
%Rule 9: Applicants with co-applicants having a medium income, seeking a small loan amount, are likely to be approved.
rule9 = [0 0 0 0 0 0 2 1 0 0 0 1 1 1]; % (Co-applicant with medium income, small loan amount)
%Rule 10: Applicants with a short-term loan, low dependants, and residing in semi-urban areas are likely to be approved.
rule10 = [0 0 1 0 0 0 0 0 1 0 2 1 1 1]; % (Short-term loan, low dependants, semi-urban)
%Rule 11: Applicants with defaulted credit history and seeking a high loan amount are less likely to be approved.
rule11 = [0 0 0 0 0 0 0 3 0 2 0 2 1 1]; % (Defaulted credit, high loan amount)
%Rule 12: Married applicants with no dependants, moderate income, and residing in rural areas have a fair chance of approval.
rule12 = [0 2 1 0 0 3 0 0 0 0 3 1 1 1]; % (Married, no dependants, moderate income, rural area)



ruleList = [rule1];


a = addrule(a, ruleList);

showrule(a)

ruleview(a)

% The subplots to visualise the system
figure(1)
subplot(1,1,1), plotmf(a, 'input', 9)

figure(2)
subplot(1,1,1), plotmf(a, 'output', 1)
