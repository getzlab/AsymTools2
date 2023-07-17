function [ratio sd] = ratio_and_sd(n,N)

% AsymTools software version 1.0
% Copyright (c) 2016 Nicholas Haradhvala, Paz Polak,
% Petar Stojanov, Kyle Covington, Eve Shinbrot,
% Julian Hess, Esther Rheinbay, Jaegil Kim, Yosef Maruvka
% Lior Braunstein, Atanas Kamburov, Philip Hanawalt,
% David Wheeler, Amnon Koren, Michael Lawrence, Gad Getz
% All Rights Reserved.
%
% See the accompanying file LICENSE.txt for licensing details.


ratio = n./N;

sn = n .^ 0.5;
sN = N .^ 0.5;

sd = ratio .* ((sn./n).^2+(sN./N).^2).^0.5;


