classdef Call < mdpr.payoff.PayOff
    %CALL Call payoff
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Strike
    end
    
    methods
        function obj = Call(config)
            obj = obj@mdpr.payoff.PayOff(config);
        end
        
        function val = getValue(obj, spot)
            val = max(spot - obj.Strike, 0);
        end
    end
    
end

