idxs = randperm(nb_sources);

timeline{1} = 1;
timeline{2} = 1;
timeline{3} = 1;

for iSource = 1:nb_simultaneous_sources
	t_silence = randi(info.cpt_silence, 1);
	timeline{idxs(iSource)}(end+1) = t_silence;
	
	t_object = randi(info.cpt_object, 1);
	timeline{idxs(iSource)}(end+1) = t_object+t_silence;
end







	idx_beg = arrayfun(@(x) timeline_all{x}(2), 1:info.nb_sources);
	[~, idx_beg] = min(idx_beg);

	new_tline = timeline_all;
	
	iStep = new_tline{idx_beg}(2)+1;
	while iStep <= info.nb_steps
	% for iStep = new_tline{idx_beg}(2)+1:info.nb_steps
		tt = cell2mat(arrayfun(@(x) find(new_tline{x} <= iStep, 1, 'last'), 1:info.nb_sources, 'UniformOutput', false));
		if sum(mod(tt, 2) == 0) > info.nb_simultaneous_sources && ~isempty(tt)
			tmp = find(mod(tt, 2) == 0);
			tmp2 = arrayfun(@(x) iStep - new_tline{x}(tt(x)), tmp);
			tmp3 = find(tmp2 > info.cpt_object(1));
			if ~isempty(tmp3)
				for iSource = 1:numel(tmp3)
					idx = tmp(tmp3(iSource));
					new_tline{idx}(tt(idx)+1) = iStep;
				end
				% sources_to_shift = tmp(tmp3);
			else
				[~, pos] = min(tmp2);
				sources_to_shift = tmp(pos);
			end
			
			for iSource = 1:numel(sources_to_shift)
				idx = sources_to_shift(iSource);
				new_tline{idx}(tt(idx):end) = new_tline{idx}(tt(idx):end)+1;
			end
		else
			iStep = iStep + 1;
		end
		iStep
	end
	

new_tline = arrayfun(@(x) new_tline{x}(new_tline{x} <= info.nb_steps), 1:numel(new_tline), 'UniformOutput', false)


for iSource = 1:numel(new_tline)
	if numel(new_tline{iSource}) > 1
		if mod(numel(new_tline{iSource}), 2) == 0
			if numel(new_tline{iSource}(end):info.nb_steps) >= info.cpt_object(1)
				new_tline{iSource}(end+1) = info.nb_steps;
			else
				new_tline{iSource}(end) = 200;
			end
		else
			if new_tline{iSource}(end) ~= info.nb_steps
				new_tline{iSource}(end+1) = info.nb_steps;
			end
		end
	else
		new_tline{iSource}(end+1) = info.nb_steps;
	end
end

idx_beg = arrayfun(@(x) new_tline{x}(2), 1:info.nb_sources);
[~, idx_beg] = min(idx_beg);

cpt_all = zeros(1, info.nb_steps);

for iStep = 13:info.nb_steps
	cpt = 0;
	for iSource = 1:info.nb_sources
		tmp = find(new_tline{iSource} <= iStep, 1, 'last');
		if mod(tmp, 2) == 0
			cpt = cpt+1;
		end
	end
	cpt_all(iStep) = cpt;
end



figure('Color', 'white');
hold on;

sources_labels = {};

for iSource = 1:info.nb_sources
	if numel(new_tline{iSource}) > 2
		iTimeline = new_tline{iSource};
		vec = zeros(1, info.nb_steps)+0.1;
		iStep = 2;
		while iStep < numel(iTimeline)
			idx = iTimeline(iStep):iTimeline(iStep+1);
			vec(idx) = 0.9;
			if iStep+2 < numel(iTimeline)
				iStep = iStep + 2;
			else
				iStep = iStep + 3;
			end
		end
	else
		vec = zeros(1, info.nb_sources)+0.1;
	end
	plot(vec-iSource, 'LineWidth', 2);

	% tmp_label = htm.gtruth{iSource}(iTimeline(2), 1);
	% uscore = cell2mat(strfind(tmp_label, '_'));
	% sources_labels(end+1) = {[tmp_label{1}(1:uscore-1), ' ', tmp_label{1}(uscore+1:end)]};
end

set(gca, 'YTick', (2*info.nb_sources-1)*(-0.5):-0.5,...
		'FontSize', 16,...
		'Box', 'on',...
		'YTickLabel', sources_labels,...
		'XGrid', 'on');


