function [sorted_files] = sorted_sphere_files_from_lib(lib)
files = [];
dir_struct = dir(lib);
numbers = [];
for i=length(dir_struct):-1:1
    files{end+1} = dir_struct(i).name;
    numbers(end+1) = str2double(files{end});
end
I = ~isnan(numbers);
files = files(I);
numbers = numbers(I);
[~,permutaion] = sort(numbers);
sorted_files = {};
for i=1:length(permutaion)
    sorted_files{end+1} = files{permutaion(i)};
end
end

