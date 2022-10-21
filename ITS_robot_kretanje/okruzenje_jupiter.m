function obstacles = okruzenje_jupiter
fig = figure(1);

% set(fig, 'name', 'EKF_LOCALIZATION');
% set(gca,'NextPlot','replace');
% axis ([-.1  100 -.1 150]);
axis ([-10  110 -10 160]);
xlim([-10 110])
ylim([-10 160])
% axis equal
% grid minor
 hold on

 inkrement = .01;
 
% This script outputs list of known obstacles
%
% % The warehouse #1.1

obsc1 = [1];

Centar=[40,50];
Radijus=10;
ugao=10;
hold on
a=0:ugao:360;
MontazniSTO1=[Centar(1)+Radijus*cosd(a);Centar(2)+Radijus*sind(a)]';
plot(MontazniSTO1(:,1),MontazniSTO1(:,2),'k','LineWidth',2,'LineStyle','-')
fill(MontazniSTO1(:,1),MontazniSTO1(:,2), [0.7 0.7 0.7])
% text((0),(50),' Montazni sto \downarrow')
% =========================================================================
% =========================================================================
% ==


% % % The warehouse #2
% 
xw = [20; 0; 0];
yw = [0; 0; 20];
zw = [1; 1;1];
tcolor = [.7 .7 .7];
patch(xw,yw,zw,tcolor,'LineWidth',2)
% 
% text((12),(10),'\leftarrow Cosak')
%==========================================================================
%==========================================================================
% 
% 
% Machine tool #1 - makaze
% define bounds
x1min = 80; x1max = 90; y1min = 15; y1max = 30;
% define lower x bound
x1obs_1 = [x1min:inkrement :x1max]';
y1obs_1 = [y1min*ones(size(x1obs_1,1),1)];


% define upper x bound
x1obs_2 = [x1min:inkrement :x1max]';
y1obs_2 = [y1max*ones(size(x1obs_2,1),1)];

% define lower y bound
y1obs_3 = [y1min:inkrement :y1max]';
x1obs_3 = [x1min*ones(size(y1obs_3,1),1)];

% define upper y bound
y1obs_4 = [y1min:.1:y1max]';
x1obs_4 = [x1max*ones(size(y1obs_4,1),1)];

obs1 = [[x1obs_1 y1obs_1];[x1obs_2 y1obs_2];[x1obs_3 y1obs_3];[x1obs_4 y1obs_4]];

r1 = rectangle('Position',[x1min,y1min,(x1max-x1min),(y1max-y1min)],'Curvature',[.1,.1],...
          'FaceColor','r','LineWidth',2,'LineStyle','-');
daspect([1,1,1]);
% text((85-10-3),(18-10),'\uparrow Makaze')
%==========================================================================
%==========================================================================
% Machine tool #2 - CNC

% define bounds
x2min = 74.5; x2max = 90; y2min = 50; y2max = 64;
% define lower x bound
x2obs_1 = [x2min:inkrement :x2max]';
y2obs_1 = [y2min*ones(size(x2obs_1,1),1)];


% define upper x bound
x2obs_2 = [x2min:inkrement :x2max]';
y2obs_2 = [y2max*ones(size(x2obs_2,1),1)];


% define lower y bound
y2obs_3 = [y2min:inkrement :y2max]';
x2obs_3 = [x2min*ones(size(y2obs_3,1),1)];


% define upper y bound
y2obs_4 = [y2min:inkrement :y2max]';
x2obs_4 = [x2max*ones(size(y2obs_4,1),1)];

obs2 = [[x2obs_1 y2obs_1];[x2obs_2 y2obs_2];[x2obs_3 y2obs_3];[x2obs_4 y2obs_4]];

r2 = rectangle('Position',[x2min,y2min,(x2max-x2min),(y2max-y2min)],'Curvature',[.1,.1],...
          'FaceColor','r','LineWidth',2,'LineStyle','-');
daspect([1,1,1]);
%       text((82-10),(45-10),'\uparrow CNC')
%==========================================================================
%==========================================================================
% Machine tool #3 - presa
% define bounds
x3min = 80; x3max = 90; y3min = 78; y3max = 93;
% define lower x bound
x3obs_1 = [x3min:inkrement :x3max]';
y3obs_1 = [y3min*ones(size(x3obs_1,1),1)];


% define upper x bound
x3obs_2 = [x3min:inkrement :x3max]';
y3obs_2 = [y3max*ones(size(x3obs_2,1),1)];


% define lower y bound
y3obs_3 = [y3min:inkrement :y3max]';
x3obs_3 = [x3min*ones(size(y3obs_3,1),1)];


% define upper y bound
y3obs_4 = [y3min:inkrement :y3max]';
x3obs_4 = [x3max*ones(size(y3obs_4,1),1)];


obs3 = [[x3obs_1 y3obs_1]; [x3obs_2 y3obs_2];[x3obs_3 y3obs_3] ;[x3obs_4 y3obs_4]];
r3 = rectangle('Position',[x3min,y3min,(x3max-x3min),(y3max-y3min)],'Curvature',[.1,.1],...
          'FaceColor','r','LineWidth',2,'LineStyle','-');
daspect([1,1,1]);
% text((66-10),(86-10),'Presa \rightarrow')
      
%==========================================================================
%==========================================================================
% Machine tool #4 - masina za bakar
% define bounds
x4min = 3; x4max = 6; y4min = 85.5; y4max = 145;
% define lower x bound
x4obs_1 = [x4min:inkrement :x4max]';
y4obs_1 = [y4min*ones(size(x4obs_1,1),1)];


% define upper x bound
x4obs_2 = [x4min:inkrement :x4max]';
y4obs_2 = [y4max*ones(size(x4obs_2,1),1)];


% define lower y bound
y4obs_3 = [y4min:inkrement :y4max]';
x4obs_3 = [x4min*ones(size(y4obs_3,1),1)];


% define upper y bound
y4obs_4 = [y4min:inkrement :y4max]';
x4obs_4 = [x4max*ones(size(y4obs_4,1),1)];


obs4 = [[x4obs_1 y4obs_1]; [x4obs_2 y4obs_2];[x4obs_3 y4obs_3];[x4obs_4 y4obs_4]];

r4 = rectangle('Position',[x4min,y4min,(x4max-x4min),(y4max-y4min)],'Curvature',[.1,.1],...
          'FaceColor','r','LineWidth',2,'LineStyle','-');
daspect([1,1,1]);
% text((x4max),(135-10),'\leftarrow Masina za bakar')

%==========================================================================
%==========================================================================
% Machine tool #5 - tri stubne busilice
% define bounds

x51min = 91; x51max = 96; y51min = 133; y51max = 140;
x52min = 91; x52max = 96; y52min = 120; y52max = 127;
x53min = 75; x53max = 80; y53min = 120; y53max = 125;

    % #51
    % define lower x bound
    x51obs_1 = [x51min:inkrement :x51max]';
    y51obs_1 = [y51min*ones(size(x51obs_1,1),1)];
    

    % define upper x bound
    x51obs_2 = [x51min:inkrement :x51max]';
    y51obs_2 = [y51max*ones(size(x51obs_2,1),1)];
    

    % define lower y bound
    y51obs_3 = [y51min:inkrement :y51max]';
    x51obs_3 = [x51min*ones(size(y51obs_3,1),1)];
    

    % define upper y bound
    y51obs_4 = [y51min:inkrement :y51max]';
    x51obs_4 = [x51max*ones(size(y51obs_4,1),1)];
    
    
    obs51 = [[x51obs_1 y51obs_1];[x51obs_2 y51obs_2] ;[x51obs_3 y51obs_3] ;[x51obs_4 y51obs_4]];

    r4 = rectangle('Position',[x51min,y51min,(x51max-x51min),(y51max-y51min)],'Curvature',[.1,.1],...
              'FaceColor','r','LineWidth',2,'LineStyle','-');
    daspect([1,1,1]);
%     text((76-10-2-15),(137-10),'Stubna busilica \rightarrow')

    % #52
    % define lower x bound
    x52obs_1 = [x52min:inkrement :x52max]';
    y52obs_1 = [y52min*ones(size(x52obs_1,1),1)];
    

    % define upper x bound
    x52obs_2 = [x52min:inkrement :x52max]';
    y52obs_2 = [y52max*ones(size(x52obs_2,1),1)];
    

    % define lower y bound
    y52obs_3 = [y52min:inkrement :y52max]';
    x52obs_3 = [x52min*ones(size(y52obs_3,1),1)];
    

    % define upper y bound
    y52obs_4 = [y52min:inkrement :y52max]';
    x52obs_4 = [x52max*ones(size(y52obs_4,1),1)];
    
    obs52 = [[x52obs_1 y52obs_1];[x52obs_2 y52obs_2] ;[x52obs_3 y52obs_3] ;[x52obs_4 y52obs_4]];

    r4 = rectangle('Position',[x52min,y52min,(x52max-x52min),(y52max-y52min)],'Curvature',[.1,.1],...
              'FaceColor','r','LineWidth',2,'LineStyle','-');
    daspect([1,1,1]);
%         text((80-10-15),(115-10),'Stubna busilica \uparrow')
    % #53
    % define lower x bound
    x53obs_1 = [x53min:inkrement :x53max]';
    y53obs_1 = [y53min*ones(size(x53obs_1,1),1)];
    

    % define upper x bound
    x53obs_2 = [x53min:inkrement :x53max]';
    y53obs_2 = [y53max*ones(size(x53obs_2,1),1)];
    

    % define lower y bound
    y53obs_3 = [y53min:inkrement :y53max]';
    x53obs_3 = [x53min*ones(size(y53obs_3,1),1)];
    

    % define upper y bound
    y53obs_4 = [y53min:inkrement :y53max]';
    x53obs_4 = [x53max*ones(size(y53obs_4,1),1)];
    
    
    obs53 = [[x53obs_1 y53obs_1];[x53obs_2 y53obs_2] ;[x53obs_3 y53obs_3] ;[x53obs_4 y53obs_4]];

    r4 = rectangle('Position',[x53min,y53min,(x53max-x53min),(y53max-y53min)],'Curvature',[.1,.1],...
              'FaceColor','r','LineWidth',2,'LineStyle','-');
    daspect([1,1,1]);hold on
%     text((60-10-2-15),(122.5-10),'Kruzna testera \rightarrow')
%==========================================================================
%==========================================================================
% Machine tool #4 - masina za bakar
% define bounds
x6min = 28.5; x6max = 71.5; y6min = 118; y6max = 121;


r6 = rectangle('Position',[x6min,y6min,(x6max-x6min),(y6max-y6min)],'Curvature',[.1,.1],...
          'FaceColor','r','LineWidth',2,'LineStyle','-');
daspect([1,1,1]);
% text((x4max),(135-10),'\leftarrow Masina za bakar')






%       obstacles = [obsc1;obs1;obs2;obs3;obs4;obs51; obs52;obs53];
      
      obstacles=1;
      
      
end
    