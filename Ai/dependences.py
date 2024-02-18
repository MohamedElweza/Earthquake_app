# utilities 
# needed pacakges for running the model 
import pandas as pd
import numpy as np
import tensorflow as tf
import sklearn
import os
import json
import matplotlib.pyplot as plt 
from sklearn.impute import SimpleImputer
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.pipeline import make_pipeline
from sklearn.compose import make_column_transformer
from sklearn.preprocessing import FunctionTransformer
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.ensemble import RandomForestRegressor, VotingRegressor, ExtraTreesRegressor, BaggingRegressor
from sklearn.metrics import mean_squared_error as mse, mean_absolute_error as mae