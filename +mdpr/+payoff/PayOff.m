classdef PayOff < mdepin.Bean
    %PAYOFF Abstract PayOff base class
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    
    methods
        function obj = PayOff(config)
            obj = obj@mdepin.Bean(config);
        end
    end
    
    methods (Abstract)
        val = getValue(obj, spot) 
    end
    
end

