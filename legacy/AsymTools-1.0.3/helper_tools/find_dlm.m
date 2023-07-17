function d=find_dlm(fname,dlm)

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

if ~exist('dlm','var') || isempty(dlm)
  dlm=[ char(9) ',|'];
end

f=fopen(fname,'r');
l=fgetl(f);
for i=1:length(dlm)
  h(i)=length(find(l==dlm(i)));
end
[hm,hi]=max(h);
d=dlm(hi);
