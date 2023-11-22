% Load problem3.mat to have access to variables abd_sig1 and mhb_ahead
load('problem3.mat');

% The sampling rates are 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
dur=20;
t = linspace(0,dur,dur*FS);

% Estimate the time lag using cross correlation with the 'xcorr' function
% Fit a spline to the cross correlation using 'spline' function, and then find the delay with maximum correlation using 'fnmin'
% NOTE: to use minimization function for maximization, please invert the objective function!
[r,lags] = xcorr(abd_sig1, mhb_ahead);
var=spline(lags,-r);
[minval,d]=fnmin(var); 

% Shift the chest ECG mhb_ahead back in time d samples
% Use linear interpolation with extrapolation with the function 'interp1'
N=length(mhb_ahead);
ind=(1:N);
mhb = interp1(ind(:),mhb_ahead,ind(:)- d,'linear','extrap');

% Estimate c2 from abd_sig1 and mhb
abd_sig1_transp = transpose(abd_sig1);
mhb_transp= transpose(mhb);
c2_projection = ( abd_sig1_transp * mhb ) / ( mhb_transp * mhb );
c2_pinv = pinv(mhb) * abd_sig1;
c2 = mhb \ abd_sig1; 

% Calculate the fetal ECG by cancelling out the scaled mother's ECG using projection based estimation coefficient
fetus = abd_sig1 - (c2 .* mhb);