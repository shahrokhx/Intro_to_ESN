# Intro_to_ESN
This repository includes a simple implementation of Echo State Networks (ESNs) and it can be used for forecasting highly nonlinear time series using variations of ESNs including the vanilla (regular) version, clustered ESN (CESN), and the physics-informed hybrid ESN (HESN). 

For further information, please check the [following publications](https://www.sciencedirect.com/science/article/pii/S2666827022000275):

```
@article{SHAHI2022100300,
title = {Prediction of chaotic time series using recurrent neural networks and reservoir computing techniques: A comparative study},
journal = {Machine Learning with Applications},
volume = {8},
pages = {100300},
year = {2022},
issn = {2666-8270},
doi = {https://doi.org/10.1016/j.mlwa.2022.100300},
url = {https://www.sciencedirect.com/science/article/pii/S2666827022000275},
author = {Shahrokh Shahi and Flavio H. Fenton and Elizabeth M. Cherry},
keywords = {Recurrent neural networks, Reservoir computing, Echo state networks, Deep learning, Chaotic time series, Nonlinear vector autoregression},
abstract = {In recent years, machine-learning techniques, particularly deep learning, have outperformed traditional time-series forecasting approaches in many contexts, including univariate and multivariate predictions. This study aims to investigate the capability of (i) gated recurrent neural networks, including long short-term memory (LSTM) and gated recurrent unit (GRU) networks, (ii) reservoir computing (RC) techniques, such as echo state networks (ESNs) and hybrid physics-informed ESNs, and (iii) the nonlinear vector autoregression (NVAR) approach, which has recently been introduced as the next generation RC, for the prediction of chaotic time series and to compare their performance in terms of accuracy, efficiency, and robustness. We apply the methods to predict time series obtained from two widely used chaotic benchmarks, the Mackey–Glass and Lorenz-63 models, as well as two other chaotic datasets representing a bursting neuron and the dynamics of the El Niño Southern Oscillation, and to one experimental dataset representing a time series of cardiac voltage with complex dynamics. We find that even though gated RNN techniques have been successful in forecasting time series generally, they can fall short in predicting chaotic time series for the methods, datasets, and ranges of hyperparameter values considered here. In contrast, for the chaotic datasets studied, we found that reservoir computing and NVAR techniques are more computationally efficient and offer more promise in long-term prediction of chaotic time series.}
}
```

