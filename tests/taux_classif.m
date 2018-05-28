
nb_steps = 1000;

data_classif(1, 5) = struct('stats', [],...
							'etime', 0,...
							'focus', [],...
							'timeline', [],...
							'labels', []);

cfile = 61:65;
nb_sources = 3;
for iData = 1:5
	
	
	CONFIG_FILE = cfile(iData);

	data_classif(iData).angles_cpt = cell(1, 5);

	data_classif(iData).stats = struct('mfi1', zeros(nb_steps, 5),...
							   'mfi2', zeros(nb_steps, 5),...
							   'max1', zeros(nb_steps,5),...
							   'max2', zeros(nb_steps,5));
	data_classif(iData).focus = zeros(nb_steps, 5);

	data_classif(iData).timeline = cell(1, 5);
	data_classif(iData).labels = cell(1, 5);
	data_classif(iData).etime = 0;

	for ii = 1:5
		disp(['CONFIG FILE : ', num2str(iData)])
		disp(['SIMULATION : ', num2str(ii)])
		startHTM_simulation;
		data_classif(iData).stats.mfi1(:, ii) = htm.statistics.mfi_mean(:, end);
		data_classif(iData).stats.mfi2(:, ii) = htm.statistics.mfi_mean2(:, end);
		data_classif(iData).stats.max1(:, ii) = htm.statistics.max_mean(:, end);
		data_classif(iData).stats.max2(:, ii) = htm.statistics.max_mean2(:, end);
		data_classif(iData).angles_cpt{ii} = htm.FCKS.naive_focus;
		data_classif(iData).etime = htm.elapsed_time + data_classif(iData).etime;
		data_classif(iData).focus(:, ii) = htm.FCKS.focus';
		tline = getInfo('timeline');
		data_classif(iData).timeline{:, ii} = tline;
		data_classif(iData).labels{:, ii} = arrayfun(@(x) htm.gtruth{x}(tline{x}(2), 1), 1:nb_sources);
		% data_classif(iData).naive_shm = htm.naive_shm;
	end
	data_classif(iData).etime = data_classif(iData).etime/5;
end

nb_steps = size(data_classif(1).stats.mfi1, 1);
t = (1:nb_steps)';
colors = [0, 1, 1 ;...
		  0, 0.7, 1;...
		  0, 0.4, 0.8;...
		  0, 0, 0.6];

bar_data = [0, 0];

for iData = 1:5
	hf = figure('Color', 'white');
	ha = axes('Parent', hf, 'FontSize', 20);
	% ha = subplot(1, 6, [1:4]);
	hold on;

	x_mfi1 = data_classif(iData).stats.mfi1;
	x_mfi2 = data_classif(iData).stats.mfi2;
	x_max1 = data_classif(iData).stats.max1;
	x_max2 = data_classif(iData).stats.max2;

	% ===
	s_min = min(x_mfi1')';
	s_max = max(x_mfi1')';	
	m = mean(x_mfi1, 2);

	X = [t', fliplr(t')];
	Y = [s_min', fliplr(s_max')];

	h1 = fill(X, Y, colors(1, :));
	set(h1, 'EdgeAlpha', 0);
	alpha(0.8)

	std_all1 = mean(std(x_mfi1'));
	dd1 = mean(x_mfi1(end, :));

	plot(t, m);

	% ===
	s_min = min(x_mfi2')';
	s_max = max(x_mfi2')';	
	m = mean(x_mfi2, 2);

	X = [t', fliplr(t')];
	Y = [s_min', fliplr(s_max')];

	h2 = fill(X, Y, colors(2, :));
	set(h2, 'EdgeAlpha', 0);
	alpha(0.8)
	plot(t, m);

	std_all2 = mean(std(x_mfi2'));
	dd2 = mean(x_mfi2(end, :));


	% ===
	s_min = min(x_max1')';
	s_max = max(x_max1')';	
	m = mean(x_max1, 2);

	X = [t', fliplr(t')];
	Y = [s_min', fliplr(s_max')];

	h3 = fill(X, Y, colors(3, :));
	set(h3, 'EdgeAlpha', 0);
	alpha(0.8)
	 
	std_all3 = mean(std(x_max1'));
	dd3 = mean(x_max1(end, :));


	plot(t, m);

	% ===
	s_min = min(x_max2')';
	s_max = max(x_max2')';	
	m = mean(x_max2, 2);

	X = [t', fliplr(t')];
	Y = [s_min', fliplr(s_max')];

	h4 = fill(X, Y, colors(4, :));
	set(h4, 'EdgeAlpha', 0);
	alpha(0.8)

	std_all4 = mean(std(x_max2'));
	dd4 = mean(x_max2(end, :));
	plot(t, m);

	% figure;
	bar_data = [bar_data ;...
				dd1, std_all1 ;...
			    dd2, std_all2 ;...
			    dd3, std_all3 ;...
			    dd4, std_all4 ;...
			    0, 0];
	set(ha, 'YLim', [0, 1]);
end


bar_data(1, :) = [];

close all;

% ============== %

colors = [0, 1  , 1 ;...
		  0, 0.75, 1;...
		  0, 0.5, 1;...
		  0, 0, 1];

figure('Color', 'white');
hb = bar(vec);
set(gca, 'XLim', [0.6, 5.4], 'FontSize', 20);
hold on;
line([0.5, 5.5], [1, 1], 'LineWidth', 3, 'LineStyle', '--', 'Color', 'k');

set(hb(1), 'FaceColor', colors(1, :), 'EdgeColor', 'none');
set(hb(2), 'FaceColor', colors(2, :), 'EdgeColor', 'none');
set(hb(3), 'FaceColor', colors(3, :), 'EdgeColor', 'none');
set(hb(4), 'FaceColor', colors(4, :), 'EdgeColor', 'none');

set(gca, 'XTickLabels', '',...
		 'XTick', '',...
		 'YGrid', 'on',...
		 'YMinorGrid', 'on');



% ============== %
iData = 1;
figure('Color', 'white');
xx = iData;
h = bar(1, bar_data(iData, 1), 'FaceColor', colors(1, :), 'EdgeColor', 'none');
hold on;
for iData = 2:4
	xx = iData;
	bar(xx, bar_data(iData, 1), 'FaceColor', colors(xx, :), 'EdgeColor', 'none');
	set(gca, 'XTick', 1:4, 'XTickLabels', 0.1:0.3:1, 'FontSize', 20, 'YLim', [0, 1], 'XLim', [0.7, 4.3]);
end



colors = [0, 1, 1 ;...
		  0, 0.7, 1;...
		  1, 0.6, 0.6;...
		  1, 0, 0];

figure('Color', 'white');
hold on;
for iData = 1:4
	bar(iData :5: (4*5)+iData, bar_data(iData:5:end, 1), 0.18, 'FaceColor', colors(iData, :), 'EdgeColor', 'none');
end
set(gca, 'XTick', [2.5, 7.5, 12.5, 17.5, 22.5], 'XTickLabels', 0.1:0.2:0.9, 'FontSize', 28)


for iData = 2:4
	xx = iData;
	bar(xx, bar_data(iData, 1), 'FaceColor', colors(xx, :), 'EdgeColor', 'none');
	set(gca, 'XTick', 1:4, 'XTickLabels', 0.1:0.3:1, 'FontSize', 20, 'YLim', [0, 1], 'XLim', [0.7, 4.3]);
end