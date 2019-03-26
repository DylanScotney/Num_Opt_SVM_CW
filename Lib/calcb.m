function b = calcb(supportVectors)
% Calculates b using support vector info see SVM explained by Tristan
% Fletcher for more info: 
% [https://cling.csd.uwo.ca/cs860/papers/SVM_Explained.pdf]
y = supportVectors(:,4);
alpha = supportVectors(:,5);
x = supportVectors(:,1:3);
N = length(y);

b = 0;
for i = 1:length(y)
    sum1 = 0;
    for j = 1:length(y)
        sum1 = sum1 + alpha(j)*y(j)*dot(x(j,1:3),x(i,1:3));
    end
    b = b + y(i) - sum1;
end
b = b/N;
end