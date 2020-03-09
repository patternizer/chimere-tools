close all; clear all; clc;

FLAG_WRF = 0;
% ncdisp(filename);
if FLAG_WRF == 1
    filename = 'wrfout_d01_2009-03-12_00_00_00.nc';
    t0 = datenum('01/01/2009 00:00','dd/mm/yyyy HH:MM');
    t = double(ncread(filename,'XTIME'))/24/60;
    time = t0 + t;
    lat = double(ncread(filename,'XLAT'));
    lon = double(ncread(filename,'XLONG'));
    varname = 'T2';
%     varname = 'QRAIN';
    X = squeeze(lon(:,:,1));
    Y = squeeze(lat(:,:,1));    
    data4d = double(ncread(filename,varname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
    Z = squeeze(data4d(:,:,1)); 
else
    filename = 'meteo.20090312_20090319_Test.nc';
    lat = double(ncread(filename,'lat'));
    lon = double(ncread(filename,'lon'));
    varname = 'tem2';
%    varname = 'rain';
    X_CHIMERE = lon;
    Y_CHIMERE = lat;
    data4d = double(ncread(filename,varname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
    Z_CHIMERE = squeeze(data4d(:,:,1)); 
end
cmin = min(Z_CHIMERE(:));
cmax = max(Z_CHIMERE(:));

FLAG_WRF = 1;
% ncdisp(filename);
if FLAG_WRF == 1
    filename = 'wrfout_d01_2009-03-12_00_00_00.nc';
    t0 = datenum('01/01/2009 00:00','dd/mm/yyyy HH:MM');
    t = double(ncread(filename,'XTIME'))/24/60;
    time = t0 + t;
    lat = double(ncread(filename,'XLAT'));
    lon = double(ncread(filename,'XLONG'));
     varname = 'T2';
%    varname = 'QRAIN';
    X = squeeze(lon(:,:,1));
    Y = squeeze(lat(:,:,1));    
    data4d = double(ncread(filename,varname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
    Z = squeeze(data4d(:,:,1)); 
else
    filename = 'meteo.20090312_20090319_Test.nc';
    lat = double(ncread(filename,'lat'));
    lon = double(ncread(filename,'lon'));
%    varname = 'tem2';
      varname = 'rain';
    X_CHIMERE = lon;
    Y_CHIMERE = lat;
    data4d = double(ncread(filename,varname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
    Z_CHIMERE = squeeze(data4d(:,:,1));    
end
% chemname = 'NOX';
% chemname = 'O3';
% chemname = 'SO2';
% chemname = 'CO';
% chemname = 'PM10';
% chemname = 'PM25';
% data4d = double(ncread(filename,chemname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
data4d = double(ncread(filename,varname)); % 79x47x8x193 (west_east,south_north,bottom_top,time)
% data3d = zeros(size(lat,1),size(lat,2),8);
x_str = 'LON';
y_str = 'LAT';
z_str = 'LAYER';
% v_str = 'NOx [ppb vol]';
% v_str = 'O3 [ppb vol]';
% v_str = 'SO2 [ppb vol]';
% v_str = 'CO [ppb vol]';
% v_str = 'PM10 [ug/m3]';
% v_str = 'PM25 [ug/m3]';
v_str = '2m-TEMP [K]';
% v_str = 'Precipitation';

font_size = 14;
for j=1:1    
% for j=1:size(data4d,3)
    figure; set(gcf, 'color','white', 'visible','on','units','normalized','outerposition',[0 0 1 1]);        
%     Z = squeeze(data4d(:,:,j));
%     contourf(X,Y,Z-273.15,'clipping','off');   
%     pcolor(X,Y,Z-273.15);   
    h1 = pcolor(X,Y,Z); hold on;
    h2 = pcolor(X_CHIMERE,Y_CHIMERE,Z_CHIMERE);    
%     title([datestr(time(j),'dd/mm/yyyy HH:MM')]);
%     pause(3);   
end
%     for i=1:8
%         chem = squeeze(data4d(:,:,i,1)); 
%         Z = chem;    
%         [~,h] = contourf(Y,X,Z-273.15,'clipping','off');    
%         set_contour_z_level(h,i);
%     end
%     hold off    
% set(gca,'ydir','reverse');
% % azi = 10.0; ele = 10.0; view(azi,ele); camproj('perspective');
% azi = -75; ele = 45; view(azi,ele); camproj('orthographic');
text(X(1),Y(end),'WRF');
text(X_CHIMERE(1),Y_CHIMERE(end),'CHIMERE');
% legend([h1 h2],{'WRF','CHIMERE'});
caxis([cmin,cmax]);
cb = colorbar('FontSize',font_size,'Location','EastOutside');
set(get(cb,'YLabel'),'String',v_str,'FontSize',font_size);   
xlabel(y_str,'fontsize',font_size);
ylabel(x_str,'fontsize',font_size);
zlabel(z_str,'fontsize',font_size);
% print('-djpeg','-r200',chemname);
set(gca,'layer','top','Box','on','TickDir', 'out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','ZMinorTick','on','XGrid','on','YGrid','on','ZGrid','on','XMinorGrid','off','YMinorGrid','off','ZMinorGrid','off','XColor','k','YColor','k','ZColor','k','LineWidth',1,'FontSize',font_size);
set(gcf,'PaperPositionMode','auto'); 
print('-djpeg','-r200',strcat(varname,'2'));
close;
            
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
