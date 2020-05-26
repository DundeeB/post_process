% lib= '../simulation-results/N=3600_h=1_rhoH=0.9566559692967636_AF_triangle_ECMC/';
lib='../simulation-results/N=900_h=0.8_rhoH=0.5904718662166627_AF_triangle_ECMC/'
load([lib '/Input_parameters.mat']);
[sorted_files] = sorted_sphere_files_from_lib(lib);
state.spheres=dlmread([lib '/' sorted_files{end}]);
sorted_files{end}
up = state.spheres(:,3)>state.H/2;
stateup = state; stateup.spheres = state.spheres(up,:);
statedown = state; statedown.spheres = state.spheres(~up,:);
knn_based_bonds(state,3,true);
knn_based_bonds(stateup,6,true);
knn_based_bonds(statedown,6,true);
psi16_up=psi_mn(1,6,stateup);
mean(psi16_up)
abs(mean(psi16_up))
psi23 = psi_mn(2,3,state);
abs(mean(psi23))