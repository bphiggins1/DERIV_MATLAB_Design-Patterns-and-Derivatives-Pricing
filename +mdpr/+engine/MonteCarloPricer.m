classdef MonteCarloPricer < mdpr.engine.Pricer
    %MONTECARLOPRICER Option pricer using Monte Carlo simulation
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        RandSeed
        PathCount
        Spot
        Volatility
        RiskFreeRate = 0;
    end
    
    methods
        function obj = MonteCarloPricer(config)
            obj = obj@mdpr.engine.Pricer(config);
        end
        
        function price = getPrice(obj, option)
            % Calculate price using risk neutral expected value of payoff 
            expiry = option.getExpiry();
            variance = obj.Volatility^2*expiry;
            rootVar = sqrt(variance);
            itoCorrection = -variance/2;
            % Present spot price growing at risk free rate taking into
            % account Ito correction.
            movedSpot = obj.Spot*exp(obj.RiskFreeRate*expiry + ...
                itoCorrection);
            % Monte Carlo simulation of final values
            s = rng(obj.RandSeed);
            spotVals = bsxfun(@times, movedSpot(:)', ...
                exp(randn(obj.PathCount,1)*rootVar));
            rng(s);
            payOffVals = option.getValue(spotVals);
            price = exp(-obj.RiskFreeRate*expiry)*mean(payOffVals,1)';
        end
    end
    
end

