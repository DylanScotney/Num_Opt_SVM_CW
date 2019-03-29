function w = calcW(alpha, dataset)
% Calculates w for a 3D dataset using sum(alpha_i*y_i*x_i)
%
% For more info refer to equation (1.10):
% SVM Explained, Tristan Fletcher UCL, [AVAILABLE AT]
% [https://cling.csd.uwo.ca/cs860/papers/SVM_Explained.pdfExtra]

x = dataset(:,1:3);
y = dataset(:,4);
w = zeros(length(x(1,:)),1);
for  i = 1:length(alpha)
    w = w + alpha(i)*y(i)*x(i,1:3)';
end

end