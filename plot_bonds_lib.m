function [] = plot_bonds_lib(lib, plot_delaunay, cutoff)
figure;
rho_H = str2double(regexprep(regexprep(...
    lib,'.*rhoH=',''),'_.*',''));
N = str2double(regexprep(regexprep(...
    lib,'_h=.*',''),'.*N=',''));
h = str2double(regexprep(regexprep(...
    lib,'.*h=',''),'_rhoH.*',''));

sig = 2; H = (h+1)*sig;
if nargin == 2
        cutoff = sqrt( sig^2 - ( (H-sig)/2)^2 );
end
files = sorted_sphere_files_from_lib(lib);
last_sp = [lib '\' files{end}];
if plot_delaunay
    sp = dlmread(last_sp);
%     TRI = delaunay(sp(:,1),sp(:,2));
%     triplot(TRI,sp(:,1),sp(:,2));
    hold on;
    up = sp(:,3)>H/2;
    plot(sp(up,1),sp(up,2),'.Black','MarkerSize',15);
    plot(sp(~up,1),sp(~up,2),'.m','MarkerSize',15);
    spup = sp(up,:);
    TRI = delaunay(spup(:,1),spup(:,2));
    triplot(TRI,spup(:,1),spup(:,2));
    for i=1:length(sp(up))
        I1 = find(TRI(:,1) == i);
        I2 = find(TRI(:,2) == i);
        I3 = find(TRI(:,3) == i);
        I = [I1;I2;I3];
        if length(I) ~= 6
            for j=I
                fill(spup(TRI(j,:),1),spup(TRI(j,:),2),'r');
            end
        end
    end

else
    plot_spheres_bonds(last_sp,cutoff, H);
end
end