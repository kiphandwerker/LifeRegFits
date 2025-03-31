%macro LifeRegFits(data = data, list = list, censors = censors);
   %do i = 1 %to %sysfunc(countw(&list.)); 
       %let k = %scan(&list., &i.);
       
		proc lifereg order=data data =&data;
		class treatment; 
			model stop*status(&censors.) = treatment number size/distribution=&k.;
		ods output FitStatistics = &k.;

		data &k.;
		set &k.;
		if (Criterion ne '-2 Log Likelihood') and (Criterion ne 'AIC (smaller is better)') then delete;run;
			proc transpose data = &k. out = &k. name = Distribution;
		id Criterion; 
		run;

		run;
   %end;

%mend;

