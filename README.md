# Microvilli_ER_vEM

[![DOI](https://zenodo.org/badge/1015897714.svg)](https://doi.org/10.5281/zenodo.20550192)

Volume electron microscopy (vEM) analysis of microvilli and ER across three regions of interest (ROIs).

Alexander Ludwig – Low Kay En

<img width="612" height="504" alt="image" src="https://github.com/user-attachments/assets/ba211b1b-53f4-4cb9-b52f-cca716da0267" />

## Contents

- **Scripts/Preprocessing_Main/Pre_Processing.ijm** — ImageJ macro: invert stack, set voxel size, adjust brightness/contrast, 2× XY rebinning, export preprocessed TIFF.
- **Scripts/ROI_1, ROI_2, ROI_3/** — ImageJ macros for per-ROI cropping, Trainable Weka segmentation (classifier saved as `.model`), probability-map thresholding of structures (microvilli/tubules and ER), and export to Wavefront `.obj`.
- **Blender_Files/ROI_1, ROI_2, ROI_3/** — Blender scenes of the segmented 3D meshes for rendering.
- **Quantification_BoneJ/Quantification.xlsx** — BoneJ measurements per ROI: bone volume (BV), total volume (TV), BV/TV, surface area, and surface-to-volume ratio (SVR).
