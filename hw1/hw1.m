cd /home/jakob/Chalmers/MachLearnTDA231/hw1/
!synclient HorizTwoFingerScroll=0
addpath ~/Script/matlab2tikz/src/
clear all
clc
%% 2.1
data = load('dataset1.mat');
x = [ data.x(:,1) data.x(:,2)];
n = size(x,1);

[mu sigma] = sge(x);
% sampl = mvnrnd(mu,sigma^2*eye(2),1000);

% Calculate fraction of points outside radius i*sigma
frac = zeros(3,1);
str = {'Dataset1','\mu'};
fracstr = 'Fraction of points outside r = ';
k = 3; % Number of circles, (radius = standarddeviation*i)
for i=1:k
    frac(i,1) = sum(sum((x-mu).^2,2) >= i*sigma)/n;
    str{i+2} = strcat(fracstr,num2str(i*sigma),' : ',num2str(frac(i,1))) ;
end



figure(1)
clf
hold on
plot(x(:,1),x(:,2),'.')
drawCircle(mu,sigma,k)
axis equal
legend(str)

