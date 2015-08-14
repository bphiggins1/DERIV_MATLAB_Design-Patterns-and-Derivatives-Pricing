%% MATLAB Derivatives Pricing
% A MATLAB version of derivatives pricing based on [C++ Design Patterns and
% Derivatives Pricing](http://www.markjoshi.com/design/) by Mark Joshi.
%
% This implementation makes use of [Dependency
% Injection](https://github.com/mattmcd/mdepin) for constructing the
% pricing application.
%
% The [Chebfun](http://www.chebfun.org/) library is used for pricing some
% vanilla options as an example of how different pricing engines may be
% plugged in to the application.
%
% This script shows a demonstration of pricing a European Call option using
% two methods: 
%
% 1) Monte Carlo simulation to determine the discounted expected value of
% the option at expiry under the risk neutral measure.
%
% 2) Solving the Black Scholes Partial Differential Equation (PDE) using
% Chebfuns and operator exponential.
%
% The main purpose of this script is not the option pricing itself but
% rather to demonstrate the flexibility of the Object Oriented Programming
% (OOP) architecture.

%% Install dependencies if necessary
status = mdpr.install(pwd);

%% Derivatives Pricing using Monte Carlo
%   Option price is calculated using 1000 simulated spot prices at expiry.
%   Note that the option delta (derivative of the option price w.r.t. spot
%   price) is noisy due to the low number of paths.
disp('Pricing using Monte Carlo')
figure;
mdpr.demo.optionPricerMonteCarlo()

%% Derivatives Pricing using Chebfun
%   Option price is calculated using Chebfun.
%   Note that the option delta is now smooth since the Chebfun allows us to
%   calculate a machine precision derivative.
disp('Pricing using Chebfun')
figure;
mdpr.demo.optionPricerChebfun()

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details