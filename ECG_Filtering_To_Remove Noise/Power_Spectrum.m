% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 = load('ecg_signal_1.dat');

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 = load('ecg_signal_2.dat');

% Compute ECG 1 power spectrum
X_omega=fft(ecg1);
X_omega_conj=conj(X_omega);
N_fft1=length(ecg1);
P_ecg1 = (1/N_fft1)*X_omega.*X_omega_conj;

% Compute ECG 2 power spectrum
X_omega2=fft(ecg2);
X_omega2_conj=conj(X_omega2);
N_fft2=length(ecg2);
P_ecg2 = (1/N_fft2)*X_omega2.*X_omega2_conj;

% Compute power spectrum frequency bins from 0 Hz to the Nyquist frequency
% For ECG 1
f1 = linspace(0,FS/2,(N_fft1/2)+1);
% ...and for ECG 2
f2 = linspace(0,FS/2,(N_fft2/2)+1);
