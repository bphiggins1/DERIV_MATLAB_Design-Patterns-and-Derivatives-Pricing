classdef BoundaryConditionDecorator < mdpr.option.VanillaOption
    %BOUNDARYCONDITIONDECORATOR Decorate option with boundary conditions
    %   ChebfunPricer needs boundary conditions to solve PDE
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details 
    
    properties
        % Boundary conditions
        LBC = 0
        RBC = 0
        InnerOption
    end
    
    methods
        function obj = BoundaryConditionDecorator(config)
            obj = obj@mdpr.option.VanillaOption(config);
        end
        
        function expiry = getExpiry(obj)
            expiry = obj.InnerOption.getExpiry;
        end
        
        function payoff = getValue(obj, spot)
            payoff = obj.InnerOption.getValue(spot);
        end
    end
    
end

