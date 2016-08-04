% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear 
clc
%% Set up video reader
videoReader = vision.VideoFileReader('buoyMotion.avi',...
    'ImageColorSpace','Intensity');

%% Set up optical flow
of(1).OFAlgorithm = 'Horn-Schunck';
of(1).obj = opticalFlowHS;
of(1).obj.Smoothness = 0.1;

of(2).OFAlgorithm = 'Farneback';
of(2).obj = opticalFlowFarneback();
of(2).obj.NumPyramidLevels = 1;

of(3).OFAlgorithm = 'Lucas-Kanade';
of(3).obj = opticalFlowLK();
of(3).obj.NoiseThreshold = 0.01;

of(4).OFAlgorithm = 'Lucas-Kanade DoG';
of(4).obj = opticalFlowLKDoG();
of(4).obj.NoiseThreshold = 1e-4;

%% Loop algorithm
for idx = 1:length(of)
    tic;
    disp(['Running ' of(idx).OFAlgorithm]);
    while(~isDone(videoReader))

        vidFrame = step(videoReader);
        flowField = estimateFlow(of(idx).obj,vidFrame);

        horizontalMotion = flowField.Vx;
        objectsToRight = horizontalMotion > 1;
        objectsToLeft = horizontalMotion < -1;

        robotLeftMotion = nnz(objectsToRight);
        robotRightMotion = nnz(objectsToLeft);

    end
    of(idx).TimeElapsed = toc;
    disp(['Time Elapsed for ' of(idx).OFAlgorithm...
        ':' num2str(of(idx).TimeElapsed) ' s']);
    reset(videoReader)
end

figure;
plot([of(:).TimeElapsed],'r*','LineWidth',5);
h = gca;
h.XTick = 1:4;
xTickLabels = {of(:).OFAlgorithm};
h.XTickLabel = xTickLabels;
h.XTickLabelRotation = 45;
title('Optical Flow Algorithm Run Times')
xlabel('Algorithms')
ylabel('Run Time (s)')

%% Clean up
release(videoReader);