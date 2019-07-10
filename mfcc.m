function mfcc_coe = mfcc(x)
%预加重
x = filter([1 -0.95],1,x);
%分帧
X = enframe(x,hamming(200),100);
[m,n] = size(X);
bank=melbankm(24,200,44100,0,0.5,'m');
% Inputs:
%       p   number of filters in v_filterbank or the filter spacing in k-mel/bark/erb [ceil(4.6*log10(fs))]
%		n   length of fft
%		fs  sample rate in Hz
%		fl  low end of the lowest filter as a fraction of fs [default = 0]
%		fh  high end of highest filter as a fraction of fs [default = 0.5]
%		'm' = hamming shaped filters in mel/erb/bark domain
bank = full(bank);
bank = bank/max(bank(:)); %归一化mel滤波器组系数
w = 1+6*sin(pi*[1:12]./12);
w = w/max(w);%归一化倒谱提升窗口
% DCT系数,12*24
for k=1:12
  n=0:23;
  dct_coe(k,:)=cos((2*n+1)*k*pi/(2*24));
end
for i=1:m
    signal_frame = X(i,:);
    f = abs(fft(signal_frame));
    f = f.^2;
    c = dct_coe * log(bank*f(1:101)').*w';
end
mfcc_coe = c;

    