function [dev,res] = interpret_print_filename(filename)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


tmp = regexp(filename, '(\.[^\.]*)$', 'tokens');
if isempty(tmp) || isempty(tmp{1})
  error('Please specify output file with extension .png, .jpg, .eps, .pdf, or .tif'); ...
end

ext = tmp{1}{1}(2:end);
if strcmpi(ext,'jpeg') || strcmpi(ext,'jpg')
  dev = 'jpeg';
  res = 300;
elseif strcmpi(ext,'eps')
  dev = 'epsc';
  res = 180;
elseif strcmpi(ext,'tif') || strcmpi(ext,'tiff')
  dev = 'tiff';
  res = 180;
elseif strcmpi(ext,'png')
  dev = 'png';
  res = 180;
elseif strcmpi(ext,'pdf')
  dev = 'pdf';
  res = 1200;
else
  error('Unknown output format: please specify .png, .jpg, .eps, .pdf, or .tif');
end

end
