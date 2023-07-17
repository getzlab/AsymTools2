function C2 = convert_chr(C1)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

%
% convert_chr(chromosome_list)
%
% converts text chromosome identifiers to numbers 1-24 (X=23, Y=24)
%
% Mike Lawrence 2008-05-01

ct = 24;

% CONVERSION

if isnumeric(C1)
  % do nothing
  C2=C1;

else

  if ~iscell(C1), C1={C1}; end
  if size(C1,1)==1, transpose_flag=true; C1=C1'; else transpose_flag=false; end

  [ccs cci ccj] = unique(C1);
  ccs_orig = ccs;

    % legacy behavior
    ccs = regexprep(ccs, '^([Cc][Hh][Rr])', '');
    ccs = regexprep(ccs, '^(Mt|MT)$','0');
    ccs = regexprep(ccs, '^[Mm]$', '0');
    
    idx = grep('^[XxYy]$',ccs,1);
    if ~isempty(idx)
      ccs = regexprep(ccs, '^[Xx]$', num2str(ct-1));
      ccs = regexprep(ccs, '^[Yy]$', num2str(ct));
    end
    ccs_num = str2double(ccs);


  C2 = ccs_num(ccj);
  if transpose_flag, C2=C2'; end

end

