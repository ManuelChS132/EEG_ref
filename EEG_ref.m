%{
This MATLAB code performs a re-referencing process on EEG data.
The input is the name of a .csv file containing raw EEG signals, which can be obtained from the publicly available dataset at 10.17632/2pw2m39yct.1.
The re-referencing is specifically done relative to the auricular bipole (A1 + A2).
The output is a new .csv file containing the EEG signals after the re-referencing process.

Inputs:
- inpath: the folder name where the EEG data is stored.
- filename: the name of the .csv file containing the EEG data to be re-referenced.
- outpath: the folder name where the re-referenced EEG data will be saved.

%}
function EEG_ref(inpath, filename, outpath)
    % Read the raw EEG data from the provided .csv file.
    data_table = readtable(inpath + filename, "VariableNamingRule","preserve");
    
    % Define the electrodes for the reference (auricular bipole A1 + A2).
    ref_electrodes = {'A1', 'A2'};
    
    % Call the function to perform the re-referencing process.
    data_ref = add_ref(data_table, ref_electrodes);
    
    % Save the re-referenced data to the specified output folder.
    save_data_ref(outpath, data_ref, filename)

    % This function performs the re-referencing process on the EEG data.
    function data_ref = add_ref(data, ref_electrodes)
        % Calculate the new reference electrode (the mean of A1 and A2 signals).
        ref_data = mean(table2array(data(:, ref_electrodes)), 2);

        % Remove the original reference channels (A1 and A2).
        data = removevars(data, ref_electrodes);

        % Create a new channel 'Pz' initialized with zeros.
        new_ref = zeros(height(data), 1);
        data.Pz = new_ref;

        % Get the re-referenced EEG data by subtracting the reference data (A1 + A2 mean).
        data_ref_array = table2array(data);
        data_ref_array = data_ref_array - ref_data;  % Perform the re-referencing operation (row by row).

        electrodes = data.Properties.VariableNames;
        data_ref = array2table(data_ref_array, "VariableNames",electrodes);
    end
    
    % This function saves the re-referenced EEG data to the specified output path.
    function save_data_ref(outpath, data_ref, filename)
        % Check if the output directory exists; if not, create it.
        if ~exist(outpath, 'dir')
            mkdir(outpath);
        end
        
        % Save the re-referenced data to a .csv file in the output folder.
        writetable(data_ref, outpath + filename);
        
        % Display a message to indicate that the process is complete.
        disp("Done.");
    end
end
