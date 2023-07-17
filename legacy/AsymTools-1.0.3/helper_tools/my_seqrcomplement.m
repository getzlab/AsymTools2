function rc = my_seqrcomplement(seq)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if isempty(seq)
  rc = seq;
else
  if ischar(seq)
    rc = tr(fliplr(seq),'ACGTacgt','TGCAtgca');
  else
    for a=1:size(seq,1)
      for b=1:size(seq,2)
        for c=1:size(seq,3)
          for d=1:size(seq,4)
            for e=1:size(seq,5)
              rc{a,b,c,d,e} = tr(fliplr(seq{a,b,c,d,e}),'ACGTacgt','TGCAtgca');
            end,end,end,end,end
  end
end
