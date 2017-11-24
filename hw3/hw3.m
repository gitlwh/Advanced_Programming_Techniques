k=3;
d=5;
sep = 20;
startx = 10;
starty = 10;
nums = 10;
colors = ['r' 'g' 'b' 'y' 'm' 'c' 'w'];
for n=0:k-1
    a=startx+sep*n;
    b=starty+sep*n;
    x = d.*randn(nums,1) + a;
    y = d.*randn(nums,1) + b;
    if n == 0
        res = [x y];
    else
        res = [res;[x y]];
    end
end
hold on;
num = length(res);
for i=1:num
    plot(res(i,1),res(i,2),'b','Marker','.','LineStyle','none');
end
[x,y] = ginput(3);
res = [res;[x,y]];
hold off;


clusters = k;
num = length(res);
% initialize
index = randperm(num, clusters);
dis = zeros(num, clusters);
label = zeros(num, 1);
center = res(index, :);
step = 0;


while(1) 
   % save the centers for each clutters of last iteration
   pre_center = center;
   % calculate distance between data points and clutter centers
   for i = 1:num
       for j = 1:clusters
           dis(i, j) = norm(res(i,:) - center(j, :));
       end
   end
   % construct new clutters
   for i = 1:num
       label(i) = find(dis(i,:)==min(dis(i,:)));
   end
   % attain new centers
   for i = 1:clusters
       one_clutter = res(find(label==i), :);
       center(i, :) = mean(one_clutter);
   end
   % test the terminating condition
   if (center == pre_center)
       break;
   end
   step = step + 1;
end
hold on
for i=1:clusters
    plot(center(i,1),center(i,2),'k','Marker','*','LineStyle','none');
end
for i=1:num
    l = label(i);
    plot(res(i,1),res(i,2),colors(l),'Marker','.','LineStyle','none');
end
hold off
