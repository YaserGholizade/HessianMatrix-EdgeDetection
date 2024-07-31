clc;clear;
AA=imread('lenna','tif');
% AA=imread('pattern','tif');
B=double(AA);
C1=B;
% A2=imread('tr','tif');
% A2=A2(:,:,2);
% C1=double(A2);
H=cell(1);
V=cell(1);
D=cell(1);
[m n]=size(C1);
h=[0.125 0.375 0.375 .125];
g=[-2 2];
for i=1:m
    Att(i,:)=conv(C1(i,:),h,'same');
end
for j=1:n
    AN(:,j)=conv(Att(:,j),h,'same');
end
A{1}=AN;
for k=1:8
    [m n]=size(A{k});
    for i=1:m
        At(i,:)=downsample(conv(A{k}(i,:),h,'same'),2);
        Dt(i,:)=downsample(conv(A{k}(i,:),g,'same'),2);
    end
    [m1 n1]=size(At);
    for j=1:n1
        A{k+1}(:,j)=downsample(conv(At(:,j),h,'same'),2);
        H1(:,j)=downsample(conv(At(:,j),g,'same'),2);
        V1(:,j)=downsample(conv(Dt(:,j),h,'same'),2);
        D1(:,j)=downsample(conv(Dt(:,j),g,'same'),2);
    end
    H{k+1}=H1;
    V{k+1}=V1;
    D{k+1}=D1;
    MF{k}=sqrt(H1.^2+V1.^2);
    Y{k}=~(MF{k}>3.5);
    clear At Dt H1 V1 D1
end
%imagesc(Y{1});colormap(gray);
Px=sign(H{2})*H{2}.*H{3};
Py=sign(V{2})*V{2}.*V{3};
Mf=sqrt(Px^2+Py^2);
Y1=~(Mf>3.5);
imagesc(Y1); colormap(gray);
