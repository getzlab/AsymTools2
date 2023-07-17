%Given a handle ha for an errorbar plot, resizes the error bars to new width
function set_error_bar_width(ha,width),

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


hb = get(ha,'children');  
if length(hb)==0, return; end %This function does not work matlab 2014b and on
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
% xleft and xright contain the indices of the left and right
%  endpoints of the horizontal lines
xleft = temp; xright = temp+1; 
% Calculate the amount the endpoints need to change
current_width = Xdata(xright) - Xdata(xleft);
width_change = (width-current_width)/2;
%Modify the enpoints
Xdata(xleft) = Xdata(xleft) - width_change;
Xdata(xright) = Xdata(xright) + width_change;
set(hb(2),'Xdata',Xdata);



