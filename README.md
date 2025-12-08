# DAVE VKGL VUS Pathogenicity Viewer

This Streamlit app provides an interactive interface for exploring DAVE pathogenicity predictions of Variants of Uncertain Significance (VUS) from the VKGL consensus datasharing. It integrates data visualization, protein structure modeling, and molecular feature analysis to support variant interpretation in a clinical genomics context.

Our article is now in preprint! [https://doi.org/10.1101/2025.11.25.25340947](https://doi.org/10.1101/2025.11.25.25340947)

---

## Features

- 🔍 Searchable and filterable VUS table from VKGL dataset
- 📊 Force plot visualization of DAVE LP probability contribution scores.
- 🧪 3D visualization of wild-type and mutant proteins using Py3Dmol

---

## File Requirements

Ensure the following files and directories are present in the working directory:

- `vkgl_apr2024_VUS_pred.csv`: VUS prediction data downloaded from: https://github.com/molgenis/dave/blob/main/data/vkgl_apr2024_VUS_pred.csv.gz
- `mut_wt_structures_vkgl_vus.tar.gz`: AlphaFold wild-type and mutant PDB files downloaded from: https://zenodo.org/records/17435480/files/mut_wt_structures_vkgl_vus.tar.gz

---

## Installation

Get the github repo:
```bash
git clone https://github.com/Timniem/dave_streamlit
```

Download files:
```bash
# Go into the downloaded repository:
cd dave_streamlit
# Download the required files: 
wget https://github.com/molgenis/dave/blob/main/data/vkgl_apr2024_VUS_pred.csv.gz
wget https://zenodo.org/records/17435480/files/mut_wt_structures_vkgl_vus.tar.gz
#or curl using:
#curl -O https://github.com/molgenis/dave/blob/main/data/vkgl_apr2024_VUS_pred.csv.gz
#curl -O https://zenodo.org/records/17435480/files/mut_wt_structures_vkgl_vus.tar.gz
```

Install required Python packages (Recommended: use a Python virtual environment or Conda environment):

```bash
pip install streamlit matplotlib pandas numpy py3Dmol plotly

```

## Running the streamlit server

```bash

cd /location/of/dave_streamlit

streamlit run main.py

# Optionally change the port with --server.port

```

## Example NKX2-5 L153P:

![table](images/table.png)

![force_plot](images/explain_plot.png)

![force_plot](images/py3dmol.png)
