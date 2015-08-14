function status = install( installDir )
%MDPR.INSTALL Install dependencies
%   Checks if dependencies are installed and if not installs under
%   specified directory.
%
%   USAGE:
%       status = mdpr.install( installDir )
%
%   INPUT:
%       installDir - full path to parent directory for installed packages
%
%   OUTPUT:
%       status - 0 if install is successful

% Copyright Matt McDonnell, 2015
% See LICENSE file for license details

baseURL = 'https://github.com/';
mdepinURL = [baseURL, 'mattmcd/mdepin/archive/master.zip'];
chebfunURL = [baseURL, 'chebfun/chebfun/archive/master.zip'];

mdepinInstalled = iCheck('mdepin.Bean');
if ~mdepinInstalled
    iInstall(installDir, 'mdepin', mdepinURL);
    mdepinInstalled = iCheck('mdepin.Bean');
end

chebfunInstalled = iCheck('chebfun');
if ~chebfunInstalled
    iInstall(installDir, 'chebfun', chebfunURL);
    chebfunInstalled = iCheck('chebfun');
end

status = mdepinInstalled && chebfunInstalled;

end

function isInstalled = iCheck(className)
isInstalled = exist(className, 'class');
end

function iInstall(installDir, installName, url)
fprintf('Installing depdendency %s\n', installName);
fprintf('  Retrieving zip file %s\n', url);
unzip(url)
destDir = fullfile(installDir, installName);
fprintf('  Moving unzipped files to %s\n', destDir)
movefile(sprintf('%s-master', installName), destDir);
fprintf('  Adding to path %s\n\n', destDir);
addpath(destDir);
try
    savepath()
catch ME
    warning('path:nosave', 'Unable to save path: %s', ME.message);
end
end