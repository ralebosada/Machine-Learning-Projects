function [dW,db] = backpropagation(weights,bias,input,output,Z,A)
    
    % dE = @(y,y_hat)(-1*y./y_hat); 
    % dA = @(x)(x.*(1-x));
    
    dW = weights;
    db = bias;
    weights_total = length(weights);
    back_error = (1/size(output,2))*(A{end} - output);
    for i = 1:weights_total
        if i == weights_total
            dW{end-(i-1)} = input * back_error';
        else
            dW{end-(i-1)} = A{end-i} * back_error';
        end
        
        db{end-(i-1)} = sum(back_error,2);
        if i == weights_total
            continue
        else
            back_error = (weights{end-(i-1)}*back_error).*BF_relu(Z{end-i}); 
        end
    end
    
end