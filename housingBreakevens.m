% ----------------------------------------------------------------------- %
% ------------------ Living Break-evens --------------------------------- %
% ----------------------------------------------------------------------- %
% Calculate the break-evens and opportunity costs of buying a condo,
% renting, and buying a house. Also, considering the opportunity costs of
% reinvesting principle rather than putting down payment on a mortgage
clc, clear, close all

% ----------------------------------------------------------------------- %
% ---------------------- HOUSING INPUTS --------------------------------- %
% ----------------------------------------------------------------------- %
principle = 200000; 
downPaymentPercent = 20 * 0.01; % Variable
closingCostPercent = 5 * 0.01; 
paymentYears = 30;
propertyTaxRate = 1.24 * 0.01; 
mortgageInterest = 3.87 * 0.01; 
estimatedInsuranceYear = 1354; 
utilMonth = 150; 
hoaMonth = 387; 
rentBrooks = 780; 
rentMonth = 1575; 
preTaxSalaryYear = 90000; 
preTaxSalaryMonth = preTaxSalaryYear/12; 
taxRate = 0.713;
takeHomeSalaryYear = taxRate* preTaxSalaryYear;
takeHomeSalaryMonth = takeHomeSalaryYear/12; 
principleRateOfReturn = 10 * 0.01; 
percentHouseGrowth = 100 * 0.01;

% Scenario #1 Purchasing a House
%
%
%

downPayment = principle * downPaymentPercent; 
closingCosts = principle * closingCostPercent; 
mortgageNet = principle - downPayment;  
N = 12 * paymentYears;                            % Assuming 30-year fixed rate

% Basic Mortgage Stats: 
% Source: https://www.bankrate.com/calculators/mortgages/mortgage-calculator.aspx
% M = P[r(1+r)^n/((1+r)^n)-1)]

monthlyMortgageInterest = mortgageInterest/12; 
mortgageMonthlyPayment = mortgageNet*(monthlyMortgageInterest*(1+monthlyMortgageInterest)^N) / ((1 + monthlyMortgageInterest)^N - 1); 

% Property Tax
%
% Source: https://smartasset.com/taxes/massachusetts-property-tax-calculator#:~:text=Overview%20of%20Massachusetts%20Taxes,higher%20than%20the%20national%20average.
propertyTaxYear = propertyTaxRate * principle; 
propertyTaxMonth = propertyTaxYear/12;

% Housing Insurance 
%
% Source: https://www.bankrate.com/insurance/homeowners-insurance/in-massachusetts/
estimatedInsuranceMonth = estimatedInsuranceYear/ 12; 

% Housing Utilities and Maintenance
%
%
maintenanceMonth = 0.01 * principle /12; 

% Total Monthly Costs
totalHousingCostMonth = mortgageMonthlyPayment + propertyTaxMonth + estimatedInsuranceMonth + utilMonth + maintenanceMonth; 
totalHousingCostLife = N*totalHousingCostMonth; 

fprintf('==================================================================================== \n'); 
fprintf('Mortgage Principle %0.2f ($) \n', principle);
fprintf('Down Payment Percent %0.1f (%%) \n', 100*downPaymentPercent);
fprintf('Down Payment %0.2f ($) \n', downPayment); 
fprintf('Closing Cost Percent %0.1f (%%) \n', 100*closingCostPercent);
fprintf('Closing Cost %0.2f ($) \n', closingCosts); 
fprintf('Yearly Mortgage Interest Rate %0.1f (%%) \n', 100*mortgageInterest); 
fprintf('Payment Months: %i (months) \n', N); 
fprintf('Monthly Mortgage Payment %0.2f ($) \n', mortgageMonthlyPayment); 
fprintf('Property Tax Rate: %0.1f (%%) \n', 100*propertyTaxRate); 
fprintf('Propety Tax Monthly Cost: %0.1f ($) \n', propertyTaxMonth); 
fprintf('Property Insurance Monthly Cost: %0.1f ($) \n', estimatedInsuranceMonth); 
fprintf('Monthly Utilities: %0.1f ($) \n', utilMonth); 
fprintf('Monthly Maintenance: %0.1f ($) \n', maintenanceMonth); 
fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('Opportunity Cost of Interest (Compounded) %0.2f (%%) \n', 100*principleRateOfReturn); 
fprintf('Expected Percent increase in house value %0.2f (%%) \n', 100*percentHouseGrowth); 
fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('HOUSE NET MONTHLY COST %0.2f ($) \n', totalHousingCostMonth); 
fprintf('HOUSE LIFETIME COST %0.2f ($) \n', totalHousingCostLife); 
fprintf('-------------------------------------------------------------- \n'); 

% Scenario #2 Purchasing a Condo
%
%
% Source: https://www.longwoodresidential.com/blog/posts/2018/05/15/homeowners-association-fees-guide-boston-ma/
condoCostMonth = mortgageMonthlyPayment + propertyTaxMonth + estimatedInsuranceMonth + utilMonth + hoaMonth; 
condoCostLife = N*totalHousingCostMonth; 
fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('CONDO NET MONTHLY COST %0.2f ($) \n', condoCostMonth); 
fprintf('CONDO LIFETIME COST %0.2f ($) \n', condoCostLife); 
fprintf('----------------------------------------------------------------------------------- \n'); 

% Scenario #3 Renting
%
%
%
totalRentCostMonth = rentMonth + utilMonth; 
rentCostLife = N*totalRentCostMonth; 
fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('RENT NET MONTHLY COST %0.2f ($) \n', totalRentCostMonth); 
fprintf('RENT LIFETIME COST %0.2f ($) \n', rentCostLife); 
fprintf('----------------------------------------------------------------------------------- \n'); 

% Calculating Opportunity Cost of Renting
%
%

opportunityCost = (downPayment+closingCosts)*(1+principleRateOfReturn)^(N/12); 
fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('Opportunity Cost of Reinvesting (Principle+Closing Cost) of N-years mortgage %0.2f ($) \n', opportunityCost); 
fprintf('----------------------------------------------------------------------------------- \n'); 


% Projected housing costs over-time
%
%
projectedHousingAssetPrice = (1+percentHouseGrowth)* principle; 
investmentGainHouse = projectedHousingAssetPrice - totalHousingCostLife;
investmentGainRent = opportunityCost - rentCostLife; 
fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('Housing Investment Gain %0.2f ($) \n', investmentGainHouse); 
fprintf('Rent Opportunity Cost Investiment Gain %0.2f ($) \n', investmentGainRent); 
fprintf('----------------------------------------------------------------------------------- \n'); 

% Valuing my free-time lost in commute. 
%
%
expertsRent = preTaxSalaryMonth * 0.3; 
conservativeRent = takeHomeSalaryMonth *0.3; 

MY_TIME = 75;               % ($) per hour
commuteTimeBrooks = 50;     % minutes
daysPerWeekCommute = 5;     % 
weeksPerMonth = 4;          % 
brooksStreetApartmentMyTime = MY_TIME*weeksPerMonth* daysPerWeekCommute*(2*commuteTimeBrooks/60) ;
brooksStreetApartmentNet = brooksStreetApartmentMyTime + rentBrooks; 

commuteTimeCloser = 25; 
closerApartmentMyTime = MY_TIME*weeksPerMonth* daysPerWeekCommute*(2*commuteTimeCloser/60) ;
closerApartmentNet = closerApartmentMyTime + rentMonth;
brooksVCloser = brooksStreetApartmentNet - closerApartmentNet; 

if brooksVCloser > 0
    shouldIMove = 'Brooks is MORE (+) expensive when you include what my time is worth'; 
else
    shouldIMove = 'Brooks is LESS (-) expensive when you include what my time is worth'; 
end

fprintf('----------------------------------------------------------------------------------- \n'); 
fprintf('Yearly Salary %0.2f ($) \n', preTaxSalaryYear); 
fprintf('Monthly Salary %0.2f ($) \n', preTaxSalaryMonth); 
fprintf('Yearly Salary Take home %0.2f ($) \n', takeHomeSalaryYear); 
fprintf('Monthly Salary Take home %0.2f ($) \n', takeHomeSalaryMonth); 
fprintf('Expert Monthly Rent %0.2f ($) \n', expertsRent); 
fprintf('Conservative Monthly Rent %0.2f ($) \n', conservativeRent); 
fprintf('What My Free Time is Worth %0.2f ($) per hour \n', MY_TIME);
fprintf('Time-Money Lost at Brooks apartment per month: %0.2f ($) \n', brooksStreetApartmentMyTime); 
fprintf('Time-Money Lost at Closer apartment per month: %0.2f ($) \n', closerApartmentMyTime); 
fprintf('NET LOST AT BROOKS %0.2f \n', brooksStreetApartmentNet); 
fprintf('NET LOST AT Closer %0.2f \n', closerApartmentNet);
fprintf('BROOKS - CLOSER %0.2f (+) \n', brooksVCloser); 
fprintf('%s \n', shouldIMove); 
fprintf('----------------------------------------------------------------------------------- \n'); 


%% Plot graphs
%
%
%

% PLOT 1
%
% Plot respective costs per living situation
time = 0:paymentYears; 
costHousing = downPayment + totalHousingCostMonth*(12*time); 
costCondo = downPayment + condoCostMonth*(12*time);
opportunityCost = (downPayment+closingCosts)*(1+principleRateOfReturn).^(time); 
costApartment = 12*totalRentCostMonth*time;

figure
plot(time, costHousing, '-*', time, costCondo, '-*', time, costApartment, '-*')
costAxis = gca; 
costAxis.YAxis.Exponent = 0; 
legend('House', 'Condo', 'Apartment')
title('Cost of Real Estate over Time')
xlabel('Time (year)')
ylabel('Cost ($)')
grid on 

% PLOT 2
%
% Net worth versus opportunity cost, if looking as an investment
figure
homeOwnerNetWorth = (12*time)*mortgageMonthlyPayment + downPayment; 
plot(time, homeOwnerNetWorth, '-*',  time, opportunityCost, '-*')
netWorthAxis = gca;
netWorthAxis.YAxis.Exponent = 0; 
legend('Home Owner Net-worth', 'Investment')
title('Home "Equity" Worth no rise in housing prices')
xlabel('Time (year)')
ylabel('Net-Worth ($)')
grid on 

% PLOT 3
%
% Net worth versus opportunity cost, if looking as an investment
figure
yearlyProjectedHomeOwner = linspace(downPayment, projectedHousingAssetPrice, paymentYears+1);
plot(time, yearlyProjectedHomeOwner, '-*', time, opportunityCost, '-*')
netWorthAxis = gca;
netWorthAxis.YAxis.Exponent = 0; 
legend('Home Owner Net-worth', 'Investment')
title('Home "Equity" with housing price increase, Assumption is a house an Asset')
xlabel('Time (year)')
ylabel('Net-Worth ($)')
grid on 

% PLOT 4
%
%
% figure
% yearlyProjectedHomeOwner = linspace(downPayment, projectedHousingAssetPrice, paymentYears+1);
% plot(time, yearlyProjectedHomeOwner, time, opportunityCost)
% netWorthAxis = gca;
% netWorthAxis.YAxis.Exponent = 0; 
% legend('Home Owner Net-worth', 'Investment')
% title('Net Worth with housing price increase, Assumption is a house an Asset')
% xlabel('Time (year)')
% ylabel('Net-Worth ($)')
% grid on 


%% Apartment Compare







