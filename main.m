%% Hausdorff Distance: Identical vs Noisy
clear; clc; close all

addpath(genpath('core'));

% Create the base shape (circle)
imgSize = 100;
[X, Y] = meshgrid(1:imgSize, 1:imgSize);
center = imgSize / 2;
radius = 20;
img1 = sqrt((X - center).^2 + (Y - center).^2) <= radius;

% Create a noisy version
rng(42);  % Fixed seed for reproducibility
noise = rand(size(img1)) < 0.01;
img2 = xor(img1, noise);

% Compute Hausdorff distances
[hd_same, ~] = Hausdorff(img1, img1);
[hd_noisy, ~] = Hausdorff(img1, img2);

% Plot
figure('Name', 'Hausdorff Distance: Identical vs Noisy', 'Position', [100 100 1000 600]);

% Row 1 - Identical
subplot(2,3,1); imshow(img1); title('Image 1');
subplot(2,3,2); imshow(img1); title('Image 1 (Identical)');
subplot(2,3,3); title(sprintf('Hausdorff Distance = %.2f', hd_same)); axis off

% Row 2 - Noisy
subplot(2,3,4); imshow(img1); title('Image 1');
subplot(2,3,5); imshow(img2); title('Noisy Image 1');
subplot(2,3,6); title(sprintf('Hausdorff Distance = %.2f', hd_noisy)); axis off