% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear 
clc
%% Set up video reader
videoReader = vision.VideoFileReader('multiObject.avi',...
    'ImageColorSpace','Intensity');

%% Set up optical flow


%% Loop algorithm
while(~isDone(videoReader))
    
    % Acquire frame
    
    % Estimate flow
        
    % Visualize flow field
     
    % Find pixels moving to the right
    
    % Visualize results
    
    % Update figures
    drawnow;
    
end

%% Clean up
release(videoReader);