close all; clear all; clc;

%--------------------------------------------------------------------------
% Dr. Michael Taylor: 
%
% Version 1.0: 24/05/2016
% Laboratory of Atmospheric Physics, Aristotle University of Thessaloniki
% http://users.auth.gr/mtaylor/
% email: mtaylor@auth.gr
%
% Version 2.0: 12/03/2020
% http://patternizer.github.io/
% email: patternizer@gmail.com
%--------------------------------------------------------------------------

filename = 'chimere.nc';
% ncdisp(filename);
lat = double(ncread(filename,'lat'));
lon = double(ncread(filename,'lon'));
levels = 8; % number of pressure levels
% chemname = 'NOX';
% chemname = 'O3';
% chemname = 'SO2';
% chemname = 'CO';
% chemname = 'PM10';
chemname = 'PM25';
data4d = double(ncread(filename,chemname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
x_str = 'LON';
y_str = 'LAT';
z_str = 'Pressure Level: ';
% v_str = 'NOx [ppb vol]';
% v_str = 'O3 [ppb vol]';
% v_str = 'SO2 [ppb vol]';
% v_str = 'CO [ppb vol]';
% v_str = 'PM10 [ug/m3]';
v_str = 'PM25 [\mugm^{-3}]';
timestep = 1;
chem = squeeze(data4d(:,:,:,timestep));

figure; set(gcf, 'color','white', 'visible','on','units','normalized','outerposition',[0 0 1 1]);        
for i=1:levels    
    subplot(4,2,i)
	contourf(lon,lat,chem(:,:,i),30,'LineColor','none');
    cb = colorbar('FontSize',10,'Location','EastOutside');
    set(get(cb,'YLabel'),'String',v_str,'FontSize',10,'Interpreter','tex');
    caxis([0 10]);
    title([z_str, num2str(i)],'fontsize',10);
    xlabel(x_str,'fontsize',10);
    ylabel(y_str,'fontsize',10);
    zlabel(z_str,'fontsize',10);
end
print('-djpeg','-r200','plot_2d');
close;

x = repmat(lat(:),levels,1);
y = repmat(lon(:),levels,1);
z = linspace(1,levels,length(x))';
v = chem(:);
f = scatteredInterpolant(x,y,z,v);
xlin = linspace(min(x),max(x),size(chem,2));
ylin = linspace(min(y),max(y),size(chem,1));
%zlin = linspace(min(z),max(z),size(chem,3));
zlin = linspace(min(z),max(z),levels*2);
[X,Y,Z] = meshgrid(xlin,ylin,zlin);
V = f(X,Y,Z);
% V = smooth3(V);
zslice = [1:levels];   
yslice = [];
xslice = [];

vidfile = VideoWriter('plot_3d_video.mp4','MPEG-4');
vidfile.FrameRate = 4;
open(vidfile)

figure
% contourslice(X,Y,Z,V,xslice,yslice,zslice)
% slice(X,Y,Z,V,xslice,yslice,zslice,'cubic');
h = [];
for i = (1:levels)
    delete(h)
%    hold on
    [~,h] = contourf(lon,lat,V(:,:,i*2),30);  
    set(h,'LineColor','none');
    ax = gca;
    ax.Children(1).XData=lat; 
    ax.Children(1).YData=lon; 
    ax.Children(1).ContourZLevel=zslice(i);   
    view(3)
    cb = colorbar('FontSize',10,'Location','EastOutside');
    set(get(cb,'YLabel'),'String',v_str,'FontSize',10,'Interpreter','tex');
    caxis([0 10]);
    zlim([0,levels])    
    ylabel(x_str,'fontsize',10);
    xlabel(y_str,'fontsize',10);
    zlabel(z_str,'fontsize',10);
    grid on
    set(gca,'ydir','reverse');
    drawnow
    im = getframe(gcf);        
    writeVideo(vidfile, im);
%    pause(0.5);
end
% hold off
%print('-djpeg','-r200','plot_3d');

close(vidfile);
close;

figure
% isovalue = 10;
purple = [1,127/255,1];
orange = [1,185/255,0];
P10 = patch(isosurface(X,Y,Z,V,10),'FaceColor',purple,'EdgeColor','none');
P5 = patch(isosurface(X,Y,Z,V,5),'FaceColor',orange,'EdgeColor','none');
isonormals(X,Y,Z,V,P10);
isonormals(X,Y,Z,V,P5);
xlim([min(x),max(x)]);
ylim([min(y),max(y)]);
zlim([min(z),max(z)]);
view(3); 
grid on;
axis on;
camlight; 
lighting gouraud;
set(gca,'ydir','reverse');
print('-djpeg','-r200','plot_iso');
close;

return