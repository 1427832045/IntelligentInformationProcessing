clear all;close all;clc;
load data; % ��ȡ����
Data = data;
% ?100���������й�?����? min-max��׼������[0,1]����
% ȱ���ǵ����µ����ݼ���ʱ��max��min���ܷ����仯����Ҫ���¶�?
for i=1:100 
	for j=1:3
		Data(i,j)=(data(i,j)-min(data(:,j)))/(max(data(:,j))-min(data(:,j)));
	end
end
D1=Data(1:80,:);
D2=Data(81:100,:);
k=20; % ѵ������80�����������Լ���20����?
for i=1:20
	temp=D2(i,1:3)
	for j=1:80 % ����ÿ������������ѵ�������ľ�������
		distance(j)=norm(temp-D1(j,1:3));
	end
	[distance1,index]=sort(distance); %��������
	In=index(1:k); % ͳ����Χ20��ѵ��������������
	l1=length(find(D1(In,4)==1));
	l2=length(find(D1(In,4)==2));
	l3=length(find(D1(In,4)==3));
	[maxl,class(i)]=max([l1,l2,l3]); % class(i)��ÿ��������������20����?
end
class
ratio=length(find((class'-D2(:,4))==0))/20 % ͳ����ȷ����%90