clc
clear all
format short

% ***** 1. input parameters***** 
c = [2 -7]
A = [-2 1; 1 -2;2 1]
b = [1;-8;12]

% ***** 2. plotting graph***** 
x1 = 0:2:max(b)
x21 = (b(1)-A(1,1)*x1)/A(1,2)
x22 = (b(2)-A(2,1)*x1)/A(2,2)
x23 = (b(3)-A(3,1)*x1)/A(3,2)
x21 = max(0,x21)
x22 = max(0,x22)
x23 = max(0,x23)
% x2 = [x21;x22;x23]
plot(x1,x21,'r',x1,x22,'k',x1,x23,'b') % red, black, blue line
xlabel('value of x1')
ylabel('value of x2')
title('x1-x2 plot')
legend('-2x1+x2=1','x1-2x1=-8','2x1+x2=12')
grid on

% ***** 3. corner points with X-axis***** 
cx1 = find(x1==0) % points with x1-axis
c1 = find(x21==0) % points with x2-axis
c2 = find(x22==0)
c3 = find(x23==0)
line1 = [x1(:,[cx1,c1]);x21(:,[cx1,c1])]'
line2 = [x1(:,[cx1,c2]);x22(:,[cx1,c2])]'
line3 = [x1(:,[cx1,c3]);x23(:,[cx1,c3])]'
corpt = unique([line1;line2;line3],'rows')

% ***** 4. intersection points***** 
HG = [0;0]
for i=1:size(A,1)
    hg1 = A(i,:)
    b1 = b(i,:) 
    for j = i+1:size(A,1)
        hg2 = A(j,:)
        b2 = b(j,:)
        Aa = [hg1;hg2]
        Bb = [b1;b2]
        Xx = inv(Aa)*Bb
        HG = [HG Xx]
    end
end

% ***** 5. all corner points***** 
pt = HG'
allpt = [pt;corpt]
points = unique(allpt,'rows')

% ***** 6. feasible region***** 
for i = 1 : size(points,1)
    cons1(i) = A(1,1)*points(i,1) + A(1,2)*points(i,2)-b(1)
    cons2(i) = A(2,1)*points(i,1) + A(2,2)*points(i,2)-b(2)
    cons3(i) = A(3,1)*points(i,1) + A(3,2)*points(i,2)-b(3)
    s1 = find(cons1>0)
    s2 = find(cons2>0)
    s3 = find(cons3>0)
end
S = unique([s1,s2,s3])
points(S,:) = []

% ***** 7. Objective value and points***** 
value = points*c'
table = [points,value]
[obj, index] = max(value)
X1 = points(index,1)
X2 = points(index,2)
fprintf('Objective value is %f at (%f,%f)',obj,X1,X2)
