function [hys] = hysteresisThresholding(image,upper,lower,conn)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
img = image;
t1 = upper;
t2 = lower;
if t1>t2    % swap values if t1>t2 
	tmp=t1;
	t1=t2; 
	t2=tmp;
end
minv=min(img(:));                % min image intensity value
maxv=max(img(:));                % max image intensity value
t1v=t1*(maxv-minv)+minv;
t2v=t2*(maxv-minv)+minv;

%% trinarisation
tri=zeros(size(img));
tri(img>=t1v)=1;
tri(img>=t2v)=2;

%% hysteresis
abovet1=img>t1v;                                     % points above lower threshold
seed_indices=sub2ind(size(abovet1),find(img>t2v));   % indices of points above upper threshold
hys=imfill(~abovet1,seed_indices,conn);              % obtain all connected regions in abovet1 that include points with values above t2
hys=hys & abovet1;
end

