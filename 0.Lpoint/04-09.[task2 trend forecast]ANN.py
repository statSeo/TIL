import numpy as np
import os
import pandas as pd
import matplotlib.pyplot as plt
from pandas import Series
from sklearn.model_selection import TimeSeriesSplit
from sklearn.preprocessing import scale
import plotly.plotly as py
import plotly.graph_objs as go


# Lab 10 MNIST and High-level TF API
from tensorflow.contrib.layers import fully_connected, batch_norm, dropout
from tensorflow.contrib.framework import arg_scope
import tensorflow as tf
import random

from tensorflow.contrib.data.python.ops import sliding


xx = pd.read_csv("E:\\Dropbox\\2017\\06.job_recruitment\\01.Lpoint\\01.Data\\03.XXYY\\xx_trenchcoat.csv")
xx.head()

new_x = pd.read_csv("E:\\Dropbox\\2017\\06.job_recruitment\\01.Lpoint\\01.Data\\02.For_New_X\\new\\new_x_trenchcoat.csv")
new_x.head()

yy = pd.read_csv("E:\\Dropbox\\2017\\06.job_recruitment\\01.Lpoint\\01.Data\\03.XXYY\\yy_trenchcoat.csv")
yy.head()

x = xx.iloc[:, 1:6]  # indirect_search, indirect buy, naver, temperatue, community_pca만 사용하자.
y = yy.iloc[:, [1]]
new_x = new_x.iloc[:, 1:6]


tf.set_random_seed(777)  # reproducibility

data_dim = 5
split = 153
n = 0  # forecast

# parameters
learning_rate = 0.02  # we can use large learning rate using Batch Normalization
training_epochs = 100
hidden_dimension = 3


print(trainX.shape, trainY.shape, testX.shape, testY.shape, new_x.shape)


tf.reset_default_graph()
X = tf.placeholder(tf.float32, [None, data_dim])
Y = tf.placeholder(tf.float32, [None, 1])
train_mode = tf.placeholder(tf.bool, name='train_mode')

# layer output size
final_output_size = 1

xavier_init = tf.contrib.layers.xavier_initializer()
bn_params = {
    'is_training': train_mode,
    'decay': 0.9,
    'updates_collections': None
}


W1 = tf.get_variable("W1", shape=[data_dim, hidden_dimension],
                     initializer=tf.contrib.layers.xavier_initializer())
b1 = tf.Variable(tf.random_normal([hidden_dimension]))
L1 = tf.nn.relu(tf.matmul(X, W1) + b1)

W2 = tf.get_variable("W2", shape=[hidden_dimension, 1],
                     initializer=tf.contrib.layers.xavier_initializer())
b2 = tf.Variable(tf.random_normal([1]))
hypothesis = tf.matmul(L1, W2) + b2

loss = tf.reduce_mean(tf.square(hypothesis - Y))  # sum of the squares
optimizer = tf.train.AdamOptimizer(learning_rate).minimize(loss)
targets = tf.placeholder(tf.float32, [None, 1])
predictions = tf.placeholder(tf.float32, [None, 1])
rmse = tf.sqrt(tf.reduce_mean(tf.square(targets - predictions)))


################################
##### train / testing ##############
################################
tf.set_random_seed(777)  # reproducibility

# n - day forecast
trainX = x.iloc[:split - n, :]
trainY = y.iloc[n:split, [0]]  # y.iloc[n:split,[0]]
# testX = x.iloc[split-n:-n,:] # when != 0
testX = x.iloc[split:, :]  # when n=0
testY = y.iloc[split:, [0]]

print(trainX.shape, trainY.shape, testX.shape, testY.shape)


# initialize
sess = tf.Session()
sess.run(tf.global_variables_initializer())

# train my model
for epoch in range(training_epochs):
    avg_cost = 0
    feed_dict_train = {X: trainX, Y: trainY}
    feed_dict_cost = {X: trainX, Y: trainY}
    opt = sess.run(optimizer, feed_dict=feed_dict_train)
    c = sess.run(loss, feed_dict=feed_dict_cost)
    avg_cost = c
    test_predict = sess.run(hypothesis, feed_dict={X: testX})
    train_predict = sess.run(hypothesis, feed_dict={X: trainX})
    rmse_val = sess.run(rmse, feed_dict={
        targets: testY, predictions: test_predict})
    if (epoch + 1) % 10 == 0:
        print("[Epoch: {:>4}] train rmse = {:>.9}".format(epoch + 1, np.sqrt(avg_cost)), 'test rmse :{} '.format(rmse_val))

        predicted = scale([x for x in np.repeat(train_predict[0], n)] +
                          [x for x in train_predict] +
                          [x for x in test_predict])

        plt.plot(predicted)
        plt.plot(scale(y))
        plt.show()
plt.plot(yy.iloc[:, [1]])

actual = pd.Series(scale(y).reshape(-1))
predict = pd.Series(predicted.reshape(-1))

df = pd.concat([actual, predict], axis=1)
df.to_csv('E:\\Dropbox\\2017\\06.job_recruitment\\01.Lpoint\\01.Data\\02.ann_result\\trenchcoat_annresult_traintest.csv')


################################
##### forecasting ##############
################################


# forecast october
trainX = x.iloc[:, :]
trainY = y.iloc[:, [0]]  # y.iloc[n:split,[0]]
new_x = new_x.iloc[:, :]

# initialize
sess = tf.Session()
sess.run(tf.global_variables_initializer())

# train my model
for epoch in range(training_epochs):
    avg_cost = 0
    feed_dict_train = {X: trainX, Y: trainY}
    feed_dict_cost = {X: trainX, Y: trainY}
    opt = sess.run(optimizer, feed_dict=feed_dict_train)
    c = sess.run(loss, feed_dict=feed_dict_cost)
    avg_cost = c
    forecast = sess.run(hypothesis, feed_dict={X: new_x})
    train_predict = sess.run(hypothesis, feed_dict={X: trainX})

    if (epoch + 1) % 10 == 0:
        print("[Epoch: {:>4}] train rmse = {:>.9}".format(epoch + 1, np.sqrt(avg_cost)))  # 'test rmse :{} '.format(rmse_val)

        plt.plot(predicted)
        plt.plot(scale(y))
        plt.show()
plt.plot(yy.iloc[:, [1]])

actual = pd.Series(scale(y).reshape(-1))
predict = pd.Series(predicted.reshape(-1))

df = pd.concat([actual, predict], axis=1)
df.to_csv('E:\\Dropbox\\2017\\06.job_recruitment\\01.Lpoint\\01.Data\\02.ann_result\\cardigan_annresult_forecast.csv')
