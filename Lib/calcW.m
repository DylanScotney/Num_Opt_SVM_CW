function w = calcW(alpha, x, y)
% Calculates w for a 3D dataset using sum(alpha_i*y_i*x_i)
% Input: 
%   - alpha:            soln for alpha that maximises the lagrangian
%   - x:                matrix x of size NxD where N is the number of data
%                       points, D is the dimension of the problem. e.g. for
%                       a 3D problem of N=3: x = [x1, y1, z2;
%                                                 x2, y2, z2;
%                                                 x3, y3, z2];
%   -y:                 A vector of length N storing the classification of
%                       each point
%
% For more info refer to equation (1.10):
% SVM Explained, Tristan Fletcher UCL, [AVAILABLE AT]
% [https://cling.csd.uwo.ca/cs860/papers/SVM_Explained.pdfExtra]


w = zeros(length(x(1,:)),1);

for i = 1:length(w)
    for j = 1:length(alpha)
        w(i) = w(i) + alpha(j)*y(j)*x(j,i);
    end
end

end