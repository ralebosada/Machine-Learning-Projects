function [weights,bias,loss_train,prediction_train,loss_test,prediction_test,accuracy_training,accuracy_testing] = trainNN(input_train,output_train,input_test,output_test,LR,epoch,weights,bias,training_label,testing_label)
   
    for i = 1:epoch
        [prediction_train,error_train,Z,A] = feedforward(weights,bias,input_train,output_train);
        loss_train(i) = error_train;
        [prediction_test,error_test,~,~] = feedforward(weights,bias,input_test,output_test);
        loss_test(i) = error_test;
        [dW,db] = backpropagation(weights,bias,input_train,output_train,Z,A);
        [weights,bias] = parameter_update(weights,bias,dW,db,LR);
        
        [~,prediction_train] = max(prediction_train);
        [~,prediction_test] = max(prediction_test);
        train_accuracy = prediction_train - training_label;
        test_accuracy = prediction_test - testing_label;
        counter_train = 0;
        counter_test = 0;
        for j = 1:length(train_accuracy)
            if train_accuracy(j) == 0
                counter_train = counter_train + 1;
            end
        end
        for j = 1:length(test_accuracy)
            if test_accuracy(j) == 0
                counter_test = counter_test + 1;
            end 
        end

        accuracy_training(i) = counter_train/length(train_accuracy);
        accuracy_testing(i) = counter_test/length(test_accuracy);
    end
    
end