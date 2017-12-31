files = dir('*.fig');
for file = files'
    figName=file.name;
    h=openfig(figName,'new','invisible');
    outname = figName(1:end-4);
    saveas(h,outname,'jpg')
    close(h);
end