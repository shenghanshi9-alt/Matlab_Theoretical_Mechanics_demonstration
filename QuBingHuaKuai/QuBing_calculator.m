function k = QuBing_calculator( n)
%QUBING_CACULATER 此处显示有关此函数的摘要
%   此处显示详细说明
l1=n(1);
l2=n(2);
rad=n(3);
rad1=n(4)*3.14159/180;
m=n(5);
x1=- l1*rad*sin(rad1) - (l1^2*rad*cos(rad1)*sin(rad1))/(l2^2 - l1^2*sin(rad1)^2)^(1/2);
x2=(l1^2*rad^2*sin(rad1)^2)/(l2^2 - l1^2*sin(rad1)^2)^(1/2) - (l1^2*rad^2*cos(rad1)^2)/(l2^2 - l1^2*sin(rad1)^2)^(1/2) - l1*rad^2*cos(rad1) - (l1^4*rad^2*cos(rad1)^2*sin(rad1)^2)/(l2^2 - l1^2*sin(rad1)^2)^(3/2);
x3=x2*m;
x4=sin(acos((-(l1*cos(rad1)+sqrt((l2^2)-(l1*sin(rad1))^2))^2+l1^2+l2^2)/(2*l1*l2)))*x3*l1;
k=[x1 x2 x3 x4];

end

