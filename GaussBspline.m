clear
hold off
x=-1:.001:3;
for i=1:length(x)
    if x(i)>=0 && x(i)<1
        y(i)=x(i);
    elseif x(i)>=1 && x(i)<2
        y(i)=2-x(i);
    else
        y(i)=0;
    end
end
plot(x,y,'LineWidth',1.5); 
y1=sqrt(6/(pi*2))*exp(-6*(x-1).^2/2);
hold on
plot(x,y1,'r:','LineWidth',1.8);
xlabel('n=1(piecewise linear)');
legend('B-spline','Gaussian');


clear
x=-2:.001:6;
for i=1:length(x)
    if x(i)>=0 && x(i)<1
        y(i)=x(i)^3/6;
    elseif x(i)>=1 && x(i)<2
        y(i)=(-3*x(i)^3+12*x(i)^2-12*x(i)+4)/6;
    elseif x(i)>=2 && x(i)<3
        y(i)=(3*x(i)^3-24*x(i)^2+60*x(i)-44)/6;
    elseif x(i)>=3 && x(i)<4
        y(i)=(4-x(i))^3/6;
    else
        y(i)=0;
    end
end
figure(2);
plot(x,y,'LineWidth',1.5);
y1=sqrt(6/(pi*4))*exp(-6*(x-2).^2/4);
hold on
plot(x,y1,'r:','LineWidth',1.8);
xlabel('n=3(cubic)');
legend('B-spline','Gaussian');

clear x
x=-3:.001:3;
figure(3);
y2=sqrt(6/(pi*4))*exp(-6*(x).^2/4);
y3=-6*x.*y2;
plot(x,y2,'LineWidth',1.5);
figure(4); plot(x,y3,'LineWidth',1.5);

        