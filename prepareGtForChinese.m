% prepareGtForChinese

% dirs and files
sourceDir = '/home/lili/datasets/chinese/raw';
destDir = '/home/lili/datasets/chinese';

imgNameList = fullfile(sourceDir, 'testName.txt');
sourceGtDir = fullfile(sourceDir, 'gt/all');
imgNames = textread(imgNameList, '%s');
%% make necessary dir

%% load gt for each image
nImg = length(imgNames);
if nImg < 1
    return;
end
for i = 1: nImg
    fprintf('%d: %s\n', i, imgNames{i});
    % get source/dest img/gt dir
    [imgParentDir, imgBaseName] = fileparts(imgNames{i});
    destImgDir = fullfile(destDir, imgParentDir);
    destGtDir = fullfile(strrep(destImgDir, 'img', 'gt'), 'txt', 'word');
    sourceImgFile = fullfile(sourceDir,imgNames{i});
    destImgFile = fullfile(destDir, imgParentDir, [imgBaseName, '.jpg']);
    sourceGtFile = fullfile(sourceGtDir, [imgBaseName, '.JPG.txt']);
    destGtFile = fullfile(destGtDir, [imgBaseName, '.txt']);
    % load gt
    [box, tag] = loadGTFromTxtFile(sourceGtFile);
    % copy img files
    try
        copyfile(sourceImgFile, destImgFile);
    catch   
        checkDir(destImgDir);
        copyfile(sourceImgFile, destImgFile);
    end
    % write gt file
    fp = fopen(destGtFile, 'wt');
    if(fp < 0)
        checkDir(destGtDir);
        fp = fopen(destGtFile, 'wt');
    end
    nWord = size(box, 1);
    if(nWord > 0)
        box(:,3) = box(:,3) + box(:,1);
        box(:,4) = box(:,4) + box(:,2);
    end
    for k = 1:nWord
        fprintf(fp, '%d, %d, %d, %d, "%s"\n', box(k,:), tag{k});
    end
    fclose(fp);      
end

