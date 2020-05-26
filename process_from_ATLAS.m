addpath("C:\Users\Daniel Abutbul\OneDrive - Technion\post_process\");
%%
m=2;n=3;
files = sorted_sphere_files_from_lib('.');
sp_file = files{end};
if m==2 && n == 3
    angle = pi/2;
elseif m==1 && n==4
    angle = 0;
end
%%
load Input_parameters_from_python.mat
state.cyclic_boundary = [Lx Ly];
state.rad = rad;
state.H = H;
state.spheres = dlmread('Initial Conditions');
save('Initial Conditions.mat','state')
state.spheres = dlmread(sp_file);
save(['state ' sp_file],'state')
if m==2 && n==3
    [psi23,E3] = psi_mn(2,3,state,false);
    save(['psi23_E3_' sp_file],'psi23','E3');
    psi = psi23;
elseif m==1 && n==4
    [psi14,E4] = psi_mn(1,4,state,false);
    save(['psi14_E4_' sp_file],'psi14','E4');
    psi = psi14;
end
h=figure;
[gmn, rc, counts] = g_mn(state, psi, true);
save(['orientational_correlation ' sp_file '.mat'],'gmn','rc','counts')
savefig(h,['orientational_correlation ' sp_file]);
if angle == pi/2
    h=figure;
    [g, rc, counts] = g_angle(state, angle, true);
    save(['positional_correlation_y ' sp_file '.mat'],'g','rc','counts');
    savefig(h,['positional_correlation_y ' sp_file]);
elseif angle == 0
    h=figure;
    [g, rc, counts] = g_angle(state, angle, true);
    save(['positional_correlation_x ' sp_file '.mat'],'g','rc','counts');
    savefig(h,['positional_correlation_x ' sp_file]);
else
    h=figure;
    [g, rc, counts] = g_angle(state, angle, true);
    save(['positional_correlation_' num2str(angle) ' ' sp_file '.mat'],'g','rc','counts');
    savefig(h,['positional_correlation_' num2str(angle) ' ' sp_file]);
end