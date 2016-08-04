% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear 
clc
%% Set up video reader
videoReader = vision.VideoFileReader('thumb.avi',...
    'ImageColorSpace','Intensity');

%% Set up optical flow


%% Loop algorithm
while(~isDone(videoReader))
    
    % Acquire frame
    
    % Estimate flow
        
    % Visualize flow field
     
    % Update figures
    drawnow;
    
end

%% Clean up
release(videoReader);