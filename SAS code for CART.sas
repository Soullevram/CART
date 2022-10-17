data goat_data;
label BWT = 'Body Weight';
label HTW = 'Height at Wither';
label BL = 'Body Length';
label HG = 'Heart Girth';
label FAL = 'Face Length';
label HDW = 'Head Width';
label RL = 'Rump Length';
label RH = 'Rump Height';
label SW = 'Shoulder Width';
label RW = 'Rump Width';

input BREED $ SEX $	AGE BL HG HDW FAL HTW RL SW RW RH BWT;
datalines;
/*data available on request*/
;

/****to compute descriptive statistics for the entire data****/
proc means data=goat_data N Mean Std StdErr CV;
   class BREED;
   var BL HG HDW FAL HTW RL SW RW RH BWT;
run;

/***to get correlation coefficient***/
proc corr data=goat_data;
   var BL HG HDW FAL HTW RL SW RW RH BWT;
run;

/***to construct regression tree***/

proc hpsplit data=goat_data cvmodelfit seed=123;

   model BWT = BL HG HDW FAL HTW RL SW RW RH;
   prune none;
run;
quit;

/******use zoomedtree option******/
/*****nodes are produced in base 62: 0-9, A-Z, a-z******/
proc hpsplit data=goat_data cvmodelfit cvcc seed=123 plots = zoomedtree(nodes = ("0") depth = 3 fracprec = 4 predictorprec = 4 linkstyle = orthogonal linkwidth = constant) nodes;
   model BWT = BL HG HDW FAL HTW RL SW RW RH;
   output out=bwregout;
   run;

/****to compute descriptive statistics for each node****/ 
proc means data = bwregout;
	class _node_;
	var BWT;
	output out = bwmeans;
run;

/****to compute percentiles****/ 

proc univariate data = bwregout;
	class _node_;
	var BWT;
	output out = bwuni p1 = p1 p5 = p5 p10 = p10;
run;

proc sort data = bwuni;
by p10;
run;

proc print data = bwuni;
run;

/*to convert the node table output to base 10*/
data tree.bwregout;
set tree.bwregout;
retain possdigs '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
	do power=0 to 100 while(62**power<=_NODE_); end;
	left=_NODE_;
	length node $10;
	node='0';
	i=0;
	do power=power-1 to 0 by -1;
		i+1;
		r=int(left/(62**power));
		substr(node,i,1)=substr(possdigs,r+1,1);
		left=left-(62**power)*r;
	end;
run;

-----------FOR SAHEL GOATS--------------------
data goat_data;
label BWT = 'Body Weight';
label HTW = 'Height at Wither';
label BL = 'Body Length';
label HG = 'Heart Girth';
label FAL = 'Face Length';
label HDW = 'Head Width';
label RL = 'Rump Length';
label RH = 'Rump Height';
label SW = 'Shoulder Width';
label RW = 'Rump Width';

input BREED $ SEX $	AGE BL HG HDW FAL HTW RL SW RW RH BWT;
datalines;
/*data available on request*/
;

/****to compute descriptive statistics for the entire data****/
proc means data=goat_data N Mean Std StdErr CV;
   class BREED;
   var BL HG HDW FAL HTW RL SW RW RH BWT;
run;

/***to get correlation coefficient***/
proc corr data=goat_data;
   var BL HG HDW FAL HTW RL SW RW RH BWT;
run;

/***to construct regression tree***/

proc hpsplit data=goat_data cvmodelfit seed=123;
   model BWT = BL HG HDW FAL HTW RL SW RW RH;
run;


/******use zoomedtree option******/
/*****nodes are produced in base 62: 0-9, A-Z, a-z******/
proc hpsplit data=goat_data cvmodelfit cvcc seed=123 plots = zoomedtree(nodes = ("0" "7" "B" "P") depth = 3 fracprec = 4 predictorprec = 4 linkstyle = orthogonal linkwidth = constant) nodes;
   model BWT = BL HG HDW FAL HTW RL SW RW RH;
   output out=bwregout;
   run;

/****to compute descriptive statistics for each node****/ 
proc means data = bwregout;
	class _node_;
	var BWT;
	output out = bwmeans;
run;

/****to compute percentiles****/ 

proc univariate data = bwregout;
	class _node_;
	var BWT;
	output out = bwuni p1 = p1 p5 = p5 p10 = p10;
run;

proc sort data = bwuni;
by p10;
run;

proc print data = bwuni;
run;


--------------FOR WAD GOATS--------------------
data goat_data;
label BWT = 'Body Weight';
label HTW = 'Height at Wither';
label BL = 'Body Length';
label HG = 'Heart Girth';
label FAL = 'Face Length';
label HDW = 'Head Width';
label RL = 'Rump Length';
label RH = 'Rump Height';
label SW = 'Shoulder Width';
label RW = 'Rump Width';

input BREED $ SEX $	AGE BL HG HDW FAL HTW RL SW RW RH BWT;
datalines;
/*data available on request*/
;
/****to compute descriptive statistics for the entire data****/
proc means data=goat_data N Mean Std StdErr CV;
   class BREED;
   var BL HG HDW FAL HTW RL SW RW RH BWT;
run;

/***to get correlation coefficient***/
proc corr data=goat_data;
   var BL HG HDW FAL HTW RL SW RW RH BWT;
run;

/***to construct regression tree***/

proc hpsplit data=goat_data cvmodelfit seed=123;

   model BWT = BL HG HDW FAL HTW RL SW RW RH;
   prune none;
run;
quit;

/******use zoomedtree option******/
/*****nodes are produced in base 62: 0-9, A-Z, a-z******/
proc hpsplit data=goat_data cvmodelfit cvcc seed=123 plots = zoomedtree(nodes = ("0" "7" "A" "B" "C" "F" "N" "o" "t" "q" "y") depth = 3 fracprec = 4 predictorprec = 4 linkstyle = orthogonal linkwidth = constant) nodes;
   model BWT = BL HG HDW FAL HTW RL SW RW RH;
   output out=bwregout;
   run;

/****to compute descriptive statistics for each node****/ 
proc means data = bwregout;
	class _node_;
	var BWT;
	output out = bwmeans;
run;

/****to compute percentiles****/ 

proc univariate data = bwregout;
	class _node_;
	var BWT;
	output out = bwuni p1 = p1 p5 = p5 p10 = p10;
run;

proc sort data = bwuni;
by p10;
run;

proc print data = bwuni;
run;





