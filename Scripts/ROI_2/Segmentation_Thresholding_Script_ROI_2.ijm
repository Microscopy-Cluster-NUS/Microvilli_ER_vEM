#########
# ROI_2 #
#########

selectImage("3_Rebin.tif");
run("Duplicate...", "title=1-90 duplicate range=1-90");
makeRectangle(42, 0, 552, 512);
run("Duplicate...", "title=ROI_2_Raw duplicate");

###########################
# Segmentation Using Weka #
###########################
//setTool("freeline");
run("Trainable Weka Segmentation");
selectImage("Trainable Weka Segmentation v4.0.0");

# Probability map model
call("trainableSegmentation.Weka_Segmentation.getProbability");
selectImage("Probability maps");
 mapscall("trainableSegmentation.Weka_Segmentation.saveClassifier", "../ROI_2.model");
close;

########################################
# Thresholding to obtain Segmentations #
########################################

# Tubules Thresholding

selectImage("Tubules_ROI2");
run("In [+]");
run("In [+]");
run("Out [-]");
run("In [+]");
run("In [+]");
run("16-bit");
//run("Brightness/Contrast...");
setMinAndMax(28934, 55571);
run("Apply LUT", "stack");
run("Despeckle", "stack");
setAutoThreshold("Default dark 16-bit no-reset");
//run("Threshold...");
selectImage("ROI_2_Probability_maps.tif");
selectImage("Tubules_ROI2");
setThreshold(4626, 65535, "raw");
setOption("BlackBackground", true);
run("Convert to Mask", "background=Dark calculate black");
run("Gaussian Blur...", "sigma=2 stack");
run("Image Sequence... ", "select=/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/Image_Sequences/ROI_2/Tubules_Thresholded dir=/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/Image_Sequences/ROI_2/Tubules_Thresholded/ format=TIFF");
run("Wavefront .OBJ ...", "stack=Tubules_ROI2 threshold=50 resampling=2 red green blue save=/Users/samaksh/Desktop/NUS_Work/EMU/NTU-Kayen/Steps_16Bits/Obj_Files/ROI_2/Tubules.obj");
selectImage("ROI_2_Probability_maps.tif");


# ER Thresholding

run("Duplicate...", "title=ER duplicate channels=2");
selectImage("ER");
run("In [+]");
run("In [+]");
run("In [+]");
run("In [+]");
selectImage("ER");

resetThreshold;
run("16-bit");
//run("Brightness/Contrast...");
setMinAndMax(25183, 42523);
run("Apply LUT", "stack");
run("Close");
run("8-bit");
setThreshold(771, 65535, "raw");
run("Convert to Mask", "background=Dark calculate black");

# Finally Save all thresholded files as Wavefront .OBJ format to be rendered