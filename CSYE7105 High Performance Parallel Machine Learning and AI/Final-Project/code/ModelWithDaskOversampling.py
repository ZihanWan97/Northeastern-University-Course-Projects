import multiprocessing
import time
import dask.dataframe as dd
import pandas as pd
from dask.dataframe import from_pandas
from dask_ml.model_selection import train_test_split
from sklearn import preprocessing
from dask_ml.preprocessing import DummyEncoder
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import StandardScaler
from xgboost import XGBClassifier

# Read Data
data_dd = pd.read_csv('onlinefraud.csv')
data_dd = data_dd.drop(['isFlaggedFraud','nameOrig','nameDest','step'],axis=1)
# Change Data to Dask
data_dd = from_pandas(data_dd, npartitions = 16)

# OneHotEncoder  
encoder = DummyEncoder()
# Categorize 'type' column.  
data_dd = data_dd.categorize(['type'])
# Fit the encoder 
data_dd = encoder.fit_transform(data_dd)

# Create new features
data_dd['orig_balance_diff'] = data_dd.oldbalanceOrg - data_dd.newbalanceOrig
data_dd['dest_balance_diff'] = data_dd.oldbalanceDest - data_dd.newbalanceDest
# Drop features not required
data_dd = data_dd.drop(['oldbalanceOrg','newbalanceOrig','oldbalanceDest','newbalanceDest'],axis=1)
data_dd = data_dd.drop(['type_PAYMENT','type_CASH_IN','type_DEBIT'],axis=1)

# OverSample
IsNotFraud_count,IsFraud_count = data_dd['isFraud'].value_counts()
IsNotFraud = data_dd[data_dd['isFraud'] == 0]
IsFraud = data_dd[data_dd['isFraud'] == 1]
IsFraud_over = IsFraud.sample(frac = 773.7,replace=True)
over_balanced_data_dd = dd.concat([IsNotFraud,IsFraud_over], axis=0)

# Divide X and y
X = over_balanced_data_dd.iloc[:,over_balanced_data_dd.columns !='isFraud'].values
y = over_balanced_data_dd.loc[:,'isFraud'].values

X_train, X_test, y_train, y_test = train_test_split(X.compute_chunk_sizes(), y.compute_chunk_sizes(), test_size=0.2, random_state=0)

sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.fit_transform(X_test)

def Model_Build():
    time1 = time.perf_counter()
    parameters = {
        'max_depth': [5, 15, 25],
        'learning_rate': [0.01, 0.05, 0.15],
        'n_estimators': [50, 100, 200],
        'min_child_weight': [0, 5, 20],
        'max_delta_step': [0, 0.6, 2],
        'subsample': [0.6, 0.8, 0.95],
        'reg_alpha': [0, 0.5, 1],

    }
    clf = XGBClassifier(max_depth=10,
                        learning_rate=0.01,
                        n_estimators=2000,
                        objective='binary:logistic',
                        nthread=-1,
                        gamma=0,
                        min_child_weight=1,
                        max_delta_step=0,
                        subsample=0.85,
                        colsample_bytree=0.7,
                        colsample_bylevel=1,
                        reg_alpha=0,
                        reg_lambda=1,
                        scale_pos_weight=1,
                        seed=1440,
                )

    grid_result = GridSearchCV(clf, param_grid=parameters, scoring='f1', cv=3)
    grid_result.fit(X_train, y_train)


    print("Best score: %0.3f" % grid_result.best_score_)
    print("Best parameters set:")
    best_parameters = grid_result.best_estimator_.get_params()
    for param_name in sorted(parameters.keys()):
        print("\t%s: %r" % (param_name, best_parameters[param_name]))
    kfold = KFold(n_splits=10, random_state=7, shuffle=True)
    results = cross_val_score(clf, X, y, cv=kfold)
    print("Accuracy: %.2f%% (%.2f%%)" % (results.mean() * 100, results.std() * 100))
    time2 = time.perf_counter()
    timeCPU = time2 - time1
    print(timeCPU)
def Model_By_CpuNumbers(Numbers,Name):
    pool = multiprocessing.Pool(Numbers)
    if(Name=="GPU"):
        print("Number of GPUS is -----------")
    if(Name=="CPU"):
        print("Number of CPUS is -----------")
    print(Numbers)
    pool.apply_async(Model_Build())


if __name__ == '__main__':
list = [1, 2, 4,8]
    for i in list
        Model_By_CpuNumbers(i,"CPU")
    for i in list
        Model_By_CpuNumbers(i,"GPU")




