function y = hist2d_sparse(x1,x2,l1,u1,l2,u2),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.



if l1<1|l2<1,
   shift = abs(min(l1,l2))+1;
   x1=x1+shift;x2=x2+shift;l1=l1+shift;l2=l2+shift;
   u1=u1+shift;u2=u2+shift;
end
x1(x1<1|isnan(x1)) = u1+1;
x2(x2<1|isnan(x2)) = u2+1;

%if ~all(isint((x1))&isint(x2)),
%   error('Error. First two inputs must contain only integers');
%end


S = sparse(x1,x2,ones(size(x1)));
S((end+1):u1,:) = 0;
S(:,(end+1):u2) = 0;
y = full(S(l1:u1,l2:u2));



