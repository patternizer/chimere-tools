close all; clear all; clc;

filename = 'chimere.nc';
% ncdisp(filename);
lat = double(ncread(filename,'lat'));
lon = double(ncread(filename,'lon'));
% chemname = 'NOX';
% chemname = 'O3';
chemname = 'SO2';
% chemname = 'CO';
% chemname = 'PM10';
% chemname = 'PM25';
% data4d = double(ncread(filename,'NOX')); % 79x47x8x193 (west_east,south_north,bottom_top,time)
data4d = double(ncread(filename,chemname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
data3d = zeros(size(lat,1),size(lat,2),8);
x_str = 'LON';
y_str = 'LAT';
z_str = 'LAYER';
% v_str = 'NOx [ppb vol]';
% v_str = 'O3 [ppb vol]';
v_str = 'SO2 [ppb vol]';
% v_str = 'CO [ppb vol]';
% v_str = 'PM10 [ug/m3]';
% v_str = 'PM25 [ug/m3]';

X = lon;
Y = lat;

figure; set(gcf, 'color','white', 'visible','on','units','normalized','outerposition',[0 0 1 1]);        
hold on
for i=2:2:8
    chem = squeeze(data4d(:,:,i));    
    Z = chem;    
    [~,h] = contour(X,Y,Z,30,'clipping','off');    
    set_contour_z_level(h,i);
end
hold off
azi = 10.0; ele = 10.0; view(azi,ele);
% camproj('perspective');
camproj('orthographic');

%T = viewmtx(az,el,phi);

% azi = -37.5; ele = 10.0; view(azi,ele);
% azi = 0; ele = 30.0; view(azi,ele);
% axis vis3d; 
% grid on;
cb = colorbar('FontSize',14,'Location','EastOutside');                    
set(get(cb,'YLabel'),'String',v_str,'FontSize',14);   
xlabel(x_str,'fontsize',14);
ylabel(y_str,'fontsize',14);
zlabel(z_str,'fontsize',14);
print('-djpeg','-r200',chemname);
close;

return

% x = lat(:);
% y = lon(:);
% z = [1:8]';
% v = chem(:);
% xlin = linspace(min(x),max(x),50);
% ylin = linspace(min(y),max(y),50);
% zlin = linspace(min(z),max(z),8);
% [X,Y,Z] = meshgrid(xlin,ylin,zlin);
% f = scatteredInterpolant(x,y,z,v);
% V = f(X,Y,Z);   

% [x,y,z,v] = flow;
% isovalue = -1;
% purple = [1.0 0.5 1.0];
% figure;
% p = patch(isosurface(x,y,z,v,isovalue));
% isonormals(x,y,z,v,p);
% set(p,'FaceColor',purple,'EdgeColor','none');
% view([-10 40]);
% axis on;
% grid on;
% light;
% lighting phong;
% camlight('left');
