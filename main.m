close all; clc; clear
%% ��ȡһ�������ļ����ж˵���
[x,Fs] = audioread('hi.mp3');
[n1,n2,z,e]=vad(x); %�õ������˵�
%% ���������ż��
t=(0:length(x)-1)/Fs;
noise=[0.03*cos(2*pi*200*t)]';  %����Ϊ500kHz�������ź�
x_n=x+noise;
subplot(221);
plot(x);title('Original speech')
subplot(222)
plot(x_n);title('Speech with noise')
[n3,n4,z_n,e_n]=vad(x_n); %�õ������˵�
subplot(223)
plot(z_n);title('Zero crossing rate')
subplot(224)
plot(e_n);title('Speech power')
%% ��ȡ���������ļ��Ĳ���
% path = 'G:\�����źŴ������ļ�\project';
path = 'D:\Users\yl2523\Desktop\dtw';
dir = [path,'.\speech\'];
% dir = 'D:\Users\yl2523\Desktop\dtw\speech\';
files = ls(dir);
mfcc_coe = zeros(12,length(files));
for i = 3:size(files,1)
    speech = audioread([dir,files(i,:)]);
    [start_point,end_point]=vad(speech);
    mfcc_coe(:,i) = mfcc(speech(start_point:end_point));
end
mfcc_coe = mfcc_coe(1:12,3:7);
%% ʶ������
test_mfcc_coe = mfcc(2*x_n(n3:n4));
distance = zeros(5,1);
for i = 1:5
    distance(i) = dtw(mfcc_coe(:,i),test_mfcc_coe);
end

min_distance = min(distance);
result = find(distance==min_distance);
switch result
    case 1
        fprintf('The speech is a.mp3')
    case 2
        fprintf('The speech is hi.mp3')
    case 3
        fprintf('The speech is mom.mp3')
    case 4
        fprintf('The speech is o.mp3')
    case 5
        fprintf('The speech is u.mp3')
end