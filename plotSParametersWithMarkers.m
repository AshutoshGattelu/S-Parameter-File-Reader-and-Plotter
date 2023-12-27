function plotSParametersWithMarkers(freq, s_parameters, s_names, marker_freqs, limit_value)
    figure;
    hold on;
    grid on;
   
    % Add markers at specific frequencies
    for i = 1:length(marker_freqs)
        [~, idx] = min(abs(freq - marker_freqs(i)));
        marker_value = 20*log10(abs(s_parameters(idx)));
        plot(freq(idx), marker_value, 'rv', 'MarkerFaceColor', 'r', 'LineWidth', 1); % Red triangle marker
        text(freq(idx), marker_value, sprintf('M%d', i), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end

    % Plot individual files with custom colors
    for j = 1:size(s_parameters, 2)
        plot(freq, 20*log10(abs(s_parameters(:, j))), 'Color', getColor(j), 'LineWidth', 1); % Get custom color for each file
    end
 % Frequency mask
 if limit_value ~= -13
    freq_mask = [2.4, 8];
    fill([freq_mask(1), freq_mask(1), freq_mask(2), freq_mask(2)], [0, -5, -5, 0], 'k', 'FaceAlpha', 0.15);
    fill([freq_mask(1), freq_mask(1), freq_mask(2), freq_mask(2)], [-8, -20, -20, -8], 'k', 'FaceAlpha', 0.15);
 else
     freq_mask = [2.4, 8];
     fill([freq_mask(1), freq_mask(1), freq_mask(2), freq_mask(2)], [-13, -20, -20, -13], 'k', 'FaceAlpha', 0.15);
 end

%     % Add limit line
%     yline(limit_value, '--r', 'LineWidth', 1.5);
% 
%     % Display the limit value on the plot
%     text(freq(1), limit_value, sprintf('%.2f', limit_value), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

    title(sprintf('%s Magnitude (dB)', s_names));
    xlabel('Frequency (GHz)');
    ylabel('Magnitude (dB)');
    xlim([1, 11.1]);
    ylim([-20, 0]);

    % Customize legend with marker values
    s_names={'1L-1', '1L-2', '1L-3', '1L-4'};
    legend_str = s_names;
    for i = 1:length(marker_freqs)
        legend_str = [sprintf('\nM%d @ %.1f GHz', i, marker_freqs(i)), legend_str];
    end
    new_order = [4, 3, 2, 1, 5, 6, 7, 8];
    reordered_legend_str = legend_str(new_order);
    legend(reordered_legend_str, 'Location', 'southwest', 'Orientation', 'Horizontal'); % Arrange legend entries vertically

end


