classdef Put < mdpr.payoff.PayOff
    %PUT Put payoff
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Strike
    end
    
    methods
        function obj = Put(config)
            obj = obj@mdpr.payoff.PayOff(config);
        end
        
        function val = getValue(obj, spot)
            val = max(obj.Strike - spot, 0);
        end
    end
    
end

