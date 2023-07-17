function [vout value] = extract_from_arglist(vin,key)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


vout = vin;
value = [];

for i=1:length(vin)-1
  if ischar(vin{i}) && strcmpi(vin{i},key)
    value = vin{i+1};
    vout(i:i+1) = [];
    return
  end
end

