% Copyright 2015-2016 The MathWorks, Inc.
%% Create a sphere and rotate it
% You will see the motion and can determine the direction of the movement
figure
[x,y,z] = sphere(51);
sh = surf(x,y,z);

for k=1:15
     rotate(sh,[0,0,1],5);
     pause(0.1);
end

%% Create a sphere again but this time a homogenously black one
% Even if it is still rotating you will not see it (maybe some flicker at
% the outline of the sphere)
figure
[x,y,z] = sphere(51);
sh = surf(x,y,z,'FaceColor','k');

for k=1:15
     rotate(sh,[0,0,1],5);
     pause(0.1);
end

%% Now let's add some lighting to the scene
% You will see the motion in the light area but the most part if the sphere
% still looks static. 
figure
[x,y,z] = sphere(51);
sh = surf(x,y,z,'FaceColor','k');
camlight
for k=1:15
     rotate(sh,[0,0,1],5);
     pause(0.1);
end