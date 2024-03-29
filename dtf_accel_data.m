% t = linspace(1,829,829)
N = length(az);
Fs = 40;
f_double = linspace(-Fs/2, Fs/2 - Fs/N, N) + Fs/(2*N)*mod(N, 2);
half_length = floor(length(f_double)/2);
f = f_double(length(f_double)-half_length + 1:end);
AZ_double = fft(az);
AZ = AZ_double(1:half_length);
%plot(f,abs(AZ))
plot(f_double,abs(fftshift(AZ_double)))
xlabel("Frequency (Hz)")
ylabel("Magnitude")

[sorted_AZ,ind] = sort(AZ, 'descend');
max_ind = ind(2);
f(max_ind)