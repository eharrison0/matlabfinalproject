filenames = {
    'emotiondata_EH.mat'
    'emotiondata_ks.mat'
    'emotiondata_JM.mat'
};

% Initialize variables
nsubj = length(filenames);
n_conditions = 3; % Assuming there are three independent variables: Angry, Happy, Neutral

% Initialize group variables
all_rt = zeros(nsubj, n_conditions);
all_accuracy = zeros(nsubj, n_conditions);

% Start the main loop: go through each subject, load their data, and analyze performance and reaction time
for i = 1:nsubj
    load(filenames{i});
    
    % Find the trials associated with each emotion
    k_angry = find(trial_matrix(:,2) == 1); % Angry faces
    k_happy = find(trial_matrix(:,2) == 2); % Happy faces
    k_neutral = find(trial_matrix(:,2) == 3); % Neutral faces
    
    % Calculate mean reaction time for each condition
    all_rt(i, 1) = median(trial_matrix(k_angry, 4)); % Angry
    all_rt(i, 2) = median(trial_matrix(k_happy, 4)); % Happy
    all_rt(i, 3) = median(trial_matrix(k_neutral, 4)); % Neutral
    
    % Calculate mean accuracy for each condition
  
    trial_matrix(:,5) = trial_matrix(:,2) == trial_matrix(:,3);
    all_accuracy(i, 1) = mean(trial_matrix(k_angry, 5)); %angry
    all_accuracy(i, 2) = mean(trial_matrix(k_happy, 5)); % Happy
    all_accuracy(i, 3) = mean(trial_matrix(k_neutral, 5)); %neutral
end
%make new column in trial matrix to test if trial matrix matches response
% Compute overall means and standard deviations
overall_rt_mean = mean(all_rt);
overall_rt_std = std(all_rt);
overall_accuracy_mean = mean(all_accuracy);

% Compute t-statistics
t_stat = zeros(n_conditions);
for i = 1:n_conditions
    for j = 1:n_conditions
        [~, ~, ~, stats] = ttest(all_rt(:, i), all_rt(:, j));
        t_stat(i, j) = stats.tstat;
    end
end

% Plotting mean reaction time with error bars
figure;
errorbar(1:n_conditions, overall_rt_mean, overall_rt_std / sqrt(nsubj), 'o-');
xlabel('Emotion');
ylabel('Mean Reaction Time');
title('Mean Reaction Time for Each Emotion');
xticks(1:n_conditions);
xticklabels({'Angry', 'Happy', 'Neutral'});

% Plotting mean accuracy
figure;
bar(1:n_conditions, overall_accuracy_mean);
xlabel('Emotion');
ylabel('Mean Accuracy');
title('Mean Accuracy for Each Emotion');
xticks(1:n_conditions);
xticklabels({'Angry', 'Happy', 'Neutral'});

% Plotting t-statistics
figure;
imagesc(t_stat);
colorbar;
xlabel('Emotion');
ylabel('Emotion');
title('T-Statistics between Emotions');
xticks(1:n_conditions);
xticklabels({'Angry', 'Happy', 'Neutral'});
yticks(1:n_conditions);
yticklabels({'Angry', 'Happy', 'Neutral'});
