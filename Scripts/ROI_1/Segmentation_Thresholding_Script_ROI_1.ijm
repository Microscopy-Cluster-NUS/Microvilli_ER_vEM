#########
# ROI_1 #
#########
selectImage("3_Rebin.tif");
run("Duplicate...", "title=158-212 duplicate range=158-212");
makeRectangle(47, 17, 321, 226);
run("Duplicate...", "title=ROI_1_Raw duplicate");

###########################
# Segmentation Using Weka #
###########################
//setTool("freeline");
run("Trainable Weka Segmentation");
selectImage("Trainable Weka Segmentation v4.0.0");

#####################
# Feature Selection #
#####################

call("trainableSegmentation.Weka_Segmentation.setFeature", "Variance=true");
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
call("trainableSegmentation.Weka_Segmentation.changeClassName", "1", "Others");
call("trainableSegmentation.Weka_Segmentation.setClassBalance", "true");

# Probability map
call("trainableSegmentation.Weka_Segmentation.getProbability");
selectImage("Probability maps");
 mapscall("trainableSegmentation.Weka_Segmentation.saveClassifier", "../Model_1.model");
close;

########################################
# Thresholding to obtain Segmentations #
########################################
# ROI_1 Lipid Thresholding

selectImage("Probability maps.tif");
run("Duplicate...", "title=Lipid_Maps duplicate channels=3");
run("Duplicate...", "duplicate");
selectImage("Lipid_Maps");
selectImage("Lipid_Maps-1");
run("16-bit");
//run("Brightness/Contrast...");
setMinAndMax(24600, 40359);
run("Apply LUT", "stack");
run("Close");
setOption("ScaleConversions", true);
run("8-bit");
run("Smooth", "stack");
setAutoThreshold("Default dark no-reset");
//run("Threshold...");
setThreshold(113, 255, "raw");
run("Convert to Mask", "background=Dark calculate black");
run("Gaussian Blur...", "sigma=1 stack");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_1/Lipids_Thresholded_ROI_1.tif");
close;
close;


# Tubules Thresholding

run("Duplicate...", "title=Tubules_Maps duplicate channels=5");
run("Duplicate...", "duplicate");
selectImage("Tubules_Maps");
selectImage("Tubules_Maps-1");


run("16-bit");
//run("Brightness/Contrast...");
setMinAndMax(31244, 37346);
run("Apply LUT", "stack");
//setTool("freehand");
setBackgroundColor(0, 0, 0);
run("Clear", "stack");
selectImage("Tubules_Maps");
selectImage("Tubules_Maps-1");
run("Clear", "stack");
selectImage("Tubules_Maps");
run("Close");
selectImage("Tubules_Maps-1");
run("Clear", "stack");
selectImage("Tubules_Maps");
selectImage("Tubules_Maps-1");
run("Clear", "stack");
run("Clear", "stack");
selectImage("Tubules_Maps");
//setTool("rectangle");
makeRectangle(156, 247, 149, 115);
selectImage("Tubules_Maps-1");
run("Clear", "stack");
makeRectangle(57, 257, 149, 115);
makeRectangle(36, 280, 177, 95);
makeRectangle(57, 279, 177, 95);
makeRectangle(57, 218, 177, 156);
makeRectangle(8, 197, 177, 156);
makeRectangle(27, 197, 158, 142);
makeRectangle(0, 169, 158, 142);
run("Clear", "stack");
makeRectangle(62, 240, 158, 142);
run("Clear", "stack");
makeRectangle(0, 240, 158, 142);
makeRectangle(0, 298, 68, 84);

//setTool("oval");
makeOval(9, 291, 82, 92);
makeOval(-7, 295, 82, 92);
makeOval(-7, 296, 87, 91);
makeOval(-11, 296, 87, 91);
//setTool("freehand");
run("Clear", "stack");
//setTool("oval");
makeOval(386, 282, 83, 25);
makeOval(386, 277, 83, 25);
makeOval(131, 32, 20, 27);
makeOval(117, 21, 34, 38);
makeOval(125, 19, 34, 38);
makeOval(125, 19, 40, 47);
makeOval(125, 19, 51, 47);
makeOval(124, 14, 51, 47);
makeOval(97, 14, 78, 64);
makeOval(97, 14, 75, 59);
run("Clear", "stack");
run("Smooth", "stack");
run("Gaussian Blur...", "sigma=1 stack");
run("16-bit");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Default dark no-reset");
//run("Threshold...");
selectImage("Tubules_Maps");
doCommand("Start Animation [\\]");
selectImage("Tubules_Maps");
doCommand("Start Animation [\\]");
selectImage("Tubules_Maps-1");
setThreshold(128, 255, "raw");
run("Convert to Mask", "background=Dark calculate black");
run("Gaussian Blur...", "sigma=1.5 stack");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_1/Tubules_Thresholded_ROI_1.tif");

#ER thresholding 

run("Select path", "inputfile=/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_1/Probability maps.tif");


selectImage("Probability maps");
selectImage("ER_Map_ROI_1.tif");
close;
resetThreshold;
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_1/Probability maps.tif");
run("Duplicate...", "duplicate channels=2");
resetThreshold;
run("16-bit");

//run("Brightness/Contrast...");
resetMinAndMax;
resetMinAndMax;
setMinAndMax(22531, 34301);
run("Apply LUT", "stack");
run("Close");
setOption("ScaleConversions", true);
run("8-bit");
run("Smooth", "stack");
setAutoThreshold("Default dark no-reset");
//run("Threshold...");
resetThreshold;
setThreshold(73, 255, "raw");
run("Convert to Mask", "background=Dark calculate black");
selectImage("Probability maps.tif");
selectImage("Probability maps-1.tif");
run("Gaussian Blur...", "sigma=1.5 stack");
saveAs("Tiff", "/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/ROI_1/Thresholded_ER.tif");



# Finally Save all thresholded files as Wavefront .OBJ format to be rendered