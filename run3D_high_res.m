rho_H_arr = [0.1:0.2:0.9 1.05];
I1 = ones(1, length(rho_H_arr));
rho_H_arr = [rho_H_arr rho_H_arr rho_H_arr];
I = ones(1, length(rho_H_arr));
h_arr = [1*I1 0.8*I1 0.9*I1];
n_row_arr = 2*50*I;
n_col_arr = 2*18*I;

IC_pool = {'square','triangle','AF_triangle'};
Initial_Conditions_arr(1:length(n_col_arr)) = {IC_pool{3}};

for j = 1:length(n_col_arr)
    tic;
    rho_H = rho_H_arr(j);
    h = h_arr(j);
    n_row = n_row_arr(j);
    n_col = n_col_arr(j);
    N = n_row * n_col;
    C = Initial_Conditions_arr(j);
    Initial_Conditions = C{1};
    
    state.rad = 1;
    sig = 2*state.rad;
    state.H = (h+1)*sig;

    switch Initial_Conditions
        case IC_pool{1}
            state.cyclic_boundary = sqrt(1/(rho_H*(1+h)))*sig*sqrt(N)*[1 1];
            state.spheres = antiferro_rect_starting_cond3D([n_col n_row 1],...
                [state.cyclic_boundary state.H],state.rad);
            sim_name = ['N=' num2str(N) '_h=' num2str(h), '_rhoH=' ...
                num2str(rho_H) '_' IC_pool{1}]
    	case IC_pool{2}
            a = sqrt(sig^2/(rho_H*(h+1)*sin(pi/3)));
            Lx = n_col*a;
            Ly = n_row*a*sin(pi/3);
            state.cyclic_boundary = [Lx Ly];
            state.spheres = ferro_triang_starting_cond3D([n_col n_row 1],...
                [state.cyclic_boundary state.H],state.rad);
            sim_name = ['N=' num2str(N) '_h=' num2str(h), '_rhoH=' ...
                num2str(rho_H) '_' IC_pool{2}]
        case IC_pool{3}
            a = sqrt(2*sig^2/(rho_H*(h+1)*sin(pi/3)));
            Lx = n_col*a;
            Ly = n_row/2*a*sin(pi/3);
            state.cyclic_boundary = [Lx Ly];
            state.spheres = antiferro_triang_starting_cond3D...
                ([n_col n_row 1],[state.cyclic_boundary state.H],state.rad);
            sim_name = ['N=' num2str(N) '_h=' num2str(h), '_rhoH=' ...
                num2str(rho_H) '_' IC_pool{3}]
    end
    A = state.cyclic_boundary(2)*state.cyclic_boundary(1);
    eta2D = N*pi*state.rad^2/A;
    eta3D = N*4*pi/3*state.rad^3/(A*state.H);
    title_name = ['N=' num2str(N) ', h=' num2str(h), ', \rho_H=' num2str(rho_H)];
    %%
    addpath('.');
    cd('simulation-results'); mkdir(sim_name); cd(sim_name);
    %%
    if ~legal_configuration(state,1)
        cd('../..');
        error('too many spheres');
    end

    N_real  = 1e4*N/9*5;
    L = state.H;
    f = 0.2;
    step_size = f*(sqrt((state.cyclic_boundary(2)/n_row)^2+(state.cyclic_boundary(1)/n_col)^2)-2*state.rad);
    N_save = 1e4;
    N_start = 1e4;
    %%
    save('Input_parameters');
    %%
    q = 0;
    for i=1:N_real
        t = rand*2*pi;
        if step_size > state.H
            phi = (2*rand-1)*(asin(state.H/step_size));
        else
            phi = rand*pi;
        end
        i_p = randi(N);
        [state, q_] = metropolis_step(state, i_p, step_size*[sin(phi)*cos(t) sin(phi)*sin(t) cos(phi)]);
        q = q + q_;
        if mod(i,N_real/10)==0
            disp([num2str(i/N_real*100) '%']);
        end

        if (mod(i,N_save) == 0 && i > N_start) || i==N_real
            dlmwrite(num2str(i),state.spheres,'\t');
        end
    end
    %% write first and last sphere
    subplot(1,2,2); 
    plot_spheres(state); 
    title([num2str(i) ' step. Acceptance rate: ' ...
        num2str(100*q/i) '%, steps per sphere: ' num2str(q/N)]);
    load('Input_parameters');
    subplot(1,2,1); 
    plot_spheres(state); 
    title(title_name);
    savefig('Starting_and_Final_configuration.fig')
    close all;
    %%
    cd('../../');
    toc;
    %%
    tic;
    post_process(['simulation-results\' sim_name],false, 'output');
    toc;
end
