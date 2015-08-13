classdef Pricer < mdepin.Bean
    %PRICER Option pricer abstract base class    
        
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    methods
        function obj = Pricer(config)
            obj = obj@mdepin.Bean(config);
        end
    end
    
    methods (Abstract)
        price = getPrice(option)
    end
    
end

