classdef ChebfunPricer < mdpr.engine.Pricer
    %CHEBFUNPRICER Option pricer using Chebfun
    %
    %   Black-Scholes PDE using operator exponential
    %   see: http://www.chebfun.org/examples/pde/BSExponential.html
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Spot
        Volatility
        RiskFreeRate = 0;
        LBC = 0 % Left boundary condition
        RBC = 0 % Right boundary condition
        Domain = [0 1000] % Domain of spot price
    end
    
    methods
        function obj = ChebfunPricer(config)
            obj = obj@mdpr.engine.Pricer(config);
        end
        
        function price = getPrice(obj, option)
            % Calculate price using PDE
            % Define domain of spot prices we solve PDE over
            spot = chebfun('s', obj.Domain);
            
            expiry = option.getExpiry();
            sigma = obj.Volatility.^2;
            r = obj.RiskFreeRate;
            
            % PDE for diff(v,t) = A(v,s) in stock price s
            A = chebop(@(s,v) -sigma/2*s.^2.*diff(v,2) ...
                -r.*s.*diff(v,1) + r.*v, obj.Domain);
            % Boundary conditions
            A.lbc = obj.LBC;
            A.rbc = obj.RBC;
            
            % Remove nonhomogeneous boundary conditions by finding a
            % particular solution
            u = A\0;
            % Set homogeneous boundary conditions
            A.lbc = 0;
            A.rbc = 0;
            
            vT = option.getValue(spot); % Value of option at expiry
            wT = vT - u; % Adjusted variable with homogeneous boundary conditions
            
            % Solve for (T-t) = expiry by propagating from T
            v = expm(A, -expiry, wT) + u;
            price = v(obj.Spot);
        end
    end
    
end

