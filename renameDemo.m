% rename gt(20150124_IMG_8331.JPG.txt to IMG_8331.txt)

originGtDir = 'gt/all/';
newGtDir = 'gt/allNew/';
mkdir(newGtDir);

files = dir(fullfile(originGtDir, '*.txt'));
nfiles = numel(files);
for i = 1: nfiles
    sourceFile = fullfile(originGtDir, files(i).name);
    name = files(i).name;
    if(length(files(i).name) > 12)
        destFile = fullfile(newGtDir, [name(10:end-7), 'txt']);
    else
        destFile = fullfile(newGtDir, [name(1:end-7), 'txt']);
    end
    copyfile(sourceFile, destFile);
end