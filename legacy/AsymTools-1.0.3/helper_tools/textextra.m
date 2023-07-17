function h = textextra(x,y,txt,varargin)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


vargs = varargin;
[vargs txtcolor] = extract_from_arglist(vargs,'color');
[vargs txtsize] = extract_from_arglist(vargs,'fontsize');

h = text(x,y,txt,vargs{:});

if ~isempty(txtcolor)
  if size(txtcolor,1)==1, txtcolor = repmat(txtcolor,length(h),1); end
  if size(txtcolor,1)~=length(h), error('color has wrong number of rows: expected %d',length(h)); end
  if size(txtcolor,2)~=3, error('color should have three columns'); end
  for i=1:length(h)
    set(h(i),'color',txtcolor(i,:));
  end
end

if ~isempty(txtsize)
  if length(txtsize)==1, txtsize = repmat(txtsize,length(h),1); end
  if length(txtsize)~=length(h), error('fontsize has wrong number of entries: expected %d',length(h)); end
  for i=1:length(h)
    set(h(i),'fontsize',txtsize(i));
  end
end

if nargout==0, clear h, end
