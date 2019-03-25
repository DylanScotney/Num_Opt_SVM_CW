function b = calcb(supportVectors)
%Calculates b using support vector info see SVM explained 
supportVectors
y = supportVectors(:,4)
alpha = supportVectors(:,5)
x = supportVectors(:,1:3)

y(1) - alpha(1)*y(1)*dot(x(1,1:3), x(1,1:3)) - alpha(2)*y(2)*dot(x(2,1:3), x(1,1:3))
y(2) - alpha(1)*y(1)*dot(x(1,1:3), x(2,1:3)) - alpha(2)*y(2)*dot(x(2,1:3), x(2,1:3))
end