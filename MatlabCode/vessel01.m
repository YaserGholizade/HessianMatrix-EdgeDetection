clear;
% A1=imread('lenna','tif');
% C1=double(A1);
% [m n]=size(C1);

A1=imread('tr','tif');
A1=A1(:,:,2);
C1=double(A1);
[m n]=size(C1);

h=[0.125 0.375 0.375 .125];
g=[-2 2];
for i=1:m
    Att(i,:)=conv(C1(i,:),h,'same');
end
for j=1:n
    A(:,j)=conv(Att(:,j),h,'same');
end
[m n]=size(A);
for i=1:m
    At(i,:)=conv(A(i,:),h,'same');
    Dt(i,:)=conv(A(i,:),g,'same');
end
[mt,nt]=size(At);
for j=1:nt
    AN(:,j)=conv(At(:,j),h,'same');
    Wy(:,j)=conv(At(:,j),g,'same');
    Wx(:,j)=conv(Dt(:,j),h,'same');
    Wd(:,j)=conv(Dt(:,j),g,'same');
end
% [r,c]=size(Wy);
% for i=1:r
%     for j=1:c
%         if Wy(i,j)==0 && Wx(i,j)==0
%             Af(i,j)=0;
%         else
%             Af(i,j)=atan(abs(Wy(i,j)./Wx(i,j)));
%         end
%     end
% end
Af=angle(complex(Wx,Wy));

v=cell(1,2);
v{1}=cos(Af);
v{2}=sin(Af);
[mf,nf]=size(Af);
for i=1:mf
    for j=1:nf
        Alpha=Af(i,j);
        if 0<Alpha && Alpha<=(pi/8)
            a=1;b=0;
        elseif (7*pi/8)<Alpha && Alpha<=(-7*pi/8)
            a=-1;b=0;
        elseif (-7*pi/8)<Alpha && Alpha<=(-5*pi/8)
            a=-1;b=-1;
        elseif (-5*pi/8)<Alpha && Alpha<=(-3*pi/8)
            a=0;b=-1;
        elseif (-3*pi/8)<Alpha && Alpha<=(-pi/8)
            a=1;b=-1;
        elseif (-pi/8)<Alpha && Alpha<=(pi/8)
            a=1;b=0;
        elseif (pi/8)<Alpha && Alpha<=(3*pi/8)
            a=1;b=1;
        elseif (3*pi/8)<Alpha && Alpha<=(5*pi/8)
            a=0;b=1;
        elseif (5*pi/8)<Alpha && Alpha<=(7*pi/8)
            a=-1; b=1;
        end
        vd{1}(i,j)=a;
        vd{2}(i,j)=b;
    end
end

[mx,nx]=size(Wx);
[my,ny]=size(Wy);
Wx1=[zeros(mx+2,1),[zeros(1,nx);Wx;zeros(1,nx)],zeros(mx+2,1)];
Wy1=[zeros(my+2,1),[zeros(1,ny);Wy;zeros(1,ny)],zeros(my+2,1)];
[mx,nx]=size(Wx1);
[my,ny]=size(Wy1);
for i=2:mx-2
    for j=2:nx-2
        Sp(i,j)=sign(Wx1(i+vd{1}(i-1,j-1),j+vd{2}(i-1,j-1))*v{1}(i-1,j-1)...
            +Wy1(i+vd{1}(i-1,j-1),j+vd{2}(i-1,j-1))*v{2}(i-1,j-1));
        Sn(i,j)=sign(Wx1(i-vd{1}(i-1,j-1),j-vd{2}(i-1,j-1))*v{1}(i-1,j-1)...
            +Wy1(i-vd{1}(i-1,j-1),j-vd{2}(i-1,j-1))*v{2}(i-1,j-1));
    end
end

Lam=BigLambda(A,Wx,Wy,Wd,h,g);
Rho=(-1/2).*sign(Lam).*abs(Sp-Sn);