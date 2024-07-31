x=-1:.01:5;
for i=1:length(x)
    if 0<=x(i) && x(i)<1
        y(i)=x(i)^3/6;
    elseif 1<=x(i) && x(i)<2
        y(i)=(-3*x(i)^3+12*x(i)^2-12*x(i)+4)/6;
    elseif 2<=x(i) && x(i)<3
        y(i)=(3*x(i)^3-24*x(i)^2+60*x(i)-44)/6;
    elseif 3<=x(i) && x(i)<4
        y(i)=(4-x(i))^3/6;
    else
        y(i)=0;
    end
end

x=-1:.01:5;
for i=1:length(x)
    if 0<=x(i) && x(i)<1/2
        y1(i)=x(i)^2/2;
    elseif 1/2<=x(i) && x(i)<1
        y1(i)=(-9*x(i)^2+24*x(i)-12)/6;
    elseif 1<=x(i) && x(i)<3/2
        y1(i)=(9*x(i)-48*x(i)+60)/6;
    elseif 3/2<=x(i) && x(i)<2
        y1(i)=-(4-x(i))^2/2;
    else
        y1(i)=0;
    end
end