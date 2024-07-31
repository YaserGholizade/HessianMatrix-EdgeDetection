function [E_Val,E_Vec]=BigLambda(A,B,D,H1,h,g)
mB=size(B,1);
for i=1:mB
    Bt(i,:)=conv(B(i,:),g,'same');
end
nt=size(Bt,2);
for j=1:nt
    Bx(:,j)=conv(Bt(:,j),h,'same');
end
mD=size(D,1);
for i=1:mD
    Dt(i,:)=conv(D(i,:),h,'same');
end
nt=size(Dt,2);
for j=1:nt
    Dy(:,j)=conv(Dt(:,j),g,'same');
end
[m,n]=size(A);
E_Val=zeros(m,n);
for i=1:m
    for j=1:n
        H=[Bx(i,j),H1(i,j);H1(i,j),Dy(i,j)];
        [V,E]=eig(H);
        a=E(1,1);
        b=E(2,2);
        if a==b
            ss=sign(a*b);
            if ss==-1
                L=abs(a);
            elseif ss==1
                L=a;
            else
                L=0;
            end
        elseif a<b
            L=b;
        elseif a>b
            L=a;
        end
        [yy1,yy2]=find(L==E);
        E_Val(i,j)=L/(norm(L,2));
        E_Vec{i,j}=V(:,yy1);
        clear L
    end
end
