% Load the data from the file problem3.mat
data = load('problem3.mat');
flow1 = data.flow1;
flow2 = data.flow2;
flow3 = data.flow3;
spiro_resampled = data.spiro_resampled;
belt=data.belt;


% Nx1 vectors flow1, flow2, and flow3 contain the model predictions
% Nx1 vector spiro_resampled contains the resampled reference spirometer data

% Compute the correlation coefficient for the model 1, between flow1 and spiro_resampled
x1=flow1;
y=spiro_resampled;
x_=mean(flow1);
y_=mean(y);
N=length(x1);
up=(sum(x1.*y)-N*x_.*y_)^2;
down=((sum(x1.^2)-N*x_.^2)*(sum(y.^2)-N*y_.^2));
corr1 =sqrt(up/down); 

% Compute the correlation coefficient for the model 2, between flow2 and spiro_resampled
x2=flow2;
x2_=mean(flow2);
N=length(x2);
up2=(sum(x2.*y)-N*x2_.*y_)^2;
down2=((sum(x2.^2)-N*x2_.^2)*(sum(y.^2)-N*y_.^2));
corr2 =sqrt(up2/down2); 

% Compute the correlation coefficient for the model 3, between flow3 and spiro_resampled
x3=flow3;
x3_=mean(flow3);
N=length(x3);
up3=(sum(x3.*y)-N*x3_.*y_)^2;
down3=((sum(x3.^2)-N*x3_.^2)*(sum(y.^2)-N*y_.^2));
corr3 =sqrt(up3/down3);  

% Compute the RMSE for the model 1, between flow1 and spiro_resampled
SS_err1=sum((y-x1).^2);
MSE1=SS_err1/N;
rmse1 = sqrt(MSE1); 

% Compute the RMSE for the model 2, between flow2 and spiro_resampled
SS_err2=sum((y-x2).^2);
MSE2=SS_err2/N;
rmse2 = sqrt(MSE2); 

% Compute the RMSE for the model 3, between flow3 and spiro_resampled
SS_err3=sum((y-x3).^2);
MSE3=SS_err3/N;
rmse3 = sqrt(MSE3);