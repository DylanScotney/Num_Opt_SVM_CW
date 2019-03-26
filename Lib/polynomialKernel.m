function result = polynomialKernel(dataset)
% Maps 2D data onto 2D space using the polynomial kernal
% Inputs: dataset, a Nx4 matrix where each row corresponds to info for each 
%         data point such that:
%         row_i = [xcoord_i, ycoord_i, zcoord_i(=0 on input), class_i]
% outputs: a Nx4 matrix where each row is:
%          [xcoord, ycoord, zcoord, class]

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