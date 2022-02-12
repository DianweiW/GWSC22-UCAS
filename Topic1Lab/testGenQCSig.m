%% ----- Topic 1 Lab Generate quadrapole chirp signals ----- %%
% Data : 2021/2/9
% Group : UCAS
% Author : Yanchen Bi
%% ----- Plot the quadratic chirp signals ----- %%
% Sinusoidal Signal
% Parameters
A = 5.;
f0 = 3.;
phi0 = 1.;
% Instantaneous frequency
timeEnd = 5.;
maxFreq = f0 * timeEnd;
% 5 times the (guessed) Nyquist frequency(2 * freqmax)
sampleFreq = 10 * maxFreq;
% Time interval
deltaTime = 1 / sampleFreq;
time = 0:deltaTime:timeEnd;
% Number of samples
nsample = length(time);
% Generate the signal
sigSin = GenQCSigSin(time,A,[f0,phi0]);
% Plot the Sinusoidal signal
figure;
plot(time,sigSin,'Marker','.','MarkerSize',24);

% Sine-Gaussian Signal
% Parameters
A = 15.;
t0 = 3.;
sigma = 0.2;
f0 = 2.;
phi0 = 1.;

% Instantaneous frequency
% timeend = 5;
% freqmax = f0 * timeend;
% samplefreq = 2 * freqmax;
% Time interval
% deltatime = 1 / samplefreq;
% time = 0:deltatime:timeend;
% Number of samples
% nsample = length(time);

% Generate the Sine-Gauss signal
sigSinGauss = GenQCSigSinGauss(time,A,[f0,phi0,sigma,t0]);
% Plot the signal
figure;
plot(time,sigSinGauss,'Marker','.','MarkerSize',24);

%% ----- FFT ----- %%
% Length of data
dataLen = time(end) - time(1);
% DFT sample
kNyq = floor(nsample/2) + 1;
% DFT frequency spacing
freqSpace = 1 / dataLen;
% Positive fourier frequencies 
posFreq = (0:(kNyq-1))*(freqSpace);
% FFT of Sinusoidal signal
fftSigSin = fft(sigSin);
% Discard negative frequencies
fftSigSin = fftSigSin(1:kNyq);

% FFT of sin-Gauss signal
fftSigSinGauss = fft(sigSinGauss);
% Discard negative frequencies
fftSigSin = fftSigSin(1:kNyq);
fftSigSinGauss = fftSigSinGauss(1:kNyq);
% Plot periodogram
figure;
plot(posFreq,abs(fftSigSin),'LineWidth',2);
figure;
plot(posFreq,abs(fftSigSinGauss),'LineWidth',2);

%% ----- Spectrogram ----- %%
% Set window length in sec
winLen = 0.02;
% Set coverlap length in sec
overlap = 0.01;
% Convert to integer number of samples
winLenSample = floor(winLen*sampleFreq);
overlapSample = floor(overlap*sampleFreq);
% Build-in function spectrogram
[S,F,T] = spectrogram(sigSin,winLenSample,overlapSample,[],2*sampleFreq);
% Plot the spectrogram
figure;
imagesc(T,F,abs(S));
axis xy;    % Make y axis in right position
xlabel('Time(sec)');
ylabel('Frequency(Hz)');
colorbar;
% view(-45,65);