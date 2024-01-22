from . import setup

# Defining Clickbait Prediction Class

class ClassicML():
    def __init__(self, X, y):
        self.X = X # Training Set
        self.y = y # Label Set

    def NB(self, X_test, model_type='multinomial'):
        # Defining Naive Bayes Model
        from sklearn.naive_bayes import MultinomialNB
        from sklearn.naive_bayes import GaussianNB
        from sklearn.naive_bayes import BernoulliNB

        if model_type.lower() == 'multinomial':
            model_type = MultinomialNB()
        elif model_type.lower() == 'gaussian':
            model_type = GaussianNB()
        elif model_type.lower() == 'bernoulli':
            model_type = BernoulliNB()
        else:
            print(f"Sorry, there is no model type {model_type}")
            quit()

        model = model_type
        model.fit(self.X, self.y)
        y_train, y_test = model.predict(self.X), model.predict(X_test)

        return y_train, y_test

    def LR(self, X_test, param_grid=None, k_fold=3, scoring='f1'):
        from sklearn.linear_model import LogisticRegression
        from sklearn.model_selection import GridSearchCV

        model = LogisticRegression(probability=True)

        if param_grid == None:
            model.fit(self.X, self.y)
            y_train, y_test = model.predict(self.X), model.predict(self.y)
            prob_train, prob_test = model.predict_proba(self.X), model.predict_proba(X_test)
            return y_train, y_test, model, prob_train, prob_test
        else:
            opt_model = GridSearchCV(model, param_grid=param_grid, cv=k_fold, scoring=scoring)
            opt_model.fit(self.X, self.y)
            y_train, y_test = opt_model.predict(self.X), opt_model.predict(X_test)
            prob_train, prob_test = opt_model.predict_proba(self.X), opt_model.predict_proba(X_test)
            return y_train, y_test, opt_model, prob_train, prob_test


	def SVM(self, X_test, param_grid=None, k_fold=3, scoring='f1'):
    	from sklearn.svm import SVC
    	from sklearn.model_selection import GridSearchCV

    	model = SVC()
    	if param_grid == None:
     	 model.fit(self.X, self.y)
      	y_train, y_test = model.predict(self.X), model.predict(X_test)
      	prob_train, prob_test = model.predict_proba(self.X), model.predict_proba(X_test)
      	return y_train, y_test, model, prob_train, prob_test
    	else:
      	opt_model = GridSearchCV(model, param_grid=param_grid, cv=k_fold, scoring=scoring)
      	opt_model.fit(self.X, self.y)
      	y_train, y_test = opt_model.predict(self.X), opt_model.predict(X_test)
      	prob_train, prob_test = opt_model.predict_proba(self.X), opt_model.predict_proba(X_test)
      	return y_train, y_test, opt_model, prob_train, prob_test

  	def MLP(self, X_test, param_grid=None, k_fold=3, scoring='f1'):
    	from sklearn.neural_network import MLPClassifier
    	from sklearn.model_selection import GridSearchCV

    	model = MLPClassifier()
    	if param_grid == None:
      	model.fit(self.X, self.y)
      	y_train, y_test = model.predict(self.X), model.predict(X_test)
      	prob_train, prob_test = model.predict_proba(self.X), model.predict_proba(X_test)
      	return y_train, y_test, model, prob_train, prob_test
    	else:
      	opt_model = GridSearchCV(model, param_grid=param_grid, cv=k_fold, scoring=scoring)
      	opt_model.fit(self.X, self.y)
      	y_train, y_test = opt_model.predict(self.X), opt_model.predict(X_test)
      	prob_train, prob_test = opt_model.predict_proba(self.X), opt_model.predict_proba(X_test)
      	return y_train, y_test, opt_model, prob_train, prob_test


