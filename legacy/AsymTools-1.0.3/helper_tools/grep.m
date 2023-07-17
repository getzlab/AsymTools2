function [res,resi]=grep(reg_exp,strs,res_is_idx)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.



% GISTIC software version 2.0
% Copyright (c) 2011 Gad Getz, Rameen Beroukhim, Craig Mermel, 
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, 
% Gordon Saksena, Michael O'Kelly, Barbara Tabak
% All Rights Reserved.

if ischar(strs)
  strs=cellstr(strs);
end

resi=find(~cellfun('isempty',cat(1,regexp(strs,reg_exp))));
res=strs(resi);

if nargout==0
  disp(catn(res));
end

if exist('res_is_idx','var') && res_is_idx
  [res,resi]=exchange_vars(res,resi);
end
