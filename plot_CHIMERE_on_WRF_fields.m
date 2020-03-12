close all; clear all; clc;

%--------------------------------------------------------------------------
% Dr. Michael Taylor: 
%
% Version 1.0: 24/10/2016
% Laboratory of Atmospheric Physics, Aristotle University of Thessaloniki
% http://users.auth.gr/mtaylor/
% email: mtaylor@auth.gr
%
% Version 2.0: 12/03/2020
% http://patternizer.github.io/
% email: patternizer@gmail.com
%--------------------------------------------------------------------------

vartype = 1; % 0=temperature, 1=precipitation 

if vartype == 0
	v_str = '2m-Temperature [K]';
	varname_WRF = 'T2';
	varname_CHIMERE = 'tem2';
else	
	v_str = 'Rain water mixing ratio [kg/kg]';
	varname_WRF= 'QRAIN';
	varname_CHIMERE = 'rain';
end
  
%% LOAD WRF FIELD
filename = 'wrfout_d01_2009-03-12_00_00_00.nc';
%t_WRF = double(ncread(filename,'XTIME'))/24/60;
t_WRF = ncread(filename,'Times')';
lon_WRF = double(ncread(filename,'XLONG'));
lat_WRF = double(ncread(filename,'XLAT'));
data4d_WRF = double(ncread(filename,varname_WRF)); % 79x47x8x193 (west_east,south_north,bottom_top,time)

%% LOAD CHIMERE FIELD  
filename = 'meteo.20090312_20090319_Test.nc';
t_CHIMERE = ncread(filename,'Times')';
lon_CHIMERE = double(ncread(filename,'lon'));
lat_CHIMERE = double(ncread(filename,'lat'));
data4d_CHIMERE = double(ncread(filename,varname_CHIMERE)); % 79x47x8x193 (west_east,south_north,bottom_top,time)

if length(t_WRF) > length(t_CHIMERE)
    time = t_CHIMERE;
else
    time = t_WRF;
end

%time = datenum('01/01/2009 00:00','dd/mm/yyyy HH:MM') + t_WRF;

%for t = 1:length(time)
for t = 1:24
    
timestamp = time(t,:); % first WRF timestamp
X_WRF = squeeze(lon_WRF(:,:,t));
Y_WRF = squeeze(lat_WRF(:,:,t));    
Z_WRF = squeeze(data4d_WRF(:,:,t)); 

X_CHIMERE = lon_CHIMERE;
Y_CHIMERE = lat_CHIMERE;
Z_CHIMERE = squeeze(data4d_CHIMERE(:,:,t)); 

%% OVERLAY WRF FIELD AND CHIMERE FIELD
cmin = min(Z_CHIMERE(:));
cmax = max(Z_CHIMERE(:));
x_str = 'LON';
y_str = 'LAT';
font_size = 14;

figure; set(gcf, 'color','white', 'visible','on','units','normalized','outerposition',[0 0 1 1]);        
h1 = pcolor(X_WRF,Y_WRF,Z_WRF); hold on;
h2 = pcolor(X_CHIMERE,Y_CHIMERE,Z_CHIMERE);    
title([datestr(timestamp,'dd/mm/yyyy HH:MM')]);
text(X_WRF(1),Y_WRF(end),'WRF');
text(X_CHIMERE(1),Y_CHIMERE(end),'CHIMERE');
caxis([cmin,cmax]);
cb = colorbar('FontSize',font_size,'Location','EastOutside');
set(get(cb,'YLabel'),'String',v_str,'FontSize',font_size);   
xlabel(y_str,'fontsize',font_size);
ylabel(x_str,'fontsize',font_size);
set(gca,'layer','top','Box','on','TickDir', 'out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','ZMinorTick','on','XGrid','on','YGrid','on','ZGrid','on','XMinorGrid','off','YMinorGrid','off','ZMinorGrid','off','XColor','k','YColor','k','ZColor','k','LineWidth',1,'FontSize',font_size);
set(gcf,'PaperPositionMode','auto'); 
if vartype == 0
    print('-djpeg','-r200',['WRF_CHIMERE_Temperature_',num2str(t)]);
else
    print('-djpeg','-r200',['WRF_CHIMERE_Precipitation_',num2str(t)]);
end
close;

end

return