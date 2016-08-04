% Copyright 2015-2016 The MathWorks, Inc.
%% 
close all
clear 
clc
%% Set up video reader
videoReader = vision.VideoFileReader('multiObject.avi',...
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
   
    % Acquire frame
    vidFrame = step(videoReader);
    
    % Estimate flow
    flowField = estimateFlow(of,vidFrame);
    
    % Visualize flow field
    subplot(2,2,[1 3]);
    imshow(vidFrame)
    hold on
    plot(flowField,...
        'DecimationFactor',[5 5],...
        'ScaleFactor',5);    
    title('Optical Flow')
    hold off
    
    % Find pixels moving to the right
    horizontalMotion = flowField.Vx;
    moveToRight = horizontalMotion > 0.1;
    
    % Visualize results
    subplot(2,2,2);
    imshow(moveToRight);
    title('Movement to the RIGHT side')

    subplot(2,2,4);
    imshow(horizontalMotion);
    title('Horizontal Motion')
    
    % Update figures
    drawnow;

end

%% Clean up
release(videoReader);