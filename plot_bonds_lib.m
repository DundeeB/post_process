function [] = plot_bonds_lib(lib, plot_option, cutoff)
rho_H = str2double(regexprep(regexprep(...
    lib,'.*rhoH=',''),'_.*',''));
N = str2double(regexprep(regexprep(...
    lib,'_h=.*',''),'.*N=',''));
h = str2double(regexprep(regexprep(...
    lib,'.*h=',''),'_rhoH.*',''));

figure;
title(['N=' num2str(N) ', \rho_H=' num2str(rho_H) ', h=' num2str(h)]);

sig = 2; H = (h+1)*sig;
files = sorted_sphere_files_from_lib(lib);
last_sp = [lib '\' files{end}];

load([lib '\Input_parameters.mat']);
sp = dlmread(last_sp);

switch plot_option
    case 1
        if nargin == 2
            cutoff = inf;
        end
        hold on;
        spup = sp(sp(:,3)>H/2,:);
        [ bonds, spup] = plot_spheres_bonds( spup, cutoff, H, state.cyclic_boundary );
        is = [];
        colours = [{}];
        for i=1:length(spup)
            I = find(bonds(:,1) == i | bonds(:,2) == i);
            if length(I) ~= 6
                is(end+1) = i;
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
    case 2
        if nargin == 2
            cutoff = inf;
        end
        hold on;
        spup = sp(sp(:,3)>H/2,:);
        [ bonds, spup] = plot_spheres_bonds( spup, cutoff, H, state.cyclic_boundary );
        is = [];
        colours = [{}];
        for i=1:length(spup)
            I = find(bonds(:,1) == i | bonds(:,2) == i);
            if length(I) ~= 6
                is(end+1) = i;
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

        spup = sp(sp(:,3)<=H/2,:);
        [ bonds, spup] = plot_spheres_bonds( spup, cutoff, H, state.cyclic_boundary );
        is = [];
        colours = [{}];
        for i=1:length(spup)
            I = find(bonds(:,1) == i | bonds(:,2) == i);
            if length(I) ~= 6
                is(end+1) = i;
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
    case 3
        if nargin == 2
            cutoff = sqrt( sig^2 - ( (H-sig)/2)^2 );
        end
        hold on;
        [ bonds, sp] = plot_spheres_bonds( sp, cutoff, H, state.cyclic_boundary );
        for i=1:length(sp)
            I = find(bonds(:,1) == i | bonds(:,2) == i);
            if length(I) == 2
                plot(sp(i,1),sp(i,2),'.c','MarkerSize',40);
            end
        end
    case 4
        up = sp(:,3) > H/2;
        plot(sp(up,1),sp(up,2),'oBlack','MarkerSize',15,'LineWidth',3);hold on;
        plot(sp(~up,1),sp(~up,2),'om','MarkerSize',15,'LineWidth',3);
    otherwise
        if nargin == 2
            cutoff = sqrt( sig^2 - ( (H-sig)/2)^2 );
        end
        plot_spheres_bonds( sp, cutoff, H, state.cyclic_boundary );
end

end