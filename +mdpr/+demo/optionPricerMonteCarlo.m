function optionPricerMonteCarlo(  )
%OPTIONPRICERMONTECARLO Demo of option pricing using Monte Carlo simulation

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

spotVals = linspace(80,120,1e3);
pricerParams.Spot = spotVals;
pricerParams.Volatility = 0.1;
pricer = iCreatePricer(pricerParams);

optionParams.Strike = 100;
optionParams.Expiry = 0.25; % 3 months
option = iCreateOption(optionParams);

price = pricer.getPrice(option);

subplot(1,2,1)
plot(spotVals, price);
title('Option Price (MC)')
subplot(1,2,2)
ds = spotVals(2)-spotVals(1);
plot(spotVals(2:end), diff(price)/ds)
title('Option Delta (MC)')
end

function pricer = iCreatePricer(params)
ctx.Pricer = struct(...
    'class', 'mdpr.engine.MonteCarloPricer', ...
    'RandSeed', 1234, ...
    'PathCount', 1e3, ...
    'Spot', params.Spot, ...
    'Volatility', params.Volatility );
pricer = mdepin.createApplication( ctx, 'Pricer');
end

function option = iCreateOption(params)
ctx.Option = struct(...
    'class', 'mdpr.option.VanillaOption', ...
    'PayOff', 'CallPayOff', ...
    'Expiry', params.Expiry);
ctx.CallPayOff = struct(...
    'class', 'mdpr.payoff.Call', ...
    'Strike', params.Strike);
option = mdepin.createApplication( ctx, 'Option');
end

