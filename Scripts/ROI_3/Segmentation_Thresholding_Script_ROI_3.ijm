#########
# ROI_3 # 
#########

# ROI_3 Selection #

makeRectangle(0, 308, 665, 445);

run("Duplicate...", "title=ROI_3_Main.tif duplicate");


# ROI_3 Segmentation #

//setTool("freeline");
run("Trainable Weka Segmentation");
selectImage("Trainable Weka Segmentation v4.0.0");

# Feature Selection #

call("trainableSegmentation.Weka_Segmentation.setFeature", "Variance=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Mean=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Minimum=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Maximum=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Median=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Anisotropic_diffusion=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Bilateral=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Lipschitz=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Kuwahara=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Gabor=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Derivatives=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Laplacian=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Structure=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Entropy=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Neighbors=true");
call("trainableSegmentation.Weka_Segmentation.changeClassName", "0", "Mitochondria");
call("trainableSegmentation.Weka_Segmentation.changeClassName", "1", "ER");
call("trainableSegmentation.Weka_Segmentation.setClassBalance", "true");

###########################
# Saving Probability Maps #
###########################

call("trainableSegmentation.Weka_Segmentation.getProbability");
selectImage("Probability maps");
 mapscall("trainableSegmentation.Weka_Segmentation.saveClassifier", "../ROI_3.model");
close;

###################
# ER Thresholding #
###################

run("Select path", "inputfile=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/ROI_3_ER.tif]");
selectImage("ROI_3_ER.tif");
run("16-bit");
run("Duplicate...", "duplicate");
//run("Brightness/Contrast...");
selectImage("ROI_3_ER.tif");
resetMinAndMax;
selectImage("ROI_3_ER-1.tif");
//setTool("freehand");

# Removing Extra region
//setTool("oval");
makeOval(-60, -82, 406, 242);
setBackgroundColor(0, 0, 0);
run("Clear", "stack");
setMinAndMax(35682, 39206);
run("Apply LUT", "stack");
run("Duplicate...", "title=ROI_3_B&C.tif duplicate");

run("Gaussian Blur...", "sigma=1 stack");
run("8-bit");

setAutoThreshold("Default dark no-reset");
//run("Threshold...");
selectImage("ROI_3_ER.tif");
selectImage("ROI_3_B&C.tif");
resetThreshold;
setAutoThreshold("Default dark no-reset");
setThreshold(92, 255, "raw");
setOption("BlackBackground", true);
run("Convert to Mask", "background=Dark calculate black");
run("Duplicate...", "title=ER_Thresholded duplicate");
run("Gaussian Blur...", "sigma=1 stack");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Thresholded/ER_Thresholded.tif");



run("Wavefront .OBJ ...", "stack=ER_Thresholded.tif threshold=50 resampling=2 red green blue save=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Object/ER_ROI_3.obj]");

########################
# Tubules Thresholding #
########################

run("Select path", "inputfile=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/ROI_3_Tubules.tif]");
selectImage("ROI_3_Tubules.tif");
run("16-bit");

run("Duplicate...", "duplicate");
selectImage("ROI_3_Tubules-1.tif");

//run("Brightness/Contrast...");
setMinAndMax(32159, 43882);
run("Apply LUT", "stack");
run("8-bit");
setAutoThreshold("Default dark no-reset");
//run("Threshold...");

setThreshold(127, 255, "raw");
run("Convert to Mask", "background=Dark calculate black");
run("Gaussian Blur...", "sigma=1 stack");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Thresholded/Tubules_Thresholded.tif");
run("Wavefront .OBJ ...", "stack=Tubules_Thresholded.tif threshold=50 resampling=2 red green blue save=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Thresholded/Tubules_Thresholded.tif.obj]");
run("Wavefront .OBJ ...", "stack=Tubules_Thresholded.tif threshold=50 resampling=2 red green blue save=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Object/Tubules_ROI_3.obj]");
run("Close");

#######################
# Lipids Thresholding #
#######################

run("Select path", "inputfile=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/ROI_3_Lipid-1.tif]");
selectImage("ROI_3_Lipid-1.tif");
run("16-bit");
//run("Brightness/Contrast...");
setMinAndMax(28059, 65535);
run("Apply LUT", "stack");
run("Duplicate...", "title=Lipid_B&C duplicate");

setAutoThreshold("Default dark no-reset");
//run("Threshold...");
run("Convert to Mask", "background=Dark calculate black create");

makeOval(-107, -130, 481, 354);
run("Clear", "stack");
run("Gaussian Blur...", "sigma=1 stack");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Thresholded/Lipid_Thresholded.tif");
run("Wavefront .OBJ ...", "stack=Lipid_Thresholded.tif threshold=50 resampling=2 red green blue save=[/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Object/Lipids_ROI_3.obj]");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_3/Probability Maps/Thresholded/Lipid_Thresholded.tif");
