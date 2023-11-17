Structure of a Rule with 11 Inputs
A rule in a FIS with 11 inputs and, say, 2 outputs might look something like this:

***ruleX = [i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 o1 o2 w op];

i1 to i11 are indices representing the states (membership functions) of the 11 inputs.
o1, o2 are the indices for the output states.
w is the weight of the rule.
op is the operator used in the rule (usually AND or OR in Mamdani systems).

% The rulebase 
rule1 = [0 0 1 1 4 1 1];
rule2 = [0 0 5 4 1 1 1];
rule3 = [0 0 3 1 2 1 1];

% Collect the rules in an array
ruleList = [rule1;rule2;rule3];

% Add the rules to the system
a = addrule(a, ruleList);

% Print the rules to the command window
showrule(a)

% Read in the Excel data file
filename = ('heatingandcooling.xls');
testData = xlsread(filename);

% The for loop processing the date and printing to the command window
% Also, it writes the outout values to the same heatingandcooling.xls file
for i=1:size(testData,1)
        eval = evalfis([testData(i, 1), testData(i, 2), testData(i, 3) ], a);
        fprintf('%d) In(1): %.2f, In(2) %.2f, In(3) %.2f => Out(1): %.2f Out(2): %.2f  \n\n',i,testData(i, 1),testData(i, 2),testData(i, 3), eval);  
        xlswrite('heatingandcooling.xls', eval, 1, sprintf('E%d',i+1));
end

ruleview(a)

figure(1)
subplot(3,1,1), plotmf(a, 'input', 1)
subplot(3,1,2), plotmf(a, 'input', 2)
subplot(3,1,3), plotmf(a, 'input', 3)

figure(2)
subplot(2,1,1), plotmf(a, 'output', 1)
subplot(2,1,2), plotmf(a, 'output', 2)
