%% Define various colours and colourmaps to be used in figures

newcolors=...
    [161,218,180
65,182,196
34,94,168]/255;

newcolors_2 = ...
    [215,48,39
252,141,89
254,224,144
145,191,219
69,117,180]/255;

col1=[31,120,180]/255;
col2=[178,223,138]/255;
col3=[51,160,44]/255;

col4=[122,1,119]/255;
col5=[247,104,161]/255;
col6=[251,180,185]/255;


cm_1=[255,255,204
161,218,180
65,182,196
34,94,168];
cm_1=cm_1/255;
cm_levels=19;
cm_1i=zeros(cm_levels,3);
for J=1:3
cm_1i(:,J)=interp1(linspace(0,1,4),cm_1(:,J),linspace(0,1,cm_levels));
end

cm_main=cm_1i;

