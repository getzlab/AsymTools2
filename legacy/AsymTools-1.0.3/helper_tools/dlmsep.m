function res=dlmsep(s,d)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.

% res=dlmsep(s,d)
%    spearates a string to a cell array of strings at 
%    the appearance of a delimeter d
%
% 
% Gaddy Getz
% Cancer Genomics
% The Broad Institute
% gadgetz@broad.mit.edu
%

% GISTIC software version 2.0
% Copyright (c) 2011 Gad Getz, Rameen Beroukhim, Craig Mermel, 
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, 
% Gordon Saksena, Michael O'Kelly, Barbara Tabak
% All Rights Reserved.


if nargin==1
  d=9; % tab
end

%pos=findstr(d,s);
pos=find(ismember(s,d));
if ~isempty(pos)
  pos=[ 0 pos length(s)+1];
  for i=1:(length(pos)-1)
    res{i}=s((pos(i)+1):(pos(i+1)-1));
  end
else
  res{1}=s;
end

