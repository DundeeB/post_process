function [] = plot_bonds_lib(lib, plot_option, cutoff)
rho_H = str2double(regexprep(regexprep(...
    lib,'.*rhoH=',''),'_.*',''));
N = str2double(regexprep(regexprep(...
    lib,'_h=.*',''),'.*N=',''));
h = str2double(regexprep(regexprep(...
    lib,'.*h=',''),'_rhoH.*',''));

if plot_option<10
figure;
title(['N=' num2str(N) ', \rho_H=' num2str(rho_H) ', h=' num2str(h)]);
end

files = sorted_sphere_files_from_lib(lib);
last_sp = [lib '\' files{end}];

try
    load([lib '\Input_parameters.mat']);
catch err
    load_lib;cd(home_dir);
end
sp = dlmread(last_sp);
state.spheres = sp;
sig = state.rad*2; H = state.H;
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
    case 13
        knn_based_bonds(state, 3, true);
        title('knn with k=3');
    case 14
        knn_based_bonds(state, 4, true);
        title('knn with k=4');
    case 16
        knn_based_bonds(state, 6, true);
        title('knn with k=6');
    case 60
        if nargin == 2
            cutoff = inf;
        end
        hold on;
        spup = sp;
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
        hold on;
        plot_circles(state);
    otherwise
        if nargin == 2
            cutoff = sqrt( sig^2 - ( (H-sig)/2)^2 );
        end
        plot_spheres_bonds( sp, cutoff, H, state.cyclic_boundary );
end

end