function [state] = metropolis_step(state, i, dr)
orig = state.spheres;
state.spheres(i,:) = cyclic(state.spheres(i,:) + dr, state.cyclic_boundary);
if ~legal_configuration(state, i)
    state.spheres = orig;
end    
end

