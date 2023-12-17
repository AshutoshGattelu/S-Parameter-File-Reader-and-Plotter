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
marker_freqs = [2.4e9, 4e9, 6e9, 8e9];

% Magnitude S11
plotSParametersWithMarkers(freq, s11_combined, 'S11', marker_freqs);

% Magnitude S21
plotSParametersWithMarkers(freq, s21_combined, 'S21', marker_freqs);

% Magnitude S12
plotSParametersWithMarkers(freq, s12_combined, 'S12', marker_freqs);

% Magnitude S22
plotSParametersWithMarkers(freq, s22_combined, 'S22', marker_freqs);


















































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
% % Add labels and legend if needed
% xlabel('Frequency (Hz)');
% ylabel('Phase (degrees)');
% legend('1L-1', '1L-2', '1L-3', '1L-4');

