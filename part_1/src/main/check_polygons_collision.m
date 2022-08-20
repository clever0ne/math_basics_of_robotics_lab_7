function check = check_polygons_collision(p1, p2, draw)
    if (nargin < 3)
        draw = true;
    end
    
    if (draw == true)
        draw_polygons(p1, p2);
    end
    
    check = true;
    
    p1(:, 3) = 0;
    p1(end + 1, :) = p1(1, :);
    
    p2(:, 3) = 0;
    p2(end + 1, :) = p2(1, :);
    
    n1 = cross((p1(2 : end, :) - p1(1 : end - 1, :))', ...
               [0, 0, 1]' * ones(1, size(p1, 1) - 1));
    for idx = 1 : size(n1, 1)
        n1(:, idx) = n1(:, idx) / norm(n1(:, idx));
    end
    
    n2 = cross((p2(2 : end, :) - p2(1 : end - 1, :))', ...
               [0, 0, 1]' * ones(1, size(p2, 1) - 1));
    for idx = 1 : size(n2, 1)
        n2(:, idx) = n2(:, idx) / norm(n2(:, idx));
    end
    
    temp1 = p1(1 : end - 1, :) * [n1, n2];
    temp2 = p2(1 : end - 1, :) * [n1, n2];
    
    min1 = min(temp1);
    max1 = max(temp1);
    min2 = min(temp2);
    max2 = max(temp2);
    
    for idx = 1 : size([n1, n2], 2)
        s = (max1(idx) - min1(idx)) + (max2(idx) - min2(idx));
        l = max(max1(idx), max2(idx)) - min(min1(idx), min2(idx));
        
        if (l > s)
            check = false;
        end
    end
end
