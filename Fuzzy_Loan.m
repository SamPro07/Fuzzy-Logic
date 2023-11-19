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


%Rule 13: If the applicant has a poor credit history and a low income, the loan is likely to be not approved.
rule13 = [0 0 0 0 0 2 0 0 0 2 0 2 1 1]; % (Low income and poor credit history lead to non-approval)
%Rule 14: Self-employed applicants with a low income and poor credit history are less likely to get approval.
rule14 = [0 0 0 0 2 2 0 0 0 2 0 2 1 1]; % (Self-employed, low income, and poor credit)
%Rule 15: High loan amount requests by applicants with a poor credit history are typically not approved.
rule15 = [0 0 0 0 0 0 0 3 0 2 0 2 1 1]; % (High loan amount and poor credit history)
%Rule 16: Applicants with high dependants and very low income are less likely to be approved.
rule16 = [0 0 3 0 0 1 0 0 0 0 0 2 1 1]; % (High dependants and very low income)
%Rule 17: Married applicants with no stable income and poor credit history are likely to face rejection.
rule17 = [0 2 0 0 0 2 0 0 0 2 0 2 1 1]; % (Married, unstable income, poor credit)
%Rule 18: Applicants with a short-term loan request but very low income and poor credit history are less likely to be approved.
rule18 = [0 0 0 0 0 1 0 0 1 2 0 2 1 1]; % (Short-term loan, very low income, poor credit)
%Rule 19: Single applicants with a high loan amount request and poor credit history are typically not approved.
rule19 = [0 1 0 0 0 0 0 3 0 2 0 2 1 1]; % (Single, high loan amount, poor credit)
%Rule 20: Applicants living in rural areas with low income and high dependents are less likely to get approval.
rule20 = [0 0 3 0 0 2 0 0 0 0 3 2 1 1]; % (Rural area, low income, high dependants)
%Rule 21: Applicants with a defaulted credit history and a very high loan amount are typically not approved.
rule21 = [0 0 0 0 0 0 0 5 0 2 0 2 1 1]; % (Defaulted credit, very high loan amount)
%Rule 22: Applicants with no co-applicant, seeking a large loan amount, and having a poor credit history are less likely to be approved.
rule22 = [0 0 0 0 0 0 1 3 0 2 0 2 1 1]; % (No co-applicant, large loan amount, poor credit)
%Rule 23: Self-employed individuals with no credit history and moderate-income are less likely to be approved.
rule23 = [0 0 0 0 2 3 0 0 0 0 0 2 1 1]; % (Self-employed, no credit history, moderate income)
%Rule 24: Applicants with unstable employment, seeking a long-term loan, and having a poor credit history are typically not approved.
rule24 = [0 0 0 0 0 2 0 0 2 2 0 2 1 1]; % (Unstable employment, long-term loan, poor credit)

%Rule 25: If the applicant is single and self-employed with a medium income, but has a rural property, the loan may be approved.
rule25 = [0 1 0 0 2 3 0 0 0 0 3 1 1 1];
%Rule 26: A divorced applicant with no dependants and a graduate degree, applying for a small loan, may get approval.
rule26 = [0 3 1 1 0 0 0 1 0 0 0 1 1 1];
%Rule 27: An applicant with a high income but residing in a semi-urban area and seeking a short-term loan might face rejection.
rule27 = [0 0 0 0 0 4 0 0 1 0 2 2 1 1];
%Rule 28: A married applicant with high dependants, no credit history, but living in an urban area might get a loan.
rule28 = [0 2 3 0 0 0 0 0 0 0 1 1 1 1];
%Rule 29: If the applicant is a postgraduate with low income but no dependants, the loan approval is uncertain.
rule29 = [0 0 1 2 0 2 0 0 0 0 0 0 1 1];
%Rule 30: An applicant with a doctorate, high dependants, and self-employed status might be approved for a loan.
rule30 = [0 0 3 3 2 0 0 0 0 0 0 1 1 1];
%Rule 31: A female applicant with medium income and urban property, applying for a large loan, may face rejection.
rule31 = [2 0 0 0 0 3 0 3 0 0 1 2 1 1];
%Rule 32: An applicant with defaulted credit history, but high income and urban property, might get approval.
rule32 = [0 0 0 0 0 4 0 0 0 2 1 1 1 1];
%Rule 33: A graduate with low income, applying for a long-term loan, could be approved if they have a semi-urban property.
rule33 = [0 0 0 1 0 2 0 0 2 0 2 1 1 1];
%Rule 34: An unmarried, self-employed applicant with moderate income might get a loan for urban property.
rule34 = [0 1 0 0 2 3 0 0 0 0 1 1 1 1];
%Rule 35: A married applicant with a very high income, seeking a high loan amount, might not be approved.
rule35 = [0 2 0 0 0 5 0 3 0 0 0 2 1 1];
%Rule 36: An applicant with no co-applicant, medium income, and good credit history, applying for a Class B loan, might be approved.
rule36 = [0 0 0 0 0 3 1 2 0 1 0 1 1 1];

% The only Or rule that will get approved 
% Applicant is a Doctorate or self-employed or very high income or high co applicant income then loan may be approved.  
rule37 = [0 0 0 3 1 5 3 0 0 0 0 1 1 2];



ruleList = [rule1,rule2,rule3,rule4,rule5,rule6,rule7,rule8,rule9,rule10,rule11,rule12,rule13,rule14,rule15,rule16,
rule17,rule18,rule19,rule20,rule21,rule22,rule23,rule24,rule25,rule26,rule27,rule28,rule29,rule30,rule31,rule32,rule33
rule34,rule35,rule36,rule37];


a = addrule(a, ruleList);

showrule(a)

filename = ('heatingandcooling.xls');
testData = xlsread(filename);

% The for loop processing the date and printing to the command window

for i = 1:size(testData, 1)
    % Assuming the first 11 columns after 'Loan_ID' are the inputs
    eval = evalfis(testData(i, 2:12), a); 
    fprintf('%d) In(1):%.2f, In(2):%.2f, In(3):%.2f, In(4):%.2f, In(5):%.2f, In(6):%.2f, In(7):%.2f, In(8):%.2f, In(9):%.2f, In(10): %.2f, In(11): %.2f => Out(1): %.2f\n\n', i, testData(i, 1), testData(i, 2), testData(i, 3),testData(i, 4), testData(i, 5), testData(i, 6), testData(i, 7), testData(i, 8), testData(i, 9), testData(i, 10), testData(i, 11) testData(i, 12), eval);
    xlswrite('loan_data_set.xls', eval, 1, sprintf('M%d', i+1)); % Writing the output in column 'M'
end


ruleview(a)

% The subplots to visualize the system
figure(1)
subplot(1,1,1), plotmf(a, 'input', 9)

figure(2)
subplot(1,1,1), plotmf(a, 'output', 1)
