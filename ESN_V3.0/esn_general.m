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
% can be employed for:
% - Baseline ESN
% - Clustered ESN
% - Hybrid ESN
%

function [err, outputs] = esn_general(inputs, params)


%% extracting parameters
rng(params.seed, 'twister');

verbose = params.verbose;
display = params.display;
save_to_file = params.save_to_file;
file_name_and_path = params.save_file_name;
sample_rate_thresh = params.sample_rate_thresh;

w_in_scale = params.w_in_scale;
bias = params.bias;    
washout_length = params.washout_length;    
pr = params.pr;
num_clusters = params.num_clusters;
chosen_spectral_radius = params.chosen_spectral_radius;
split_ratio = params.split_ratio;                                    
reservoir_size = params.reservoir_size;
leaking_rate = params.leaking_rate * ones(reservoir_size, 1); % CHK
lambda = params.lambda;
func_state = params.func_state;
func_active = params.func_active;
mode = params.mode;
target_index = params.target_index; 
               
% ----------------------------------------------------------------------- %
% some frequently used params               
[num_inputs, len_data] = size(inputs);
num_outputs = length(target_index);
               
if verbose; tic; fprintf("[%8.3f s] paramters are extracted. \n", toc); end

%% spliting data
train_length = floor(split_ratio * len_data);
test_length = len_data - train_length;
% washout_length = min(washout_length, floor(0.1 * len_data));

pretrain_index = 1 : washout_length;
train_index = (washout_length+1) : train_length;
test_index = train_length + (1 : test_length);

if verbose; fprintf("[%8.3f s] input data is ready. \n", toc); end 

%% constructing the network
w_in = (rand(reservoir_size, num_inputs + bias) - 0.5) .* w_in_scale;

if num_clusters == 1
    w = sprand(reservoir_size, reservoir_size, pr(1));
    w_mask = (w~=0); 
    w(w_mask) = (w(w_mask)-0.5);
    
else
    [w, Graph, clusters] = ...
        random_modular_graph(reservoir_size, num_clusters, pr(1), pr(2));
end
% adjusting the network
spectral_radius = abs(eigs(w,1));
w = w .* (chosen_spectral_radius / spectral_radius);

if verbose; fprintf("[%8.3f s] the network is constructed. \n", toc); end 

%% running the network

% setting up containers
rows = bias + num_inputs + reservoir_size;
cols = train_length - washout_length;
states = zeros(rows, cols);
states_enriched = zeros(rows+reservoir_size, cols);

target = inputs(target_index, ...
                washout_length + 2 : train_length + 1);

state_records.pretrain = zeros(reservoir_size, washout_length);
state_records.train = zeros(reservoir_size, train_length-washout_length);
state_records.test = zeros(reservoir_size, test_length);

% running the network and storing the states
state = zeros(reservoir_size, 1);
start_recording = false;
for t = 1 : train_length 
    u = inputs(:, t); % num_inputs x 1
    
    if bias; u = [1; u]; end
    
    state = (1 - leaking_rate) .* func_state(state) + ...
            (    leaking_rate) .* func_active(w_in * u +  w * state);
    state(1:5);
    if t > washout_length
        % the first time of meeting this criterion, store the state values
        if ~start_recording 
            state_at_the_beginning_of_recording = state;
            start_recording = true;
        end
        states(:, t - washout_length) = [u; state];
        states_enriched(:, t - washout_length) = [u; state; state.^2];
        
        state_records.train(:, t-washout_length) = state;
    else 
        state_records.pretrain(:, t) = state;
    end
    
end
state_at_the_end_of_training = state;

if verbose; fprintf("[%8.3f s] state values are recorded. \n", toc); end

%% training readout layer

w_out1 = ((states * states' + lambda * eye(rows)) \ (states * target'));

% w_out2 = ((states_enriched * states_enriched' + ...
%          lambda * eye(rows+reservoir_size)) \ (states_enriched * target'));

w_out = w_out1;       
% w_out = w_out2;

if verbose; fprintf("[%8.3f s] w_out is calculated. \n", toc); end

%% prediction
% running generative/predictive mode
% continue the states from the last step of training 

pred = zeros(num_outputs, test_length); % predictions
u = inputs(:, train_length + 1);

for t = 1 : test_length
    
    if bias; u = [1; u]; end
    
    state = (1 - leaking_rate) .* func_state(state) + ...
            (    leaking_rate) .* func_active(w_in * u +  w * state);
    
    y = w_out' * [u; state];
    %y = w_out' * [inputs; state; state.^2];
    
    pred(:, t) = y;
    state_records.test(:,t) = state;
    
    if t == test_length; break; end
    switch mode
        case 'generative'
            u = inputs(:, train_length + t + 1);
            u(target_index) = y;
        case 'predictive'
            u = inputs(:, train_length + t + 1);
    end
end
if verbose; fprintf("[%8.3f s] prediction is completed. \n", toc); end  

%% evaluating 
err = sqrt(mse(inputs(target_index,test_index), pred));

%% outputs

outputs.pretrain_index = pretrain_index;
outputs.train_index = train_index;
outputs.test_index = test_index;
outputs.state_records = state_records;
outputs.inputs = inputs;
outputs.pred = pred;
outputs.w_out = w_out;
outputs.w = w;
outputs.w_in = w_in;

end




%% helper functions
function [adjacencyMatrix, graph, modules] = random_modular_graph(...
    nodeCount, ...
    moduleCount, ...
    linkDensity, ...
    withinModuleProportion)

    % Build a random modular graph, given the 
    % - number of nodes, 
    % - number of modules (clusters), 
    % - total link density, and 
    % - proportion of links within modules compared to links across

    averageDegree = round(linkDensity * (nodeCount - 1)); % Erdos-Renyi

    modules = arrayfun(@(k) round((k - 1)*nodeCount/moduleCount) + 1 : ...
        round(k * nodeCount / moduleCount), ...
        1:moduleCount, 'UniformOutput', false);

    adjacencyMatrix = zeros(nodeCount);

    for i = 1:nodeCount
        for j = 1:nodeCount
            module_i = ceil(moduleCount * i / nodeCount);
            module_j = ceil(moduleCount * j / nodeCount);

            if module_i == module_j && ...
               rand <= withinModuleProportion * averageDegree / ...
               (nodeCount / moduleCount - 1)
                adjacencyMatrix(i, j) = rand < 0.5;
                
            elseif module_i ~= module_j && ...
                rand <= (1 - withinModuleProportion) * averageDegree / ...
                (nodeCount - nodeCount / moduleCount)
                adjacencyMatrix(i, j) = rand < 0.5;
                
            end
        end
    end
    
    graph = digraph(adjacencyMatrix);
end


