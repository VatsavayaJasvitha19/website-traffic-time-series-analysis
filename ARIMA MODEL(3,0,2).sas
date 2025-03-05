/*
 *
 * Task code generated by SAS Studio 3.8 
 *
 * Generated on '3/2/25, 3:33 AM' 
 * Generated by 'gui24002' 
 * Generated on server 'CTX-VDA-MSB-B02.GROVE.AD.UCONN.EDU' 
 * Generated on SAS platform 'X64_SRV19 WIN' 
 * Generated on SAS version '9.04.01M7P08052020' 
 * Generated on browser 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko' 
 * Generated on web client 'http://localhost:56156/main?locale=en_US&zone=GMT-05%253A00&sutoken=%257B78F29F2C-35F4-48A5-A778-498879A038B5%257D' 
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc sort data=WORK.TSPREP out=Work.preProcessedData;
	by Date;
run;

proc arima data=Work.preProcessedData plots
     (only)=(series(corr) residual(corr normal) ) out=work.out;
	identify var='Page.Loads'n outcov=work.outcov;
	estimate p=(1 2 3) q=(1 2) method=ML outest=work.outest outstat=work.outstat 
		outmodel=work.outmodel;
	forecast lead=12 back=0 alpha=0.05 id=Date interval=week;
	outlier;
	run;
quit;

proc delete data=Work.preProcessedData;
run;