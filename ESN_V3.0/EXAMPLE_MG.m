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
% example1: 
% - MG 
% - using the "function" implementation (esn_general)
%__________________________________________________________________________

clc
clear

timestamp = setup_environment('type-1');
verbose = 1; tic;

if verbose
    fprintf("[%8.3f s] program (%s) is running. \n",toc, mfilename); 
end

% {
dataset_name = 'mackey_glass_v3';
load(fullfile('..','data',[dataset_name, '.mat']))
index = 1 : 10 : length(time); % to sample the data 
                               % (note: the original data has 100k points)
inputs = data_true(index);     % 1 x nStep
time = time(index);            % 1 x nStep
%}

params.seed = 0;
params.time = time;
params.verbose                = false;
params.display                = true;
params.save_to_file           = false;
params.save_file_name = ...
fullfile('results', mfilename, sprintf('[%s]-%s',dataset_name, timestamp));

params.bias                   = 1;             % 1 | 0  (set 1 to add bias)
params.mode                   ='generative';   %'generative' | 'predictive'
params.func_state             = @(x)(x);       % reservoir activation
params.func_active            = @(x)(tanh(x)); % readout activation
params.split_ratio            = 0.8;   % train/test split
params.washout_length         = 1000;  % warmup length
params.sample_rate_thresh     = 0.00;  % not used in this version
params.target_index           = [1];   % only predict the "target_index"
params.num_clusters           = 1;     % 1 for regular ESN, > 1 for CESN
% if num_clusters>1, i.e., "Clustered-ESN" (CESN), then you need to define 
% params.pr = [linkDensity, withinModuleProportion]
% for instance, [0.1, 0.95], this gives more distinct clusters

% {  
% set1: run with esn_general.m  (no pred_on_train)
params.reservoir_size         = 200;      % number of neurons
params.w_in_scale             = [0.2, 1]; % the first one is bias value
params.pr                     = [0.15];   % connection probability
params.leaking_rate           = 0.3;      % leaking rate
params.chosen_spectral_radius = 1.25;     % spectral radious (no need to be < 1)
params.lambda                 = 1e-08;    % ridge regression regulrization
esn_func = @(inputs, params)(esn_general(inputs, params));
%}

%{
% set2: run with esn_general_v2 (w/ pred_on_train)
params.reservoir_size         = 500; 
params.w_in_scale             = [0.2, 1]; 
params.pr                     = [0.15];
params.leaking_rate           = 0.3; 
params.chosen_spectral_radius = 1.25; 
params.lambda                 = 1e-06;
esn_func = @(inputs, params)(esn_general_v2(inputs, params));
%}


[err_rmse, outputs] = esn_func(inputs, params);
comparative_plots(outputs, params, figure(1))


