close all;
clear all;
%the image showing the car plate number should be clear and taken from
%front so the numbers are visible clearly 
im = imread('image1.png');%reading the image
imgray = rgb2gray(im);%converting to gray scale image
imbin = imbinarize(imgray);%binarizing the image
im = edge(imgray, 'prewitt');%edge detection 

%Below steps are to find location of number plate
Iprops=regionprops(im,'BoundingBox','Area', 'Image');%gives the propertis of the image
area = Iprops.Area;
count = numel(Iprops);%number of elements

boundingBox = Iprops.BoundingBox;
for i=1:count
   if area<Iprops(i).Area
       area=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);%croping the number plate area
im = bwareaopen(~im, 500); %remove some object if it width is too long or too small than 500

 [h, w] = size(im);%get width

imshow(im);

Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %read letter
count = numel(Iprops);
noPlate=[]; % Initializing the variable of number plate string.

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) & oh>(h/3)
       letter=Letter_detection(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       noPlate=[noPlate letter] % Appending every subsequent character in noPlate variable.
   end
end