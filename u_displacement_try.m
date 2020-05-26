lib='../simulation-results/N=3600_h=1_rhoH=0.6042037700821663_AF_square_ECMC/';
load([lib '/Input_parameters.mat']);
[sorted_files] = sorted_sphere_files_from_lib(lib);
state.spheres=dlmread([lib '/' sorted_files{end}]);
sp  = state.spheres;
up = sp(:,3)>state.H/2;
spup = sp(up,:);
down = ~up;
spdown = sp(down,:);
u_dis = zeros(size(spup(:,1:2)));
figure; hold on;
for i=1:length(spup)
    r1 = spup(i,1:2);
    dr_min = inf;
    j_min = nan;
    for j=1:length(spdown)
        r2 = spdown(j,1:2);
        dr = norm(r2-r1);
        if dr<dr_min
            dr_min = dr;
            j_min = j;
        end
    end
    r2 = spdown(j_min,1:2);
    u_dis(i,:) = r1 - spdown(j_min,1:2);
    plot([r1(1) r2(1)],[r1(2) r2(2)],'o-');
end
%%
figure;
plot(u_dis(:,1),u_dis(:,2),'o');
figure;
hist(sqrt(u_dis(:,1).^2+u_dis(:,2).^2));