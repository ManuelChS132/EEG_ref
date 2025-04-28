# EEG Re-Referencing

This Python script performs a re-referencing process on EEG data. The input is a `.csv` file containing raw EEG signals, and the re-referencing is done relative to the auricular bipole (A1 + A2). The output is a new `.csv` file containing the EEG signals after the re-referencing process.

## Description

The script reads EEG data from a `.csv` file, computes the re-referencing relative to the A1 and A2 electrodes, and saves the re-referenced data in a new `.csv` file.

### Key Steps:
1. **Read EEG Data**: Load EEG data from the specified `.csv` file.
2. **Re-referencing Process**: Compute the new reference electrode as the mean of A1 and A2, and subtract it from all channels to re-reference the data.
3. **Save Data**: Save the re-referenced EEG data to a new `.csv` file.

### Input:
- `inpath`: The folder containing the raw EEG data file.
- `filename`: The name of the `.csv` file containing raw EEG data.
- `outpath`: The folder where the re-referenced EEG data will be saved.

### Output:
- A new `.csv` file containing the re-referenced EEG data.

## Installation

You need Python 3.x installed, as well as the required libraries. You can install the required libraries by running:

```bash
pip install pandas numpy
```

## Usage Example
To run the script, execute the following command: 

```bash
python eeg_referencing.py
```
Make sure to modify the inpath, filename, and outpath variables inside the script before running it, or edit them directly in the if __name__ == "__main__": block.

### Example

```python
# Inside the script (eeg_referencing.py)
if __name__ == "__main__":
    # Input parameters
    inpath = 'EEG/'
    filename = 'EEG_P001.csv'
    outpath = 'EEG_REF/'
    
    # Call the main function with the provided parameters
    main(inpath, filename, outpath)
```
## Description of Functions:

- **main(inpath, filename, outpath)**:
  - This is the main function that coordinates the entire process.
  - **Parameters**:
    - `inpath`: The path to the folder containing the raw EEG data file.
    - `filename`: The name of the `.csv` file containing the raw EEG data.
    - `outpath`: The path to the folder where the re-referenced EEG data will be saved.
  - **Functionality**: It reads the raw EEG data, calls the re-referencing function (`add_ref`), and saves the re-referenced data using the `save_data_ref` function.

- **add_ref(data, ref_electrodes)**:
  - This function performs the re-referencing of the EEG data by calculating the new reference as the mean of the A1 and A2 electrodes.
  - **Parameters**:
    - `data`: A Pandas DataFrame containing the raw EEG data.
    - `ref_electrodes`: A list of the reference electrodes (in this case, `['A1', 'A2']`).
  - **Functionality**: 
    - Computes the mean of the A1 and A2 signals to create the new reference.
    - Removes the original reference electrodes (A1 and A2) from the data.
    - Adds a new reference channel (`Pz`) initialized to zeros.
    - Subtracts the reference signal (mean of A1 and A2) from each EEG channel to re-reference the data.

- **save_data_ref(outpath, data_ref, filename)**:
  - This function saves the re-referenced EEG data to a `.csv` file.
  - **Parameters**:
    - `outpath`: The path to the folder where the re-referenced data will be saved.
    - `data_ref`: A Pandas DataFrame containing the re-referenced EEG data.
    - `filename`: The name of the output `.csv` file.
  - **Functionality**: 
    - Checks if the specified output directory exists, and if not, creates it.
    - Saves the re-referenced data to the specified path with the provided filename.
    - Prints a confirmation message ("Done.") when the process is complete.

## Requirements

This code is designed to work with EEG data from the dataset published at [https://doi.org/10.17632/2pw2m39yct.1](https://doi.org/10.17632/2pw2m39yct.1). 
