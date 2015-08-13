classdef EuropeanCallTest < matlab.unittest.TestCase
    %EUROPEANCALLTEST Create pricing application and price European Call
    
    % Copyright Matt McDonnell, 2015
    % See LICENSE file for license details
    
    properties
        Pricer
        Option
        Strike
        Spot
        Expiry
        Volatility
        ExpectedPrice
    end
    
    methods (TestMethodSetup)
        function setUp(testCase)
            % Example 3.1 Concepts and Practice of Mathematical Finance
            testCase.Spot = 100;
            testCase.Volatility = 0.1;
            testCase.Strike = 100;
            testCase.Expiry = 0.25; % 3 Months
            testCase.ExpectedPrice = 1.995;
        end
    end
        
    methods (Test)
        function testCreateMonteCarloPricerAndPriceCall(testCase)
            testCase.createMonteCarloPricer();
            testCase.createEuropeanCall();
            price = testCase.calculatePrice();
            testCase.assertLessThan(abs(price-testCase.ExpectedPrice), 0.2);
        end
        
        function testCreateChebfunPricerAndPriceCall(testCase)
            testCase.createChebfunPricer();
            testCase.createEuropeanCall();
            price = testCase.calculatePrice();
            testCase.assertLessThan(abs(price-testCase.ExpectedPrice), 0.2);
        end
    end
       
    methods
        function createMonteCarloPricer(obj)
            ctx.Pricer = struct(...
                'class', 'mdpr.engine.MonteCarloPricer', ...
                'RandSeed', 1234, ...
                'PathCount', 1e3, ...
                'Spot', obj.Spot, ...
                'Volatility', obj.Volatility );
            obj.Pricer = mdepin.createApplication( ctx, 'Pricer');
        end
        
        function createChebfunPricer(obj)
            ctx.Pricer = struct(...
                'class', 'mdpr.engine.ChebfunPricer', ...
                'Spot', obj.Spot, ...
                'Volatility', obj.Volatility, ...
                'LBC', 0, ...
                'RBC', @(v) diff(v)-1, ...
                'Domain', [0 200]);
            obj.Pricer = mdepin.createApplication( ctx, 'Pricer');
        end        
        
        function createEuropeanCall(obj)
            ctx.Option = struct(...
                'class', 'mdpr.option.VanillaOption', ...
                'PayOff', 'CallPayOff', 'Expiry', obj.Expiry);
            ctx.CallPayOff = struct(...
                'class', 'mdpr.payoff.Call', ...
                'Strike', obj.Strike);
            obj.Option = mdepin.createApplication( ctx, 'Option');
        end
        
        function price = calculatePrice(obj)
            price = obj.Pricer.getPrice(obj.Option);
        end
        
    end
end

