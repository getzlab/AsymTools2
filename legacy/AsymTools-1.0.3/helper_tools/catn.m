function st=catn(s,dlm)

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

if ~exist('dlm','var')
  dlm=9;
end

if iscell(s)
  s=strvcat(s);
end
  
% st=sprintf('%d\t%s\n',(1:size(s,1)),s');
st=[num2str((1:size(s,1))') repmat(dlm,size(s,1),1) s];
