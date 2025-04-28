# README: Re-referencing EEG Data

## Overview

This MATLAB code performs a re-referencing process on EEG data. It reads raw EEG signals from a `.csv` file, re-references the data relative to the auricular bipole (A1 + A2), and saves the re-referenced data to a new `.csv` file. The re-referencing procedure is useful in EEG signal processing to improve the quality of data by removing the influence of common reference electrodes.

### Inputs:
- **inpath**: The folder path where the EEG data file is stored (e.g., `'EEG/'`).
- **filename**: The name of the `.csv` file containing the raw EEG data that needs to be re-referenced (e.g., `'EEG_P001.csv'`).
- **outpath**: The folder path where the re-referenced EEG data will be saved (e.g., `'EEG_REF/'`).

### Output:
- A `.csv` file containing the EEG signals after the re-referencing process. This file will be saved in the specified **outpath**.

### Process:
1. **Input Data**: The raw EEG data is read from the provided `.csv` file.
2. **Re-referencing**: The re-referencing process is performed using the average of the A1 and A2 electrode signals (auricular bipole). The original A1 and A2 channels are removed, and a new channel `Pz` (with zeros) is added.
3. **Output**: The re-referenced EEG data is saved in the specified output folder.

---

## Code Explanation

### Main Function: `EEG_ref(inpath, filename, outpath)`
This function orchestrates the entire re-referencing process. It:
- Reads the raw EEG data from the `.csv` file located at `inpath + filename`.
- Calls the function `add_ref` to perform the re-referencing.
- Saves the re-referenced data using the function `save_data_ref`.

### Sub-function: `add_ref(data, ref_electrodes)`
This function performs the re-referencing process:
- It calculates the new reference as the mean of the signals from electrodes A1 and A2.
- It removes the A1 and A2 electrodes from the data.
- It adds a new channel `Pz` initialized with zeros.
- It returns the re-referenced data as a table with the original column names.

### Sub-function: `save_data_ref(outpath, data_ref, filename)`
This function saves the re-referenced EEG data to a `.csv` file:
- It checks if the `outpath` folder exists; if not, it creates the folder.
- It writes the re-referenced data to a `.csv` file with the same name as the input file.

---

## Usage Example

### 1. Prepare your input data:
Ensure you have the raw EEG data stored in a `.csv` file. For example, let's assume:
- Folder path: `'EEG/'`
- File name: `'EEG_P001.csv'`
  
### 2. Call the function:

```matlab
inpath = 'EEG/';
filename = 'EEG_P001.csv';
outpath = 'EEG_REF/';
EEG_ref(inpath, filename, outpath);
```

### 3. Output:
After running the function, a new file called `EEG_P001.csv` will be saved in the `re_referenced/` folder, containing the re-referenced EEG data.

---

## Requirements:
- MATLAB R2018b or later.
- The raw EEG data should be in `.csv` format with proper column names for electrodes.
- This code is designed to be used with the EEG data from the publicly available dataset at (https://doi.org/10.17632/2pw2m39yct.1).

---

## Notes:
- The re-referencing is done on a row-by-row basis, meaning the reference signal (mean of A1 and A2) is subtracted from each row of EEG data.

---

