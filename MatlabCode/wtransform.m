clc; clear
% A=imread('tr','tif');
% A=A(:,:,2);
% C1=double(A);
% clear A

AA=imread('clock','tif');
%C1=double(AA);
%  AA=imread('mra2','png');
C1=double(AA(:,:,1));
[m n]=size(C1);
%y=[1 4 6 4 1]./16;
y=[0.125 0.375 0.375 .125];
for i=1:m
    At(i,:)=conv(C1(i,:),y,'same');
end
for j=1:n
    AN(:,j)=conv(At(:,j),y','same');
end
C1=AN;
for i=1:m
    At(i,:)=conv(C1(i,:),y,'same');
end
for j=1:n
    AN(:,j)=conv(At(:,j),y','same');
end
clear At
%z=[1 -29 147 -303 303 -147 29 -1]./30;
z=[-2 2];
for i=1:m
    Wt1(i,:)=conv(AN(i,:),z,'same');
end
for j=1:n
    W1(:,j)=conv(Wt1(:,j),y,'same');
end
for i=1:m
    Wt2(i,:)=conv(AN(i,:),y,'same');
end
for j=1:n
    W2(:,j)=conv(Wt2(:,j),z,'same');
end
for i=1:m
    Dt(i,:)=conv(AN(i,:),z,'same');
end
for j=1:n
    D(:,j)=conv(Dt(:,j),z,'same');
end



%__________________________________________________________________________

AF=angle(complex(W2,W1));

v=cell(1,2);
v{1}=cos(AF);
v{2}=sin(AF);
[mf,nf]=size(AF);
for i=1:mf
    for j=1:nf
        Alpha=AF(i,j);
        if 0<Alpha && Alpha<=(pi/8)
            a=1;b=0;
        elseif (7*pi/8)<Alpha && Alpha<=(-7*pi/8)
            a=-1;b=0;
        elseif (-7*pi/8)<Alpha && Alpha<=(-5*pi/8)
            a=-1/sqrt(2);b=-1/sqrt(2);
        elseif (-5*pi/8)<Alpha && Alpha<=(-3*pi/8)
            a=0;b=-1;
        elseif (-3*pi/8)<Alpha && Alpha<=(-pi/8)
            a=1/sqrt(2);b=-1/sqrt(2);
        elseif (-pi/8)<Alpha && Alpha<=(pi/8)
            a=1;b=0;
        elseif (pi/8)<Alpha && Alpha<=(3*pi/8)
            a=1/sqrt(2);b=1/sqrt(2);
        elseif (3*pi/8)<Alpha && Alpha<=(5*pi/8)
            a=0;b=1;
        elseif (5*pi/8)<Alpha && Alpha<=(7*pi/8)
            a=-1/sqrt(2); b=1/sqrt(2);
        end
        vd{1}(i,j)=a;
        vd{2}(i,j)=b;
    end
end

[E_Val,E_Vec]=BigLambda(AN,W1,W2,D,y,z);

%__________________________________________________________________________



Mf=sqrt((v{2}.*W1).^2+(v{1}.*W2).^2);
Yf=~(Mf>15);
%imagesc(Yf);colormap(gray); axis off
MA=sqrt(W1.^2+W2.^2); 
Y=~(MA>8);
figure(2);imagesc(Y); colormap(gray); axis off
h = xlabel('');     pos = get(h,'Position'); delete(h)
h=title('(b)','FontSize',18); set(h,'Position',pos);
[r,c]=size(W1);
for i=1:r
    for j=1:c
        MFd(i,j)=sqrt((E_Vec{i,j}(1)*W1(i,j))^2+(E_Vec{i,j}(2)*W2(i,j))^2);
    end
end
Yd=~(MFd>8);
figure(3);imagesc(Yd);colormap(gray);axis off
h = xlabel('');     pos = get(h,'Position'); delete(h)
h=title('(c)','FontSize',18); set(h,'Position',pos);
figure(4); imagesc(C1); colormap(gray); axis off
h = xlabel('');     pos = get(h,'Position'); delete(h)
h=title('(a)','FontSize',18); set(h,'Position',pos);