clc;
close all;
clear all;
load r2.mat

mu = [1; -1];
W0 = [1 0; 0 1]; % sigma = inv(lambda)
V0 = 1; % degree of freedom
dim = 2; % D
fig_num = 1;

for n = [10, 100, 500]    
    Wishart_map = 0;
    lambda_map = 0;
    mu_n = repmat(mu, 1, n); % fit r2(1:n, :)
    Wn = inv(inv(W0) + (r2(1:n, :)' - mu_n) * (r2(1:n, :) - mu_n'));
    Vn = V0 + n;
    
    for j = 1: 3500 % 2500, 3000
        lambda = wishrnd(Wn, Vn); % lambda is Wishart distribution with covariance matrix Sigma and with df degrees of freedom
        Wishart = det(lambda) ^ ((Vn - dim - 1) / 2) * exp((-1 / 2) * trace((inv(Wn)) * lambda)); % Wishart(lam, Wn, Vn) = P(lam|X)
        lambda1(1, j) = lambda(1, 1);
        lambda2(1, j) = lambda(1, 2);
        lambda3(1, j) = lambda(2, 1);
        lambda4(1, j) = lambda(2, 2);
        if (Wishart > Wishart_map)
            Wishart_map = Wishart;
            lambda_map = lambda;
        end
    end
    figure(fig_num);
    fig_num = fig_num + 1;
    subplot(2,2,1); hist(lambda1,1000) % Left Up
    subplot(2,2,2); hist(lambda2,1000) % Right Up
    subplot(2,2,3); hist(lambda3,1000) % Left Bot
    subplot(2,2,4); hist(lambda4,1000) % Right Bot
    axis([0 10 0 20]); 
    
    disp(n);
    disp(lambda_map);
end
