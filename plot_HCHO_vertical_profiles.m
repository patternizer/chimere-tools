clear all; close all; clc;

%--------------------------------------------------------------------------
% Dr. Michael Taylor: 
%
% Version 1.0: 14/06/2016
% Laboratory of Atmospheric Physics, Aristotle University of Thessaloniki
% http://users.auth.gr/mtaylor/
% email: mtaylor@auth.gr
%
% Version 2.0: 12/03/2020
% https://patternizer.github.io
% email: patternizer@gmail.com
%--------------------------------------------------------------------------

%% PLOT PARAMETERS    
line_width          = 2;    
marker_size         = 10;    
font_size           = 18;	
font_weight         = 'bold';               
grey                = [204 204 204]/255;    % Light Graphite    
bright              = [255 0 0]/255;        % Red    
mid                 = [237 138 237]/255;    % Violet    
dark                = [138 0 138]/255;      % Dark Magenta    
opposite1           = [0 0 255]/255;        % Blue    
opposite2           = [0 0 138]/255;        % Navy     
opposite3           = [0 204 204]/255;      % Green
FLAG_EPS            = 0;                    % 0=none, 1=generate EPS
FLAG_plot_on        = 1;    
FLAG_plot_visible   = 1;    
FLAG_plot_save      = 1;    
figure_type         = 2;                    % 1=FIG, 2=PNG     
figure_count        = 0;       
colours             = distinguishable_colors(24);

%% SELECT HCHO DATA FILE
[files,path] = uigetfile({'*.txt'},'Select the HCHO data file:','MultiSelect', 'off');
[A,~,~] = tblread(files);
z = A(:,1)/1000;
H = nan(1,24);
lstr = cell(1,24);
     
%% PLOT HCHO VERTICAL PROFILE COMPARISON     
figure; set(gcf, 'color','white', 'visible','on','units','normalized','outerposition',[0 0 1 1]);        
for i=1:24     
	x = A(:,1+i);
    if length(num2str(i))>1
		str = strcat([num2str(i),':00']);     
	else     
		str = strcat(['0',num2str(i),':00']);     
	end
    lstr{i} = str;
    if i == 12
		H(i) = plot(x,z,'.','markersize',marker_size,'markeredgecolor',colours(i,:),'linestyle','-','linewidth',2*line_width,'color',colours(i,:));
        lstr(i) = strcat(lstr(i),': OMI');
	elseif i == 8 
		H(i) = plot(x,z,'.','markersize',marker_size,'markeredgecolor',colours(i,:),'linestyle','-','linewidth',2*line_width,'color',colours(i,:));
        lstr(i) = strcat(lstr(i),': GOME2');
    else
        H(i) = plot(x,z,'.','markersize',marker_size,'markeredgecolor',colours(i,:),'linestyle','-','linewidth',0.5*line_width,'color',colours(i,:));
    end
    hold on;
end     
xlim = [0,0.005];    
legend(H(:),lstr(:)','FontSize',0.5*font_size,'location','EastOutside');      
xlabel('HCHO concentration','FontSize',font_size,'FontWeight',font_weight);     
ylabel('Altitude [km]','FontSize',font_size,'FontWeight',font_weight);       
title(['Hourly HCHO profiles (UCT): ',files(12:13),'/',files(10:11),'/',files(6:9)],'FontSize',font_size,'FontWeight',font_weight);     
set(gca,'Box','off','TickDir', 'out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','XGrid','on','YGrid','on','XMinorGrid','off','YMinorGrid','off','XColor','k','YColor','k','LineWidth',1,'FontSize',font_size);       
filename = files(1:13);                                                                             
print('-djpeg','-r200',filename);     
if isequal(FLAG_EPS,1)     
	print('-depsc','-r200',filename); 
end   
close all;   
         
%% PLOT WRF PRESSURE V ALTITUDE CURVES FOR ANALSIS
figure; set(gcf, 'color','white', 'visible','on','units','normalized','outerposition',[0 0 1 1]);        
nA = 8; P0A = 1013.25; P1A = 999; P2A = 200; [zA,PA] = PzWRF(P0A,P1A,P2A,nA);
h1 = plot(PA,zA/1000,'^','markersize',marker_size,'markeredgecolor',bright,'linestyle','-','linewidth',line_width,'color',bright); 
set(gca,'xdir','reverse'); hold on;
nB = 18; P0B = 1013.25; P1B = 999; P2B = 200; [zB,PB] = PzWRF(P0B,P1B,P2B,nB);
h2 = plot(PB,zB/1000,'v','markersize',marker_size,'markeredgecolor',mid,'linestyle','-','linewidth',line_width,'color',mid);
set(gca,'xdir','reverse'); hold on;
nC = 8; P0C = 1013.25; P1C = 1010; P2C = 200; [zC,PC] = PzWRF(P0C,P1C,P2C,nC);
h3 = plot(PC,zC/1000,'s','markersize',marker_size,'markeredgecolor',dark,'linestyle','-','linewidth',line_width,'color',dark); set(gca,'xdir','reverse'); hold on;
dA = zA - [0,zA(1:end-1)];
dB = zB - [0,zB(1:end-1)];
dC = zC - [0,zC(1:end-1)];
xlabel('Pressure [hPa]','FontSize',font_size,'FontWeight',font_weight);
ylabel('Altitude [km]','FontSize',font_size,'FontWeight',font_weight);  
title(['Altitude versus pressure levels for WRF model'],'FontSize',font_size,'FontWeight',font_weight);
legend([h1,h2,h3],{['n=',num2str(nA),' P0=',num2str(P0A),' P1=',num2str(P1A),' P2=',num2str(P2A)],['n=',num2str(nB),' P0=',num2str(P0B),' P1=',num2str(P1B),' P2=',num2str(P2B)],['n=',num2str(nC),' P0=',num2str(P0C),' P1=',num2str(P1C),' P2=',num2str(P2C)]},'FontSize',font_size,'location','NorthWest'); 
set(gca,'Box','off','TickDir', 'out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','XGrid','on','YGrid','on','XMinorGrid','off','YMinorGrid','off','XColor','k','YColor','k','LineWidth',1,'FontSize',font_size);  
filename = strcat(['WRF_levels']);                                                                        
print('-djpeg','-r200',filename);
if isequal(FLAG_EPS,1)
	print('-depsc','-r200',filename); 
end   
close all;   

return    
