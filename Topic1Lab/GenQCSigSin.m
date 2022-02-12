function sigsin = GenQCSigSin(dataX,snr,qcCoefs)
% Generate a quadratic chirp Sinusoidal signal
% S = GenQCSigSin(X,SNR,C)
% Generates a quadratic chirp signal S. 
% X is the vector of time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S.
% C is the vector of three coefficients [a1, a2] that parametrize the phase of the signal:
% phase = a1*t+a2. 

% Yanchen Bi, Feb 2022
phaseVec = 2*pi * qcCoefs(1) .* dataX + qcCoefs(2);
sigVec = sin(phaseVec);
sigVec = snr * sigVec / norm(sigVec);
sigsin = sigVec;
end

