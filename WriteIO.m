dataset = '/tot_correction';
tic

if exist(resultfile, 'file') == 2
    delete(resultfile);
end
toc
% Create dataset
tic
%h5create(resultfile, dataset, [4 256 256 1024], 'Datatype', 'int16', 'ChunkSize', [1 256 256 1024], 'Deflate',9);
h5create(resultfile, dataset, [4 256 256 1024], 'Datatype', 'int16');
toc
% Attributes
tic
h5writeatt(resultfile, dataset, 'creation_date', datestr(now))
toc
% Store data
tic
h5write(resultfile, dataset, ToT_final_M);
toc
%%
clearvars dataset DINKY k 