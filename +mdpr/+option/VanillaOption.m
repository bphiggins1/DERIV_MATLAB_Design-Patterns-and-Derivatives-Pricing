classdef VanillaOption < mdepin.Bean
    %VANILLAOPTION Vanilla Option
        
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Expiry
        PayOff
    end
    
    methods
        function obj = VanillaOption(config)
            obj = obj@mdepin.Bean(config);
        end
        
        function expiry = getExpiry(obj)
            expiry = obj.Expiry;
        end
        
        function payoff = getValue(obj, spot)
            payoff = obj.PayOff.getValue(spot);
        end
            
    end
    
end

