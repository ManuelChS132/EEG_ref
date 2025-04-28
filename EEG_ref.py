import pandas as pd
import numpy as np
import os

def main(inpath, filename, outpath):
    # Read EEG data from the provided .csv file
    data_table = pd.read_csv(os.path.join(inpath, filename))
    
    # Define the reference electrodes (auricular bipole A1 + A2)
    ref_electrodes = ['A1', 'A2']
    
    # Call the function to perform the re-referencing process
    data_ref = add_ref(data_table, ref_electrodes)
    
    # Save the re-referenced data to the output folder
    save_data_ref(outpath, data_ref, filename)

def add_ref(data, ref_electrodes):
    # Calculate the new reference electrode (the mean of A1 and A2 signals)
    ref_data = data[ref_electrodes].mean(axis=1)
    
    # Remove the original reference channels (A1 and A2)
    data = data.drop(columns=ref_electrodes)
    
    # Create a new 'Pz' channel initialized with zeros
    data['Pz'] = np.zeros(len(data))
    
    # Obtain the re-referenced EEG data by subtracting the reference data (mean of A1 and A2)
    data_ref_array = data.values - ref_data.values[:, np.newaxis]  # Subtract row by row
    
    # Create a new DataFrame with the re-referenced data
    data_ref = pd.DataFrame(data_ref_array, columns=data.columns)
    
    return data_ref

def save_data_ref(outpath, data_ref, filename):
    # Check if the output directory exists; if not, create it
    if not os.path.exists(outpath):
        os.makedirs(outpath)
    
    # Save the re-referenced data to a .csv file in the output folder
    data_ref.to_csv(os.path.join(outpath, filename), index=False)
    
    # Display a message indicating that the process is complete
    print("Done.")

# Check if the script is being run directly
if __name__ == "__main__":
    # Input parameters
    inpath = 'EEG/'
    filename = 'EEG_P001.csv'
    outpath = 'EEG_ref/'
    
    # Call the main function with the provided parameters
    main(inpath, filename, outpath)
