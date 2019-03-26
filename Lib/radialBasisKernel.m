function result = radialBasisKernel(dataset)
% Maps 2D dataset onto 3D space using the radial basis kernel. 
% Inputs: dataset, a Nx4 matrix where each row corresponds to info for each 
%         data point such that:
%         row_i = [xcoord_i, ycoord_i, zcoord_i(=0 on input), class_i]
% outputs: a Nx4 matrix where each row is:
%          [xcoord, ycoord, zcoord, class]
% See accompanying report for more info. 

sigma = 2;
numOfPoints = length(dataset(:,1));
kernel = @(xi,xj) exp(-sqrt(sum((xi-xj).^2,2))/2*sigma^2);
result = dataset;

for i = 1:numOfPoints
    % Store New Z values in 3th column
    result(i,3) = sum(kernel(dataset(i,1:2),dataset(:,1:2)));
end

end