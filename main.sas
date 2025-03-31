%include "LifeRegFits/LifeRegFits.sas";

proc import out=bladder
file='/LifeRegFits/Data/bladder.csv'
dbms=csv replace;
run;

%let list = exponential gamma llogistic weibull logistic lnormal normal;

%LifeRegFits(data = work.bladder, list = &list, censors = (0,2,3));

data exponential;set exponential;if Distribution = 'Value' then Distribution = 'exponential' ; run;
data gamma      ;set gamma      ;if Distribution = 'Value' then Distribution = 'gamma' ; run;
data llogistic  ;set llogistic  ;if Distribution = 'Value' then Distribution = 'llogistic' ; run;
data weibull    ;set weibull    ;if Distribution = 'Value' then Distribution = 'weibull' ; run;
data logistic   ;set logistic   ;if Distribution = 'Value' then Distribution = 'logistic' ; run;
data lnormal    ;set lnormal    ;if Distribution = 'Value' then Distribution = 'lnormal' ; run;
data normal     ;set normal     ;if Distribution = 'Value' then Distribution = 'normal' ; run;

data fitdata;
set exponential gamma llogistic weibull logistic lnormal normal; 
run;

title 'Compare fits';
proc print data=fitdata;run;