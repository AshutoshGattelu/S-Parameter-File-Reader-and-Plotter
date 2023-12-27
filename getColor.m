function color = getColor(index)
    % Define custom colors for each file
    colors = { 'b', [0.5 0 0.5], [0.6 0.4 0.2], [1 0.5 0]};

    % Cycle through colors if there are more files than colors
    color = colors{mod(index - 1, length(colors)) + 1};
end