% Copyright 2015-2016 The MathWorks, Inc.
%% 
close all
clear 
clc
tic
%% Set up video reader
videoReader = vision.VideoFileReader('buoyMotion.avi',...
    'ImageColorSpace','Intensity');

%% Set up optical flow
of = opticalFlowHS;
of.Smoothness = 0.1;

% of = opticalFlowFarneback();
% of.NumPyramidLevels = 1;

% of = opticalFlowLK();
% of.NoiseThreshold = 0.01;

% of = opticalFlowLKDoG();
% of.NoiseThreshold = 1e-4;

%% Loop algorithm
while(~isDone(videoReader))
   
    vidFrame = step(videoReader);
    flowField = estimateFlow(of,vidFrame);
    
    subplot(2,2,1);
    plot(flowField,...
        'DecimationFactor',[10 10],...
        'ScaleFactor',50);    
    title('Optical Flow')

    horizontalMotion = flowField.Vx;
    objectsToRight = horizontalMotion > 1;
    objectsToLeft = horizontalMotion < -1;
    
    subplot(2,2,3);
    imshow(objectsToRight);
    title('Objects moving to the RIGHT side')

    subplot(2,2,4);
    imshow(objectsToLeft);
    title('Objects moving to the LEFT side')

    robotLeftMotion = nnz(objectsToRight);
    robotRightMotion = nnz(objectsToLeft);
    
    if robotLeftMotion > robotRightMotion
        movString = 'Moving to LEFT';
    else
        movString = 'Moving to RIGHT';
    end
    
    frameMov = insertText(vidFrame,[400 400],movString,...
        'FontSize',26);
    
    subplot(2,2,2);
    imshow(frameMov)   
    title('Robot Movement')
    drawnow;
end

%% Clean up
timeElapsed = toc
release(videoReader);