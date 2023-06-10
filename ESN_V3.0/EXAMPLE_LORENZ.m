%                E C H O     S T A T E     N E T W O R K             
%__________________________________________________________________________
% 
%           A Function Implementation of Echo State Network (ESN)
%                          by SHAHROKH SHAHI 
%                           (www.sshahi.com)
%
%                   Georgia Institute of Technology
%                             2020 - 2021
%__________________________________________________________________________
%
% example2: 
% - Lorenz-63 
% - using the "function" implementation (esn_general)
%__________________________________________________________________________

clc
clear

timestamp = setup_environment('type-1');
verbose = 1; tic;

if verbose
    fprintf("[%8.3f s] program (%s) is running. \n",toc, mfilename); 
end


dataset_name = 'lorenz_v3';
load(fullfile('..','data',[dataset_name, '.mat']))
inputs = data_true; % nInput x nStep, where nInput = 3
time;               % 1 x nStep

params.verbose                = false;
params.display                = true;
params.save_to_file           = false;
params.save_file_name = ...
fullfile('results', mfilename, sprintf('[%s]-%s',dataset_name, timestamp));
params.reservoir_size         = 500; 
params.bias                   = 1;
params.mode                   ='generative';   %'generative' | 'predictive'
params.func_state             = @(x)(x);
params.func_active            = @(x)(tanh(x));
params.washout_length         = 200; 
params.split_ratio            = 0.8;  
params.sample_rate_thresh     = 0.00; % not used
params.w_in_scale             = [1, 1, 1, 1]; % [w_bias, w_x, w_y, w_z]
params.pr                     = [0.05];
params.num_clusters           = 1;
params.leaking_rate           = 0.4; 
params.chosen_spectral_radius = 1.55; 
params.lambda                 = 1e-09; 
params.target_index           = [1, 2, 3]; % [x, y, z]

params.time = time;
params.seed = 0;


[err_rmse, outputs] = esn_general(inputs, params);
comparative_plots(outputs, params, figure(1))


