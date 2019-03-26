function result = radialBasisKernel(dataset)
sigma = 2;
numOfPoints = length(dataset(:,1));
kernel = @(xi,xj) exp(-sqrt(sum((xi-xj).^2,2))/2*sigma^2);
result = dataset;

for i = 1:numOfPoints
    % Store New Z values in 3th column
    result(i,3) = sum(kernel(dataset(i,1:2),dataset(:,1:2)));
end

end