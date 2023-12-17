function plotSParametersWithMarkers(freq, s_parameters, s_names, marker_freqs)
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

    title(sprintf('%s Magnitude (dB)', s_names));
    xlabel('Frequency (GHz)');
    ylabel('Magnitude (dB)');
    xlim([1e9,11.1e9]);

    % Customize legend with marker values
    s_names={'1L-1', '1L-2', '1L-3', '1L-4'};
    legend_str = s_names;
    for i = 1:length(marker_freqs)
         legend_str = [sprintf('\nM%d @ %.2fGHz', i, marker_freqs(i)/1e9), legend_str];
    end
    new_order = [4,3,2,1,5,6,7,8];
    reordered_legend_str = legend_str(new_order);
    legend(reordered_legend_str, 'Location', 'southwest', 'Orientation', 'Horizontal'); % Arrange legend entries vertically

end

function color = getColor(index)
    % Define custom colors for each file
    colors = { 'b', [0.5 0 0.5], [0.6 0.4 0.2], [1 0.5 0]};
    
    % Cycle through colors if there are more files than colors
    color = colors{mod(index - 1, length(colors)) + 1};
end

