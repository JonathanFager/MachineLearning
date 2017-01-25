function drawCircle(mu,sigma,k)
ang=0:0.01:2*pi; 
plot(mu(1),mu(2),'xr')
for i = 1:k
xp=i*sigma*cos(ang);
yp=i*sigma*sin(ang);
plot(mu(1)+xp,mu(2)+yp);
end