clear all;
close all;
clc;
load O.mat

O_50 = O(1:50);
O_all = O(1:100);

m2_50 = sum(O_50(:,1));
m2_all = sum(O_all(:,1));
m1_50 = 50 - m2_50; 
m1_all = 100 - m2_all; 

n = 1000;
mu = zeros(n, 1);
p = zeros(n, 1);
mu_50 = zeros(n, 1);
p_50 = zeros(n, 1);
mu_all = zeros(n, 1);
p_all = zeros(n, 1);

figure();
for i = 1:n
    a = 0.1;
    b = 0.1;
    mu(i, 1) = betarnd(a, b);
    p(i, 1) = (gamma(a + b) / (gamma(a) * gamma(b))) * (mu(i, 1) .^ (a - 1)) * ((1 - mu(i, 1)) .^ (b-1));
   
    a_m1_50 = a + m1_50;
    b_m2_50 = b + m2_50;
    mu_50(i, 1) = betarnd(a_m1_50, b_m2_50);
    p_50(i, 1) = (gamma(a_m1_50 + b_m2_50) / ((gamma(a_m1_50) * gamma(b_m2_50)))) * (mu_50(i, 1) .^ (a_m1_50 - 1)) * ((1 - mu_50(i, 1)) .^ (b_m2_50 - 1));

    a_m1_all = a + m1_all;
    b_m2_all = b + m2_all;
    mu_all(i, 1) = betarnd(a_m1_all, b_m2_all);
    p_all(i, 1) =  (gamma(a_m1_all + b_m2_all) / ((gamma(a_m1_all) * gamma(b_m2_all)))) * (mu_all(i, 1) .^ (a_m1_all - 1)) * ((1 - mu_all(i, 1)) .^ (b_m2_all - 1));

    plot(mu, p, 'rx', mu_50, p_50, 'bx', mu_all, p_all, 'gx');
    axis([0 1 0 30]); 
    legend('Prior','Posterior 50 data','Posterior all data');
    grid on; 
end
