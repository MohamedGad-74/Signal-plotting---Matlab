clc,clear;
%%%%%%%%%%%%%%%%%%%%% Signal Generation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start=input('Start= ');
End=input('End= ');
sfreq=input('frequency= ' );
Bp=input('number of breakpoints= ');
t1=linspace(start,End,(End-start)*sfreq);
x1=[];
t=[];
position(1)=start;
position(Bp+2)=End;

if Bp > 0
	for i = 2:Bp+1
	position(i)=input('position= ');
	end
	t1=linspace(position(1),position(2),(position(2)-position(1))*sfreq);
end
for i = 1:Bp+1
	t1=[t1 t];
	fprintf('choose D for Dc signal \n choose R for Ramp signal \n choose G for General order polynomial \n chooseE for Exponential signal \n choose S for Sinusoidal sin signal \n choose C for Sinusoidal cosin signal \n');
	Req_signal=input('The required signal is: ');
	if Req_signal=='D'
		t=[];
	elseif i==1
		t= t1;
	end
	if Req_signal=='D'
		Amp=input('enter the amplitude of the signal= ');
		x=Amp*ones(1,(position(i+1)-position(i))*sfreq);
	elseif Req_signal=='R'
		int= input('enter the intercept of the signal= ');
		slope= input ('enter the slope of the signal= ');
		x= (slope * t) + int ;
	elseif Req_signal=='G'
		intX= input('enter the intercept X of the signal= ');
		intY= input('enter the intercept Y of the signal= ');
		Amp=input('enter the amplitude of the signal= ');
		power = input('enter the power of the signal= ');
		x= Amp * ((t-intX) .^ power) + intY ;
	elseif Req_signal=='E'
		Amp=input('enter the amplitude of the signal= ');
		exponent=input('enter the exponent of the signal= ');
		x= Amp* exp(exponent * t);
	elseif Req_signal=='S'
		Amp=input('enter the amplitude of the signal= ');
		frequency=input('enter the frequency of the signal= ');
		phase=input ('enter the phase of the signal= ');
		x= Amp * sin(frequency *t + phase);
	elseif Req_signal=='C'
		Amp=input('enter the amplitude of the signal= ');
		frequency=input('enter the frequency of the signal= ');
		phase=input('enter the phase of the signal= ');x= Amp * cos(frequency *t + phase);
	else
		fprintf('wrong key') ;
	end
	x1=[x1 x];
	if i==Bp+1
		break;
	else
		t=linspace(position(i+1),position(i+2),(position(i+2)-position(i+1))*sfreq);
	end
end
figure;
plot(t1,x1);
%%%%%%%%%%%%%%%%%%%%%%%% Signal Modification %%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_operations=input('num of operations you want to perform = ');
for i = 1 : num_of_operations
	operation = input('choose an operation to be performed \n 1 for Amp Scaling \n 2 for time reversal \n 3 forTime shift \n 4 for Expansion \n 5 for compression \n 6 for nothing \n operation is : ');
	if operation ==1
		scale=input('scale= ');
		x2=scale*x1;
		t2=t1;
	elseif operation ==2
		t2=-t1;
		x2=x1;
	elseif operation ==3
		shift=input('shift value = ');
		x2=x1;
		t2=t1+shift;
	elseif operation ==4 ;expand=input('expansion value = ');
		t2=expand*t1;
		x2=(x1);
	elseif operation ==5;
		compress=input('compression value = ' );
		t2=t1/compress;
		x2=(x1);
	else
		continue;
	end;
	t1=t2;
	x1=x2;
end
figure;plot(t2,x2);
