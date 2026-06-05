
// Inverting Image 


run("Invert", "stack");


// Adjusting Voxel 


run("Duplicate...", "duplicate");
run("Properties...", "channels=1 slices=629 frames=1 pixel_width=0.0001970 pixel_height=0.0001970 voxel_depth=0.0002000");


// Adjusting Brighness and contrast 


run("Duplicate...", "duplicate");
setMinAndMax(28789, 58080);
run("Apply LUT", "stack");
run("Close");

// Rebinning Data 


run("Duplicate...", "duplicate");
run("Scale...", "x=0.5 y=0.5 z=1.0 width=1000 height=1000 depth=629 interpolation=None average process create title=3_Rebin.tif");

saveAs("Tiff", "../2_Final_Preprocessed.tif");
close;
