% Copyright 2015-2016 The MathWorks, Inc.
%%
close all
clear 
clc
%% Set up video reader
videoReader = vision.VideoFileReader('buoyMotion.avi',...
    'ImageColorSpace','Intensity');

%% Set up optical flow


%% Loop algorithm


%% Clean up
release(videoReader);