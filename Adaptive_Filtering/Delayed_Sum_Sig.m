% Load problem2.mat to have access to variables abd_sig1 and mhb_ahead
load('problem2.mat');

% The sampling rates are 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
dur=20;
t =linspace(0,dur,dur*FS); 

% Estimate the time lag using cross correlation
% (Calculate cross correlation using the xcorr function and then
% use the max function to find the lag giving maximal correlation)
[r,lags] = xcorr(abd_sig1,mhb_ahead);
[maxval,d] = max(abs(r));
d = lags(d);

% Shift the chest ECG mhb_ahead back in time d samples padding with nearest value
%mhb = [mhb_ahead(d+1:end), mhb_ahead(1:d)];
mhb = circshift(mhb_ahead, d);
mhb(1:d) = mhb_ahead(1);

% Estimate c2 from abd_sig1 and mhb

abd_sig1_transp = transpose(abd_sig1);
mhb_transp = transpose(mhb);
c2_proj = ( abd_sig1_transp * mhb ) / ( mhb_transp * mhb );
c2_pinv = pinv(mhb) * abd_sig1;
c2 = mhb \ abd_sig1;


% Calculate the fetal ECG by cancelling out the scaled mother's ECG using projection based estimation coefficient
fetus = abd_sig1 - (c2 .* mhb);