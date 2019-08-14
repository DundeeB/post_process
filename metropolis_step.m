function [state, q] = metropolis_step(state, i, dr)
orig = state.spheres;
state.spheres(i,:) = cyclic(state.spheres(i,:) + dr, state.cyclic_boundary);
q = 1;
if ~legal_configuration(state, i)
    state.spheres = orig;
    q = 0;
end    
end

