function draw_ellipse(x,y,xr,yr,color),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


if nargin<5,
	color = 'b';
end

if length(x)>1,
	hold on;
	if size(color,1)==1,
		color = repmat(color,length(x),1);
	end
	for ii = 1:length(x),
		draw_ellipse(x(ii),y(ii),xr(ii),yr(ii),color(ii));
	end
	hold off;
	return;
end


t=-pi:0.01:pi;
plot(x+xr*cos(t),y+yr*sin(t),color);






