% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear 
clc
%% Set up video reader
videoReader = vision.VideoFileReader('thumb.avi',...
    'ImageColorSpace','Intensity');

%% Set up optical flow
of = opticalFlowHS;
of.Smoothness = 0.1;
 
% of = opticalFlowLK();
% of.NoiseThreshold = 1e-3;

% of = opticalFlowLKDoG();
% of.NoiseThreshold = 0.0002;
% of.ImageFilterSigma = 6.5;

%% Loop algorithm
while(~isDone(videoReader))
    
    % Acquire frame
    vidFrame = step(videoReader);
    
    % Estimate flow
    flowField = estimateFlow(of,vidFrame);
    
    % Visualize flow field
    imshow(vidFrame)
    hold on
    plot(flowField,...
        'DecimationFactor',[3 3],...
        'ScaleFactor',30);    
    title('Optical Flow')
    hold off
    % Update figures
    drawnow;
    
end

%% Clean up
release(videoReader);