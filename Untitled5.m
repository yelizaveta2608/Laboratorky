%% 1. �������� ������

clc, clear
close all

[t,rain,temp]=getweatherdatayr('http://www.yr.no/sted/Ukraina/Kiev/Kiev/varsel.xml');


% % --- ��� ���������� ���������
% load([pwd,'\t.mat'])
% load([pwd,'\temp.mat'])
% load([pwd,'\rain.mat'])
% % ------
% 
 % ---- 2. ����������� �� ��������� ����� ---

Temp_now=[temp(1,1); {datestr(t(1,1))}];
X=['���',Temp_now(2,1),' �����������(C): ',Temp_now(1,1)];
disp(X)


% % ----- 3. ������������ ������ ---
hold on
figure(1)
plot(t,temp,'r'),
plot(t,rain,'g')
xlabel('����')
ylabel('��������')
title('������ ����������� �� �����')
datetick('x','dd')

...

axis tight

legend({'Temperature','Opady'},'Location','NorthEast')

hold off

% ----- 4. ���������� ����������� � ������� ------

CorMas=[temp(1,:);rain(1,:)];
C=corrcoef(CorMas');

disp('����������� ���������:')
disp(C)


figure(2)
imagesc(C)
title('���������')
ylabel('�����')
xlabel('�����������')


if C(1,2)&&C(2,1)==1
    
    disp('�������� ���')
   
end
% ----- 5. �������������� ������ ------

temperature=temp';
rain_t=rain';

for i=1:length(t)
DATE(i)={datestr(t(i))}; % �� ����� ������ ����������� �������� � ���������� �������, ���� 15:00-18:00, ������� ������ � ������ ������� ������� ����� �������� ����������� �� 15:00 �� 18:00, ������ � ������ ����������� �� 18:00-20:00.
end

% � ���� Matlab �� ������������ ������� table, ������� ������ �����������
% ����� �����

A(1,1)={'Date'};
A(1,2)={'temperature'};
A(1,3)={'rain'};
for i=1:length(t)
    A(i+1,1)={datestr(t(1,i))};
    A(i+1,2)={temp(i)};
    A(i+1,3)={rain(i)}
end
disp(A)
% A=table(temperature,rain_t,...
%     
 
% ----- 6. ������ ������������ ������ ������ ������������� ��� ����������� ��������� -----

S_temp=1/length(temp)*sqrt(std(temp));
S_rain=1/length(rain)*sqrt(std(rain));
mean_temp=mean(temp);
mean_rain=mean(rain);
t_tab=abs(mean_temp-mean_rain)/sqrt((S_temp^2/length(temp))*(S_rain^2/length(rain)));

disp('ʳ������ �������� � �����:')
disp(length(temp))
disp('��������� ���������� ��������� �� L=0,95:')
disp(t_tab)


v_temp_min=min(temp);
v_temp_max=max(temp);

v_rain_min=min(rain);
v_rain_max=max(rain);


fprintf('������� �������� ��� �����������:%4.2d -%4.2d\n',v_temp_min,v_temp_max)
fprintf('������� �������� ��� �����:%4.2d -%4.2d\n',v_rain_min,v_rain_max)
