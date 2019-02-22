clc
clear all
%% addpath
addpath(genpath('Algorithm'))
addpath(genpath('data'))
addpath(genpath('functions'))

%% load data
 Files = dir(fullfile('Data', '*.mat'));
 
Max_datanum = length(Files);   % The total number of test datasets
for i = 5:5
data_num = i; 
Dname = Files(data_num).name; % data name
disp(['***********The test datas name is: ***' num2str(data_num) '***'  Dname '****************'])
load(Dname);
paraset = {0.3, 0.3, 0.1, 0.1, 0.35};
tic
result = Test_SMVSC(X,Y,paraset{data_num});
temp_time(1,data_num) = toc;
ARI(1,data_num) = rand_index(result, Y);
NMI(1,data_num) = computeNMI(result, Y);
ACC(1,data_num) = Accuracy(result, Y);
end

%% œ‘ æ
temp_time
ARI
NMI
ACC