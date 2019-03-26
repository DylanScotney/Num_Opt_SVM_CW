function result = polynomialKernel(dataset)

b=2; 
a=0;
kernel = @(xi, xj) (dot(xi,xj)+a)^b;
numOfPoints = length(dataset(:,1));

result = dataset;

for j = 1:numOfPoints
    for i = 1:numOfPoints
      result(j,3) = result(j,3) + kernel(dataset(j,1:2), dataset(i,1:2));
    end
end

end