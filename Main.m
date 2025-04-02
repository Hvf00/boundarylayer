clc; clear all;
%air specifications
pr=1;
ro=1.184;
cp=1007 ;
alpha=2.141*10^-5;
nu=1.48*10^-5;
u_inf=input('Enter free stream velocity:');
T0=input('Enter wall temperature:');
T_inf=input('Enter free stream temperature:');
%call function
[eta1,f] = shooting_1;
[eta2,tetha]=shooting_2(eta1,f,pr);
utplot(eta1,f,eta2,tetha);
uprofile(eta1,f,u_inf,nu);
[u,v]=streaml(eta1,f,nu,u_inf);
Heatl(eta1,eta2,tetha,f,ro,cp,u_inf,nu,T0,T_inf,pr);