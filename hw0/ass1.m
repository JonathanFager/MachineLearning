cd /home/jakob/Chalmers/MachLearnTDA231/hw0/
!synclient HorizTwoFingerScroll=0
addpath ~/Script/matlab2tikz/src/
clear all
clc

%% 2.1
% Parameters of the distr.
mu = [1;1];
Sigma = [0.1 -0.05; -0.05 0.2]
n = 1000; % Sample size
% Only need to calculate the inverse once.
S = inv(Sigma);

% Generate sample
X  = mvnrnd(mu,Sigma,n);

% Ezloop requires two inputs so we split here
x = X(:,1);
y= X(:,2);

% Preallocate
f3 = zeros(length(X),1);


% Obv. faster to use arrayfun but since the sample size is so small we
% allow ourselves the luxury of laziness and use a for loop.
for i = 1:length(X)
f3(i) = Gauss2D(x(i),y(i),3);
end

% Divide index according to limit f(x,3)>0
ind = find(f3>0);
indC = setdiff(1:length(X),ind);

figure(2)
clf
hold on
col = {'r','g','c'}
for r = 1:3
   %Generate contour plots
   h(r) = ezplot(@(x,y)Gauss2D(x,y,r),[-1 3]);
   h(r).LineColor = col{r}
end

% Plot points in- and outside level curve stated above.
plot(x(indC),y(indC),'.')
plot(x(ind),y(ind),'k.')
legend('f(x,1) = 0','f(x,2) = 0','f(x,3) = 0','f(x,1) < 0','f(x,1) > 0')
str = strcat('Number of points outside f(x,3) = ',num2str(length(ind)) );
title(str)

%% 2.2
% Data from webpage.
X = load('dataset0.txt');
% Transform data to values between 0 and 1. 
Y = (X-min(X))./(max(X)-min(X));

% Actually simpler to use formal definition of cov to compute. Need to use
% bsxfun since mismatch of matrix dims. (Want row wise mult) 
covXY = bsxfun(@minus,X,mean(X))'*bsxfun(@minus,Y,mean(Y))/(size(X,1)-1);
% Standard matlab function for corr.
corrXY = corr(X,Y);

% Plot
figure(3)
clf
imagesc(covXY)
colormap jet
title('Cov(X)')
axis equal
figure(4)
imagesc(corrXY)
colormap jet
title('Corr(X)')
axis equal
%%
% Generate data for tikz plotting in latex
clc
figMat = zeros(144,3);
for i= 1:length(covXY)
    for j=1:length(covXY)
        figMat(12*(i-1)+j,:) = [j i covXY(i,j)];
    end
    disp(figMat(12*(i-2)+j+1:12*(i-1)+j,:))
end
%%
corrYY = corr(Y,Y)
% Find the two features Y_i and Y_j with minimum correlation.
[rho indrows] = min(corrYY);
[rhoMin indcol] = min(rho)
indrow = indrows(indcol)
figure(3)
clf
plot(Y(:,indcol),Y(:,indrow),'.')
str = strcat('Lowest correlation between Y',num2str(indrow),' and Y',...
    num2str(indcol),', min(\rho) = ',num2str(rhoMin));
title(str)

