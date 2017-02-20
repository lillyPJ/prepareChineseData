function [box, tag, word] = loadGTFromTxtFile(txtFileName)
% box = [X,Y,W,H];
% tag = {'ab','ac'};
% word(i).box = [x, y, w, h];   word(i).tag = { 'abc' };
fp = fopen(txtFileName, 'r');
imgName = textscan(fp, '%s', 1);
imgData = textscan(fp,'%d %d %d %d %d %d %d %d %s');
fclose(fp);
if isempty(imgData)
    box = [];
    tag = [];
    word = [];
    return;
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
word = [];
box = zeros(nWord, 4);
for k = 1:nWord
    xs = double([x1(k), x2(k), x3(k), x4(k)]);
    ys = double([y1(k), y2(k), y3(k), y4(k)]);
    xmin = min(xs);
    ymin = min(ys);
    xmax = max(xs);
    ymax = max(ys);
    width = xmax - xmin + 1;
    height = ymax - ymin + 1;
    box(k,:) = [xmin, ymin, width, height];
    word(k).box = [xmin, ymin, width, height];
    tagTemp = tag{k};
    if tagTemp(end) == ';'
        tagTemp = tagTemp(1:end-1);
    end
    if tagTemp == '#'
        word(k).tag = '';
    else
        word(k).tag = tagTemp;
    end
    tag{k} = tagTemp;
    
end