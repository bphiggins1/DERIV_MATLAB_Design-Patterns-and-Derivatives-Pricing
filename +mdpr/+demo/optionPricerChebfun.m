function optionPricerChebfun(  )
%OPTIONPRICERCHEBFUN Demo of option pricing using a Chebfun pricer
%   see: http://www.chebfun.org/examples/pde/BSExponential.html
    
% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

spotVals = linspace(80,120,1e3);
pricerParams.Spot = spotVals;
pricerParams.Volatility = 0.1;
pricer = iCreatePricer(pricerParams);

optionParams.Strike = 100;
optionParams.Expiry = 0.25; % 3 months
option = iCreateOption(optionParams);

% Use the getPrice method to return an array of doubles for option price
% price = pricer.getPrice(option);

% Return the option price as a Chebfun
priceFun = pricer.getPriceChebfun(option);

% subplot(2,2,[1 3])
% plot(spotVals, price);

subplot(1,2,1)
plot(priceFun, [80, 120])
title('Option Price')
subplot(1,2,2)
plot(diff(priceFun), [80, 120])
title('Option Delta')

end

function pricer = iCreatePricer(params)
ctx.Pricer = struct(...
    'class', 'mdpr.engine.ChebfunPricer', ...
    'Spot', params.Spot, ...
    'Volatility', params.Volatility, ...
    'Domain', [0 200]);
pricer = mdepin.createApplication( ctx, 'Pricer');
end

function option = iCreateOption(params)
ctx.Option = struct(...
    'class', 'mdpr.option.BoundaryConditionDecorator', ...
    'InnerOption', 'VanillaCall', ...
    'LBC', 0, ...
    'RBC', @(v) diff(v)-1);
ctx.VanillaCall = struct(...
    'class', 'mdpr.option.VanillaOption', ...
    'PayOff', 'CallPayOff', ...
    'Expiry', params.Expiry);
ctx.CallPayOff = struct(...
    'class', 'mdpr.payoff.Call', ...
    'Strike', params.Strike);
option = mdepin.createApplication( ctx, 'Option');
end

