# Parametric model fit analysis using Proc Lifereg

# Overview
LIFEREG offers a wide array of parametric survival functions and in order to determine which one requires the best fit, often times the best approach is to fit each model and compare the fitted values (AIC/BIC/etc..).

The LifeRegFit offers a much more user friendly way of testing the supported distributions on a dataset.

## [Supported Distributions:](https://support.sas.com/documentation/cdl/en/statug/63033/HTML/default/viewer.htm#statug_lifereg_sect019.htm)
<ul>
<li>Exponential
<li>Generalized Gamma
<li>Logistic
<li>Loglogistic
<li>Lognormal
<li>Normal
<li>Weibull
</ul>

# Set-up
<ol>
<li> Clone the Github repository.</li>

```
    git clone https://github.com/kiphandwerker/LifeRegFits.git
```

<li>Upload the files to SAS OnDemand or SAS program of choice.
<li>Change the main.sas file to point to the appropriate location.
</ol>

# Usage
The main.sas file contains all of the code necessary to run the macro, however we will walk through it step by step:

<ol>
<li> Source the rquired macro LifeRegFits (Be mindful the path needs to change for you)

```sas
%include "../LifeRegsMacro/LifeRegFits.sas";
```
<li> Read in .csv (Be mindful the path needs to change for you)

```sas
proc import out=bladder
file='../LifeRegsMacro/bladder_revised.csv'
dbms=csv replace;run;
```

<li> The macro requires a list of which distributions to loop through which will be read in as a macro. 

```sas
%let list = exponential gamma llogistic weibull logistic lnormal normal;
```

<li>Call the macro. <br>

```sas
%LifeRegFits(data = work.bladder, list = &list, censors = (0,2,3));
```
Note: The censored values default as (0,2,3), but nore they can be changed for your specific data.

<li> Now that we have a bunch of data we can create data sets with just the required information 

```sas
data exponential;
set exponential;
if Distribution = 'Value' then Distribution = 'exponential';run;
data gamma;
set gamma;
if Distribution = 'Value' then Distribution = 'gamma';run;
data llogistic;
set llogistic;
if Distribution = 'Value' then Distribution = 'llogistic';run;
data weibull;
set weibull;
if Distribution = 'Value' then Distribution = 'weibull';run;
data logistic;
set logistic;
if Distribution = 'Value' then Distribution = 'logistic';run;
data lnormal;
set lnormal;
if Distribution = 'Value' then Distribution = 'lnormal';run;
data normal;
set normal;
if Distribution = 'Value' then Distribution = 'normal';run;
```

<li>Now we can combine them into one data set

```sas
data fitdata;
set exponential gamma llogistic weibull logistic lnormal normal; run;
```

<li>Lastly, we print the data and can easily compare

```sas
title 'Compare fits';
proc print noobs data=fitdata;run;
```

</ol>