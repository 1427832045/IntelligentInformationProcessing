clear all;close all; clc;
% ��һ������
mul=[0,0]; % ��ֵ
S1=[.1 0;0 .1]; % Э����
data1=mvnrnd(mul, S1, 100); % ������˹�ֲ�����
% �ڶ�������
mu2=[1.25 1.25];
S2=[.1 0;0 .1];
data2=mvnrnd(mu2,S2,100);
% ����������
mu3=[-1.25;1.25]
S3=[.1 0;0 .1]
data3=mvnrnd(mu3,S3,100)
% ��ʾ����
plot(data1(:,1),data1(:, 2),'b+');
hold on;
plot(data2(:,1),data2(:,2),'r+');
plot(data3(:,1),data3(:,2),'g+');
grid on; % �ڻ�ͼ��ʱ���������
% �������ݺϳ�һ��������ŵ�������
data=[data1;data2;data3];
N=3; % ���þ�����Ŀk��ֵ
[m,n]=size(data); % 300x2����
pattern=zeros(m,n+1);
center=zeros(N,n); % ��ʼ���������� 3x2
pattern(:,1:n)=data(:,:);
for x=1:N
	center(x,:)=data(randi(300,1),:); % ��һ�����������������
end
while 1
	distance=zeros(1,N);
	num=zeros(1,N);
	new_center=zeros(N,n);
	for x=1:m
		for y=1:N 
			% ����ʹ�õ���ŷ�Ͼ���
			distance(y)=norm(data(x,:)-center(y,:)); % ����ÿ��������ÿ�������ĵľ��� 
		end
		% min���������ֵ�����ʽ 
		% min(A): ����һ������������ÿ����Сֵ
		% [Y, U]=min(A): ����������Y��U, Y������¼A��ÿ�е���Сֵ��U������¼ÿ����Сֵ���к�
		% min(A, dim): dimȡ1��2.dimȡ1ʱ���ú�����max(A)��ȫ��ͬ;dimΪ2ʱ�����������������
		% i��Ԫ����A����ĵ�i���ϵ���Сֵ
		[~,temp]=min(distance);
		pattern(x,n+1)=temp;
	end
	k=0;
	for y=1:N
		% ���������������ҵ����ڵ�y�������,�����¼��������
		for x=1:m
			if pattern(x,n+1)==y
				new_center(y,:)=new_center(y,:)+pattern(x,1:n)
				num(y)=num(y)+1 % �����y������������������������ֵ
			end
		end
		new_center(y,:)=new_center(y,:)/num(y);
		if norm(new_center(y,:)-center(y,:))<0.1
			k=k+1
		end
	end
	if k==N
		break;
	else
		center=new_center
	end
end
[m,n]=size(pattern) % m=300,n=3

% ��ʾ����������
figure;
hold on;
for i=1:m
	% ���ڲ�ͬ�����������ɲ�һ����r��b��g��ɫ��*״�����յĴ�����Ϊ��ɫԲȦ
	if pattern(i,n)==1
		plot(pattern(i,1),pattern(i,2),'r*');
		plot(center(1,1),center(1,2),'ko');
	elseif pattern(i,n)==2
		plot(pattern(i,1),pattern(i,2),'g*');
		plot(center(2,1),center(2,2),'ko');
	elseif pattern(i,n)==3
		plot(pattern(i,1),pattern(i,2),'b*');
		plot(center(3,1),center(3,2),'ko');
	end
end 
grid on;

