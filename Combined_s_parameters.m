clc; clear all; close all;

% Define the file names of your S-parameter files
% fileNames = {'1L-1.s2p', '1L-2.s2p', '1L-3.s2p', '1L-4.s2p'};

% Specify the folder where your files are located
folderPath = 'C:\Ranatec\S-parameters';

% Specify the common part of the file names
commonName = '1L-';

% Specify the number of files you have for each set (e.g., 4)
numFilesPerSet = 4;

% Initialize cell array to store file names
fileNames = cell(1, numFilesPerSet);

% Loop to generate file names
for i = 1:numFilesPerSet
    % Create the full file name
    fullFileName = sprintf('%s%d.s2p', commonName, i);

    % Add to the cell array
    fileNames{i} = fullFileName;
end

% Initialize S-parameter data matrices
s11_combined = [];
s21_combined = [];
s12_combined = [];
s22_combined = [];

% Loop through each file and load S-parameter data
for i = 1:length(fileNames)
    % Load S-parameter data from the file
    data = read(rfdata.data, fileNames{i});
    
    % Extract S-parameter matrices
    s_parameters = data.S_Parameters;

    % Extract S11, S21, S12, S22
    s11 = squeeze(s_parameters(1, 1, :));
    s21 = squeeze(s_parameters(2, 1, :));
    s12 = squeeze(s_parameters(1, 2, :));
    s22 = squeeze(s_parameters(2, 2, :));
    
    % Concatenate S-parameters to the combined matrices
    s11_combined = [s11_combined, s11];
    s21_combined = [s21_combined, s21];
    s12_combined = [s12_combined, s12];
    s22_combined = [s22_combined, s22];
end

% Frequency vector (assuming all files have the same frequency points)
freq = data.Freq;

% Defining frequencies for markers
marker_freqs = [2.4, 4, 6, 8];
% 
% 
% % Magnitude S11
% plotSParametersWithMarkers(freq/1e9, s11_combined, 'S11', marker_freqs,-13);
% 
% Magnitude S21
plotSParametersWithMarkers(freq/1e9, s21_combined, 'S21', marker_freqs, -8);
% 
% % Magnitude S12
% plotSParametersWithMarkers(freq/1e9, s12_combined, 'S12', marker_freqs, -8);
% 
% % Magnitude S22
% plotSParametersWithMarkers(freq/1e9, s22_combined, 'S22', marker_freqs, -13);

figure;

% plot(freq/1e9, angle(s21_combined)*180/pi);
grid on;
hold on;
ang = angle(s21_combined)*180/pi;
for p = 1:size(s21_combined, 2)
    plot(freq/1e9, (ang(:, p)) , 'Color', getColor(p), 'LineWidth', 1);
end
% xlim([0 11.1])
ylim([-200 200]);
xline([2.4, 8], '-- r', 'LineWidth', 2);
title('S21 Phase (degrees)');

% Calculate phase differences relative to '1L-1'
reference_phase = angle(s21_combined(:, 1));
phase_diff = angle(s21_combined) - reference_phase;

% Wrap the phase differences to the range -180 to 180 degrees
phase_diff_wrapped = wrapTo180(phase_diff * (180 / pi));

% Plotting
figure;
grid on;
hold on;
for m = 1:size(phase_diff_wrapped, 2)
    plot(freq/1e9, (phase_diff_wrapped(:, m)), 'Color', getColor(m), 'LineWidth', 1);
end
freq_mask = [2.4, 8];
fill([freq_mask(1), freq_mask(1), freq_mask(2), freq_mask(2)], [250, 145, 145, 250], 'k', 'FaceAlpha', 0.15);
fill([freq_mask(1), freq_mask(1), freq_mask(2), freq_mask(2)], [-10, -180, -180, -10], 'k', 'FaceAlpha', 0.15);
xlim([1, 11.1]);
ylim([-180 250]);
% xline([2.4, 8], '--black', 'LineWidth', 1.5);

title('Phase Differences Relative to 1L-1 (degrees)');
xlabel('Frequency (GHz)');
ylabel('Phase Difference (degrees)');
s_names={'1L-1', '1L-2', '1L-3', '1L-4'};
legend(s_names, 'Location', 'southwest', 'Orientation', 'Horizontal');














































% Plot the combined S-parameters
% figure;
% subplot(2, 2, 1);
% plot(freq, 20*log10(abs(s11_combined)));
% title('S11 Magnitude (dB)');
% subplot(2, 2, 2);
% plot(freq, 20*log10(abs(s21_combined)));
% title('S21 Magnitude (dB)');
% subplot(2, 2, 3);
% plot(freq, 20*log10(abs(s12_combined)));
% title('S12 Magnitude (dB)');
% subplot(2, 2, 4);
% plot(freq, 20*log10(abs(s22_combined)));
% title('S22 Magnitude (dB)');
% 
% % Add labels and legend if needed
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');

% S11 Magnitude(dB)
% figure;
% plot(freq, 20*log10(abs(s11_combined)));
% grid on;
% title('S11 Magnitude (dB)');
% xlabel('Frequency (GHz)');
% ylabel('Magnitude (dB)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');
% 
% % S21 Magnitude(dB)
% figure;
% plot(freq, 20*log10(abs(s21_combined)))
% grid on;
% title('S21 Magnitude (dB)')
% xlabel('Frequency (GHz)');
% ylabel('Magnitude (dB)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');
% 
% % S12 Magnitude(dB)
% figure;
% plot(freq, 20*log10(abs(s12_combined)))
% grid on;
% title('S12 Magnitude (dB)')
% xlabel('Frequency (GHz)');
% ylabel('Magnitude (dB)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');
% 
% 
% % S22 Magnitude(dB)
% figure;
% plot(freq, 20*log10(abs(s22_combined)))
% grid on;
% title('S22 Magnitude (dB)')
% xlabel('Frequency (GHz)');
% ylabel('Magnitude (dB)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');


% Phase plots
% figure;
% 
% subplot(2, 2, 1);
% plot(freq, angle(s11_combined)*180/pi); % Convert radians to degrees
% title('S11 Phase (degrees)');
% subplot(2, 2, 2);
% plot(freq, angle(s21_combined)*180/pi);
% title('S21 Phase (degrees)');
% subplot(2, 2, 3);
% plot(freq, angle(s12_combined)*180/pi);
% title('S12 Phase (degrees)');
% subplot(2, 2, 4);
% plot(freq, angle(s22_combined)*180/pi);
% title('S22 Phase (degrees)');
% 
% Add labels and legend if needed
% xlabel('Frequency (Hz)');
% ylabel('Phase (degrees)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');

