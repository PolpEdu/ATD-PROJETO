anterior=0;
atual=1;
for i=2:10
    novo=anterior+atual;
    anterior=atual;
    atual=novo;
    disp(novo);
end