%% ----- Topic 1 Lab Filtering ----- %%
% Data : 2021/2/9
% Group : UCAS
% Author : Yanchen Bi
%% ----- Generate a signal containing the sum of three sinusoids ----- %%
clear all;
% Sampling frequency (Hz)
sampleFreq = 1024;
% Time interval
deltaTime = 1 / sampleFreq;
% Number of samples
nsample = 2048;
% Time
timeEnd = (nsample-1) / sampleFreq;
time = 0:deltaTime:timeEnd;

% Signal s1
A1 = 10;
f01 = 100;
phi01 = 0;
% Generate s1
s1 = GenQCSigSin(time,A1,[f01,phi01]);

% Signal s2
A2 = 5;
f02 = 200;
phi02 = pi/6;
% Generate s2
s2 = GenQCSigSin(time,A2,[f02,phi02]);

% Signal s3
A3 = 5.;
f03 = 300;
phi03 = pi/4;
% Generate s3
s3 = GenQCSigSin(time,A2,[f02,phi02]);
% The total signal
s = s1 + s2 + s3;

%% ----- Design filter ----- %%
% Design low pass filter
% Filter order
filterOrder = 30;
% Frequency constraints  0 < wn < 1
wn = 0.9;
b = fir1(filterOrder,wn);
% Apply filter
filterSig = fftfilt(b,s);

%% ----- Plot the results ----- %%
figure;
subplot(211);
plot(time,s,'Marker','.','MarkerSize',2);
subplot(212);
plot(time,filterSig,'Marker','.','MarkerSize',2);

%% ----- Plot the spectrogram ------ %%
% Set window length in sec
winLen = 0.2;
% Set coverlap length in sec
overlap = 0.1;
% Convert to integer number of samples
winLenSample = floor(winLen*sampleFreq);
overlapSample = floor(overlap*sampleFreq);
% Build-in function spectrogram of original signal 
[S,F,T] = spectrogram(s,winLenSample,overlapSample,[],5*sampleFreq);
% Build-in function spectrogram of filtering signal 
[Sf,Ff,Tf] = spectrogram(filterSig,winLenSample,overlapSample,[],5*sampleFreq);

% Plot the spectrogram
figure;
subplot(211);
imagesc(T,F,abs(S));
axis xy;    % Make y axis in right position
xlabel('Time(sec)');
ylabel('Frequency(Hz)');
colorbar;
subplot(212);
imagesc(Tf,Ff,abs(Sf));
axis xy;    % Make y axis in right position
xlabel('Time(sec)');
ylabel('Frequency(Hz)');
colorbar;