clc
clear
syms a b c d;
%Theoretical probability

%rates:
l= 0.4;
m1= 1/2;
m2=1/2.5;
m3= (1/3.5);

%transition matrix:
P=[-1*l l 0 0
m1 -1*(m1+l) l 0
0 m2+m1 -1*(m2+m1+l) l
0 0 m2+m1+m3 -1*(m2+m1+m3)];

%[pi1 pi2 pi3 pi4]*transition matrix= [pi1 pi2 pi3 pi4]= [III, BII, BBI, BBB] 
%sum of pis =1, solving the equations:
lhs= [0 0 0 0];
eq= a+b+c+d==1;
[III, BII, BBI, BBB]=solve([[a b c d]*P== lhs, eq], [a b c d])

arrivalButBusy= BBB%probability of arrival while the 3 servers are busy

%Practical Probability 
%means(avera time):
AverageArrivalTime = 1/l;
AverageDepartureTime1 = 1/ m1;
AverageDepartureTime2 =1/m2;
AverageDepartureTime3=1/m3;

state = 1; %the state where I present
T=[0 0 0 0]; %collects the time that i spend in every state
Arrival=0;
DepartureFirst=0;
DepartureSecond=0;
DepartureThird=0;

%TimeOfEvents=[0,0,0,0];
ArrivOrDep= false; %determines wether the next event is either an arrival if true or departure if false

%loop determines in which state I am and the next event that
%happens(arrival or departure(1/2/3)) and based on it i decide where i go 
for i=1:10000 % the more we repeat the better approximation probabilities are
    ArrivOrDep=false;
   
    if ( state ==1) %I am in state 1, waiting for an arrival
        Arrival= exprnd(AverageArrivalTime);% time bet arrivals is exponentially distributed
        T(1)= T(1) + Arrival; %increment the time I spend in state 1 by the exponential time until the next arrival
        ArrivOrDep= true; %it is an arrival
    elseif(state==2)%I am in state 2, waiting for an arrival or departure from first server
        Arrival= exprnd(AverageArrivalTime);
        DepartureFirst= exprnd(AverageDepartureTime1);
        T(2)=T(2)+ min([Arrival, DepartureFirst]);% increment time I spend in state 2 by whatever rvrnt happens first(arrival or dep from server 1)
        if(Arrival == min([Arrival, DepartureFirst]))%determine if the event was an arrival or a departure
            ArrivOrDep=true;
        end
    elseif(state==3)
        Arrival= exprnd(AverageArrivalTime);
        DepartureFirst= exprnd(AverageDepartureTime1);
        DepartureSecond= exprnd(AverageDepartureTime2);
        T(3)=T(3)+min([Arrival, DepartureFirst, DepartureSecond]);
        if(Arrival == min([Arrival, DepartureFirst, DepartureSecond]))
            ArrivOrDep=true;
        end
    else
        Arrival= exprnd(AverageArrivalTime);
        DepartureFirst= exprnd(AverageDepartureTime1);
        DepartureSecond= exprnd(AverageDepartureTime2);
        DepartureThird= exprnd(AverageDepartureTime3);
        T(4)=T(4)+min([Arrival, DepartureFirst, DepartureSecond, DepartureThird]);
        if(Arrival == min([Arrival, DepartureFirst, DepartureSecond, DepartureThird]))
            ArrivOrDep=true;
        end
    end

    if (ArrivOrDep) % if the event was an arrival go to next state else if departure go to the state before
        if(state ~=4) %if servers are all busy, discard the arrivals
        state= state+1;
        end
    else
        if(state ~=1)% no departure happens if all servers are Idle
        state=state-1;
        end
    end
end
%t=T
%now T has the time i spent in each state
probabilities= T/sum(T) % get the steady state probability 
s= sum(probabilities)%probability is 1 indeed