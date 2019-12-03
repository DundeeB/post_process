function [] = plot_bonds_lib(lib, plot_delaunay, cutoff)
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
    TRI = delaunay(sp(:,1),sp(:,2));
    triplot(TRI,sp(:,1),sp(:,2));
    hold on;
    I = sp(:,3)>H/2;
    plot(sp(I,1),sp(I,2),'.Black','MarkerSize',15);
    plot(sp(~I,1),sp(~I,2),'.m','MarkerSize',15);
else
    plot_spheres_bonds(last_sp,cutoff, H);
end
end