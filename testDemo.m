% testDemo: show image and gt

%% files and dirs
imgNameList = 'testName.txt';
gtDir = 'gt/all';

imgNames = textread(imgNameList, '%s');
%% load gt for each image
nImg = length(imgNames);
for i = 1: nImg
    imgNames{i} = 'img/test/IMG_1510.JPG';
    image = imread(imgNames{i});
    [~, imgBaseName] = fileparts(imgNames{i});
    txtFileName = fullfile(gtDir, [imgBaseName, '.JPG.txt']);
    disp(txtFileName);
    % read data from txt
    fp = fopen(txtFileName, 'r');
    imgName = textscan(fp, '%s', 1);
    imgData = textscan(fp,'%d %d %d %d %d %d %d %d %s');
    fclose(fp);
    if isempty(imgData)
        continue;
    end
    % process data 
    x1 = imgData{1};
    y1 = imgData{2};
    x2 = imgData{3};
    y2 = imgData{4};
    x3 = imgData{5};
    y3 = imgData{6};
    x4 = imgData{7};
    y4 = imgData{8};
    tag = imgData{9};
    nWord = length(imgData{1});
    words = [];
    for k = 1:nWord
        xs = double([x1(k), x2(k), x3(k), x4(k)]);
        ys = double([y1(k), y2(k), y3(k), y4(k)]);
        xmin = min(xs);
        ymin = min(ys);
        xmax = max(xs);
        ymax = max(ys);
        width = xmax - xmin + 1;
        height = ymax - ymin + 1;
        words(k).box = [xmin, ymin, width, height];
        tagTemp = tag{k};
        if tagTemp(end) == ';'
            tagTemp = tagTemp(1:end-1);
        end
        if tagTemp == '#'
            words(k).tag = '';
        else
            words(k).tag = tagTemp;
        end
        
    end
    % show image and tag
    imshow(image);
    displayBoxAndTag(words');
end