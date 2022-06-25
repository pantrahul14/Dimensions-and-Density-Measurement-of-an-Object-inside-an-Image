%% Import Image 
clc 
close all
obj = imread('Planet.jpg');
imshow(obj)
 %% Segment Image
 % Divide Image "Ball" into its respective RGB intensities
 red = obj(:,:,1);
 green = obj(:,:,2);
 blue = obj(:,:,3);
 
 figure(1)
 subplot(2,2,1) ; imshow(obj) ; title('Original Image') ; 
 subplot(2,2,2) ; imshow(red) ; title('Red Plane') ;
 subplot(2,2,3) ; imshow(green) ; title('Green Plane') ;
 subplot(2,2,4) ; imshow(blue) ; title('Blue Plane') ; 
 
 %Threshold the blue plane
 figure(2)
 level = 0.25;
 bw = imbinarize(blue,level);
 subplot(3,2,1); imshow(bw); title('Blue plane thresholded');
 
 %%Remove Noise
 
 %Fill any holes
 fill = imfill (bw,'holes');
 subplot(3,2,2) ; imshow(fill) ; title('Holes filled');
 %Remove any blobs on the border of the image
 clear = imclearborder (fill);
 subplot(3,2,3) ; imshow(clear) ; title('Remove blobs on border');
 %Remove blobs that are smaller than 7 pixels across
 se = strel('disk',7);
 open = imopen(fill,se);
 subplot(3,2,4) ; imshow(open) ; title('Remove small blobs');
 
 %%Measure Object Diameter 
 diameter = regionprops(open,'MajorAxisLength')
 d1=struct2array(diameter);
 res = input('\n Enter the resolution of image in dpi: ');
 d2=(d1*2.54)/res;
 fprintf('The diameter of the object (in cm) is: %f',d2); 
 
 %Show result
 figure(3)
 imshow(obj)
 d = imdistline; %Include a line to physically measure the object 
 
 %Calculating density of object
 M = input('\n Enter the mass of the object (in g) :');
 R=(d1*2.54)/(2*96);
 Volume=((4/3)*pi*(R^3));
 Density=M/Volume;
 fprintf('The Volume of the object (in cm^3) is : %f ',Volume);
 fprintf('\n The Density of the object (in g/cm^3) is : %f ',Density);

