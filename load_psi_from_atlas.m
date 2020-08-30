function psi = load_psi_from_atlas(file)
if isnumeric(file); return; end   %user canceled
[fid, message] = fopen(file, 'rt');
if fid < 0; error('Failed to open file "%s" because "%s"', file, message); end
psi = cell2mat( textscan(fid, '(%f)') );
fclose(fid);
end