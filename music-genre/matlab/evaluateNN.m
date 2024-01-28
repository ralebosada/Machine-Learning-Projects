function [prediction_test,loss_test] = evaluateNN(input,output,epoch,weights,bias)

    for i = 1:epoch
        [prediction_test,error,~,~] = feedforward(weights,bias,input,output);
        % [dW,db] = backpropagation(weights,bias,input,output,Z,A);
        % [weights,bias] = parameter_update(weights,bias,dW,db,LR);
        loss_test(i) = error;
    end

end