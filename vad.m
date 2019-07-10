function [n1,n2,z,e] = vad(x)
%% vad
%% ��ʱ����
x = x/max(abs(x)); % ���ȹ�һ��
FrameLength = 200;
FrameIncrease = 100;
X = enframe(x,FrameLength,FrameIncrease); % ��֡
[m,n] = size(X); % ��ȡ֡��
z = zero_crossing(X); % �����ʱ������
e = sum(abs(enframe(filter([1 -0.95], 1, x), FrameLength, FrameIncrease)), 2); % ������ͼ����ʱ������Ԥ����ȥ���ڴ������Ӱ�죬���������ĸ�Ƶ�ֱ���
% figure;subplot(211);plot(z);title('zero crossing');subplot(212);plot(e);title('energy')
%% ����ֵ����
e1 = min(10,max(e)/5);
e2 = min(2,max(e)/10);
z2 = 6;
%% �˵���
start_point = 0;
end_point = 0;
count1 = 0; % ��¼Ǳ�������γ���
count2 = 0; % ��¼����������ľ�������
state = 0;
for i = 1:m
    switch(state)
        case {0,1}
            if e(i)>e1
                start_point = i-count1;
                state = 2;
                count2 = 0;
                count1 = 0;
            elseif e(i)>e2||z(i)>z2
                state = 1;
                count1 = count1 + 1;
            else
                state = 0;
                count1 = 0;
            end
        case 2
            if e(i)>e2||z(i)>z2
                state = 2;
            else
                count2 = count2 + 1;
                if count2 < 10
                    state = 2;
                elseif i - start_point < 10
                    state = 0;
                    count1 = 0;
                else
                    end_point = i-10;
                    state = 3;
                end
            end
        case 3
            break;
    end
end
n1 = (start_point-1)*FrameIncrease;
n2 = (end_point-1)*FrameIncrease;
end