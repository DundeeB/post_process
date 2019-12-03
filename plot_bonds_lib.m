function [] = plot_bonds_lib(lib, plot_delaunay, cutoff)
rho_H = str2double(regexprep(regexprep(...
    lib,'.*rhoH=',''),'_.*',''));
N = str2double(regexprep(regexprep(...
    lib,'_h=.*',''),'.*N=',''));
h = str2double(regexprep(regexprep(...
    lib,'.*h=',''),'_rhoH.*',''));

figure;
title(['N=' num2str(N) ', \rho_H=' num2str(rho_H) ', h=' num2str(h)]);

sig = 2; H = (h+1)*sig;
if nargin == 2
        cutoff = sqrt( sig^2 - ( (H-sig)/2)^2 );
end
files = sorted_sphere_files_from_lib(lib);
last_sp = [lib '\' files{end}];

if plot_delaunay
    load([lib '\Input_parameters.mat']);
    sp = dlmread(last_sp);
    sp = wrap_sp_with_periodic_bd(sp,state.cyclic_boundary);
    hold on;
    up = sp(:,3)>H/2;
    plot(sp(up,1),sp(up,2),'.Black','MarkerSize',10);
    plot(sp(~up,1),sp(~up,2),'.m','MarkerSize',10);
    spup = sp(up,:);
    TRI = delaunay(spup(:,1),spup(:,2));
    triplot(TRI,spup(:,1),spup(:,2));
    is = [];
    colours = [{}];
    for i=1:length(sp(up))
        I1 = find(TRI(:,1) == i);
        I2 = find(TRI(:,2) == i);
        I3 = find(TRI(:,3) == i);
        I = [I1;I2;I3];
        if length(I) ~= 6
            is = [is i];
            switch length(I)
                case 4
                    colour = 'm';
                case 5
                    colour = 'b';
                case 7
                    colour = 'g';
                case 8
                    colour = 'r';
                otherwise
                    colour = 'Black';
            end
            colours(end+1) = {colour};
        end
    end
    for k=1:length(is)
        c = colours(k);
        c = c{1};
        plot(spup(is(k),1),spup(is(k),2),['.' c],'MarkerSize',40);
    end    
else
    plot_spheres_bonds(last_sp,cutoff, H);
end

L = min(state.cyclic_boundary(1:2));
xlim([0 L]);
ylim([0 L]);
axis equal;
end