
nb_shm = repmat({zeros(2, 5)}, 1, 5);

config_files = 31:35;
for jj = 1:5
	CONFIG_FILE = config_files(jj);
	for ii = 1:5
		startHTM_simulation;
		[angles_cpt, angles_rad] = getAnglesCpt(htm);
		nb_shm{jj}(:, ii) = sum(angles_cpt');
		% nb_shm{jj}(1, ii) = numel(cell2mat(htm.naive_shm(:)));
		% nb_shm{jj}(2, ii) = MOKS.shm;
		% nb_shm7 = nb_shm;
		disp(['Config : ', num2str(jj)]);
		disp(['Sim : ', num2str(ii)]);
	end
end


cond 1 : 3 sources, 1 sim, paires [1, 9]
cond 2 : 3 sources, 2 sim, paires [1, 9]
cond 3 : 3 sources, 3 sim, paires [1, 9]

cond 4 : 5 sources, 1 sim, pairs [1, 9, 18]
cond 5 : 5 sources, 2 sim, pairs [1, 9, 18]
cond 6 : 5 sources, 3 sim, pairs [1, 9, 18]
cond 7 : 5 sources, 4 sim, pairs [1, 9, 18]
cond 8 : 5 sources, 5 sim, pairs [1, 9, 18]

cond 9  : 7 sources, 1 sim, pairs [1, 9, 18, 21, 28]
cond 10 : 7 sources, 3 sim, pairs [1, 9, 18, 21, 28]
cond 11 : 7 sources, 5 sim, pairs [1, 9, 18, 21, 28]
cond 12 : 7 sources, 7 sim, pairs [1, 9, 18, 21, 28]

cond 13 : 10 sources, 1 sim, pairs [1, 3, 9, 28, 41, 46]
cond 14 : 10 sources, 3 sim, pairs [1, 3, 9, 28, 41, 46]
cond 15 : 10 sources, 5 sim, pairs [1, 3, 9, 28, 41, 46]
cond 16 : 10 sources, 8 sim, pairs [1, 3, 9, 28, 41, 46]
cond 16 : 10 sources, 10 sim, pairs [1, 3, 9, 28, 41, 46]



% === 
figure('Color', 'white');

shms_mean = zeros(2, 3);
shms_std = zeros(2, 3);

for ii = 1:3
	shms_mean(1, ii) = mean(nb_shm3{ii}(1, :));
	shms_mean(2, ii) = mean(nb_shm3{ii}(2, :));
	shms_std(1, ii) = std(nb_shm3{ii}(1, :));
	shms_std(2, ii) = std(nb_shm3{ii}(2, :));
end

X = [1,1;...
	 2,2;...
	 3,3];
Xerr = [0.85, 1.15;...
		1.85, 2.15;...
		2.85, 3.15];

subplot(2, 2, 1);
h = bar(X, shms_mean');
ha = get(h(1), 'Parent');
set(ha, 'XTickLabel', 1:3, 'FontSize', 20);
% set(get(ha, 'XLabel'), 'String', 'Nombre de sources simultanées');
set(get(ha, 'XLabel'), 'String', '')
% set(get(ha, 'YLabel'), 'String', 'Nombre de mouvements de tête');
set(get(ha, 'YLabel'), 'String', '');
set(h(1), 'FaceColor', 'red');
set(h(2), 'FaceColor', [0 0.4470 0.7410]);

hold on;
he = errorbar(Xerr, shms_mean', shms_std', 'bx', 'Color', [0, 0, 0]);
set(he(1), 'LineWidth', 2);
set(he(2), 'LineWidth', 2);
hold off;

% ===

shms_mean = zeros(2, 5);
shms_std = zeros(2, 5);

for ii = 1:5
	shms_mean(1, ii) = mean(nb_shm5{ii}(1, :));
	shms_mean(2, ii) = mean(nb_shm5{ii}(2, :));
	shms_std(1, ii) = std(nb_shm5{ii}(1, :));
	shms_std(2, ii) = std(nb_shm5{ii}(2, :));
end

X = [1,1;...
	 2,2;...
	 3,3;...
	 4,4;...
	 5,5];
Xerr = [0.85, 1.15;...
		1.85, 2.15;...
		2.85, 3.15;...
		3.85, 4.15;...
		4.85, 5.15];

subplot(2, 2, 2);
h = bar(X, shms_mean');
ha = get(h(1), 'Parent');
set(ha, 'XTickLabel', 1:5, 'FontSize', 20);
% set(get(ha, 'XLabel'), 'String', 'Nombre de sources simultanées')
set(get(ha, 'XLabel'), 'String', '')
% set(get(ha, 'YLabel'), 'String', 'Nombre de mouvements de tête');
set(get(ha, 'YLabel'), 'String', '');
set(h(1), 'FaceColor', 'red');
set(h(2), 'FaceColor', [0 0.4470 0.7410]);

hold on;
he = errorbar(Xerr, shms_mean', shms_std', 'bx', 'Color', [0, 0, 0]);
set(he(1), 'LineWidth', 2);
set(he(2), 'LineWidth', 2);
hold off;

% ===

shms_mean = zeros(2, 4);
shms_std = zeros(2, 4);

for ii = 1:4
	shms_mean(1, ii) = mean(nb_shm7{ii}(1, :));
	shms_mean(2, ii) = mean(nb_shm7{ii}(2, :));
	shms_std(1, ii) = std(nb_shm7{ii}(1, :));
	shms_std(2, ii) = std(nb_shm7{ii}(2, :));
end

X = [1,1;...
	 2,2;...
	 3,3;...
	 4,4];
Xerr = [0.85, 1.15;...
		1.85, 2.15;...
		2.85, 3.15;...
		3.85, 4.15];

subplot(2, 2, 3);
h = bar(X, shms_mean');
ha = get(h(1), 'Parent');
set(ha, 'XTickLabel', 1:2:7, 'FontSize',20);
% set(get(ha, 'XLabel'), 'String', 'Nombre de sources simultanées');
set(get(ha, 'XLabel'), 'String', '')
% set(get(ha, 'YLabel'), 'String', 'Nombre de mouvements de tête');
set(get(ha, 'YLabel'), 'String', '');
set(h(1), 'FaceColor', 'red');
set(h(2), 'FaceColor', [0 0.4470 0.7410]);

hold on;
he = errorbar(Xerr, shms_mean', shms_std', 'bx', 'Color', [0, 0, 0]);
set(he(1), 'LineWidth', 3);
set(he(2), 'LineWidth', 2);
hold off;

% ===

shms_mean = zeros(2, 5);
shms_std = zeros(2, 5);

for ii = 1:5
	shms_mean(1, ii) = mean(nb_shm10{ii}(1, :));
	shms_mean(2, ii) = mean(nb_shm10{ii}(2, :));
	shms_std(1, ii) = std(nb_shm10{ii}(1, :));
	shms_std(2, ii) = std(nb_shm10{ii}(2, :));
end

X = [1,1;...
	 2,2;...
	 3,3;...
	 4,4;...
	 5,5];
Xerr = [0.85, 1.15;...
		1.85, 2.15;...
		2.85, 3.15;...
		3.85, 4.15;...
		4.85, 5.15];

subplot(2, 2, 4);
h = bar(X, shms_mean');
ha = get(h(1), 'Parent');
set(ha, 'XTickLabel', [1, 3, 5, 8, 10], 'FontSize', 20);
% set(get(ha, 'XLabel'), 'String', 'Nombre de sources simultanées')
set(get(ha, 'XLabel'), 'String', '')
% set(get(ha, 'YLabel'), 'String', 'Nombre de mouvements de tête');
set(get(ha, 'YLabel'), 'String', '');
set(h(1), 'FaceColor', 'red');
set(h(2), 'FaceColor', [0 0.4470 0.7410]);

hold on;
he = errorbar(Xerr, shms_mean', shms_std', 'bx', 'Color', [0, 0, 0]);
set(he(1), 'LineWidth', 2);
set(he(2), 'LineWidth', 2);
hold off;





