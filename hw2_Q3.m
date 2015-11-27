clear all;
close all;
load O.mat

O_50 = O(1:50);
O_all = O(1:100);

m2_50 = sum(O_50(:,1));
m2_all = sum(O_all(:,1));
m1_50 = 50 - m2_50; 
m1_all = 100 - m2_all; 

figure();
a = 0.1;
b = 0.1;
X = 0:0.001:1;
y1 = betapdf(X, a, b);
y2 = betapdf(X, a +  m1_50, b + m2_50);
y3 = betapdf(X, a + m1_all, b + m2_all);
plot(X, y1, 'rx', X, y2, 'bx', X, y3, 'gx');
legend('Prior','Posterior 50 data','Posterior all data');
axis([0 1 0 30]); 
