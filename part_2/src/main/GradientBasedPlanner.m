function route = GradientBasedPlanner(f, start_coords, end_coords, max_its)
    % требуется найти путь на плоскости на основании градиента функции f 
    % входные данные:
    %     start_coords и end_coords -- координаты начальной и конечной точек
    %     max_its -- максимальное число возможных итераций 
    % выходные данные:
    %     route -- массив из 2 столбцов и n строк
    %     каждая строка соответствует координатам x, y робота (по мере прохождения пути)

    [gx, gy] = gradient(-f);
    
    % *********************************************************************
    % ВАШ КОД ДОЛЖЕН НАХОДИТЬСЯ ЗДЕСЬ
    
    [nrows, ncols] = size(f);
    for i = 1 : nrows
        for j = 1 : ncols
            normv = norm([gx(i, j), gy(i, j)]);
            gx(i, j) = gx(i, j) / normv;
            gy(i, j) = gy(i, j) / normv;
        end
    end
    
    curr_coords = start_coords;
    route = start_coords;
    
    it_num = 0;
    while (norm(end_coords - curr_coords) > 1 && it_num < max_its)
        it_num = it_num + 1;
        
        coords_1 = fix(curr_coords) - 1;
        coords_2 = fix(curr_coords) - [1, 0];
        coords_3 = fix(curr_coords) - [0, 1];
        coords_4 = fix(curr_coords);
        
        offset_1 = [gx(coords_1(2), coords_1(1)), gy(coords_1(2), coords_1(1))];
        offset_2 = [gx(coords_2(2), coords_2(1)), gy(coords_2(2), coords_2(1))];
        offset_3 = [gx(coords_3(2), coords_3(1)), gy(coords_3(2), coords_3(1))];
        offset_4 = [gx(coords_4(2), coords_4(1)), gy(coords_4(2), coords_4(1))];
        
        offset_12 = (1 - norm(curr_coords(1) - coords_1(1))) * offset_1 + ...
                    (1 - norm(curr_coords(1) - coords_2(1))) * offset_2;
        offset_34 = (1 - norm(curr_coords(1) - coords_3(1))) * offset_3 + ...
                    (1 - norm(curr_coords(1) - coords_4(1))) * offset_4;
        offset    = (1 - norm(curr_coords(2) - coords_1(2))) * offset_12 + ...
                    (1 - norm(curr_coords(2) - coords_4(2))) * offset_34;  
        
        next_coords = curr_coords + offset;
                   
        if (next_coords(1) <= 1 || next_coords(1) > nrows)
            break;
        end
        
        if (next_coords(2) <= 1 || next_coords(2) > ncols)
            break;
        end
        
        route(end + 1, :) = next_coords;
        curr_coords = next_coords;
    end

    % *********************************************************************
end
