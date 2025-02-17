% Max 2x1+x2
% 4x1+x2<=6
% x1+x2<=5
% x1,x2>=0
A=[4 1; 1 1; 1 0; 0 1]
B=[6; 5; 0; 0]

x1=0:0.1:max(B)
x21=(B(1)-A(1,1)*x1)./A(1,2)
x22=(B(2)-A(2,1)*x1)./A(2,2)

x21=max(0,x21)
x22=max(0,x22)

plot(x1,x21,'r',x1,x22,'b')
title("GRAPHICAL METHOD")
xlabel("x-axis")
ylabel("y-axis")
grid("on")
pt=[0;0]
for i=1:size(A,1)
    A1=A(i,:)
    B1=B(i,:)
    for j=i+1:size(A,1)
        A2=A(j,:)
        B2=B(j,:)
        A4=[A1;A2]
        B4=[B1;B2]
        X=inv(A4)*B4
        pt=[pt X]
       
    end
end
point=pt'
P=unique(point,'rows')


b1=P(:,1)
b2=P(:,2)
const1=round((4*b1)+b2-6)
s1=find(const1>0) % postiion of points that does not satifsy 1st constraint
P(s1,:)=[]

b1=P(:,1)
b2=P(:,2)
const2=round(b1+b2-5)
s2=find(const2>0)
P(s2,:)=[]

b1=P(:,1)
b2=P(:,2)
const3=round(-b1)
s3=find(const3>0)
P(s3,:)=[]

b1=P(:,1)
b2=P(:,2)
const4=round(-b2)
s4=find(const4>0)
P(s4,:)=[]

feasible=P
C=[2 1]
for i=1:size(P,1)
    fn(i,:)=sum(P(i,:).*C)
    optimal=max(fn)
end
