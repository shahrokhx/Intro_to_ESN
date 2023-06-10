# Intro_to_ESN

Welcome to the $\boxed{\text{Intro to ESN}}$ repository! This repository contains a simple implementation of Echo State Networks (ESNs) for forecasting highly nonlinear/chaotic time series. It offers variations of ESNs, including the vanilla (regular) version, clustered ESN (CESN), and the physics-informed hybrid ESN (HESN).

The main goal of this repository is to provide a helpful resource for those interested in getting started with reservoir computing techniques and ESN-related projects. By using this code, you can quickly dive into the world of ESNs and start experimenting with them.

## Getting Started

To begin, make sure you have MATLAB installed on your system. You can clone or download this repository to access the code and get started right away. Follow the steps below to set up the project:

- Clone or download this repository to your local machine.
- Open MATLAB and navigate to the project directory.
- Review the main function code `esn_general.m`.
- Run the examples `EXAMPLE_MG.m` (*Mackey-Glass*) and `EXAMPLE_LORENZ.m` (*Lorenz-63*)

Feel free to modify and enhance the code according to your specific requirements. As you make progress with your ESN-related projects, we encourage you to contribute back to the repository by submitting your improvements and additions.

## Further Resources

If you're interested in delving deeper into the topic of ESNs, we recommend checking out our publications:

> 1. [Prediction of chaotic time series using recurrent neural networks and reservoir computing techniques: A comparative study](https://www.sciencedirect.com/science/article/pii/S2666827022000275)
> 2. [A machine-learning approach for long-term prediction of experimental cardiac action potential time series using an autoencoder and echo state networks](https://pubs.aip.org/aip/cha/article/32/6/063117/2835828/A-machine-learning-approach-for-long-term)
> 3. [Robust Reservoir Computing Approaches for Predicting Cardiac Electrical Dynamics](https://repository.gatech.edu/entities/publication/2ac8b323-a0aa-409e-8918-52e29b4c624e)


Happy coding!

-----

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
}
```

```
@article{10.1063/5.0087812,
author = {Shahi, Shahrokh and Fenton, Flavio H. and Cherry, Elizabeth M.},
title = "{A machine-learning approach for long-term prediction of experimental cardiac action potential time series using an autoencoder and echo state networks}",
journal = {Chaos: An Interdisciplinary Journal of Nonlinear Science},
volume = {32},
number = {6},
year = {2022},
month = {06},
issn = {1054-1500},
doi = {10.1063/5.0087812},
url = {https://doi.org/10.1063/5.0087812},
note = {063117},
eprint = {https://pubs.aip.org/aip/cha/article-pdf/doi/10.1063/5.0087812/16497876/063117\_1\_online.pdf},
}
```

```
@phdthesis{shahi2022robust,
  title={Robust Reservoir Computing Approaches for Predicting Cardiac Electrical Dynamics},
  author={Shahi, Shahrokh},
  year={2022},
  school={Georgia Institute of Technology}
}
```

