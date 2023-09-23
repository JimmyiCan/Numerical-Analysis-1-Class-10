R = readtable('ref_spectra.csv');
R = R{:,:};
M = readtable('unknown_mixture_spectrum.csv');
M = M{:,:};
sR = R(:,2:4);
sM = M(:,2);
c = inv(sR'*sR)*sR'*sM;
disp(c)