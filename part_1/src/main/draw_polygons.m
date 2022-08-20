function draw_polygons(p1, p2)
    figure();
    plot([p1(:, 1); p1(1, 1)], [p1(:, 2); p1(1, 2)], 'r', ...
         [p2(:, 1); p2(1, 1)], [p2(:, 2); p2(1, 2)], 'b');
     
    xmin = min([p1(:, 1); p2(:, 1); 0]);
    xmax = max([p1(:, 1); p2(:, 1); 0]);
    ymin = min([p1(:, 2); p2(:, 2); 0]);
    ymax = max([p1(:, 2); p2(:, 2); 0]);
    
    xmin = (sign(xmin) * ceil((abs(xmin) + 0.05) / 0.5)) * 0.5;
    xmax = (sign(xmax) * ceil((abs(xmax) + 0.05) / 0.5)) * 0.5;
    ymin = (sign(ymin) * ceil((abs(ymin) + 0.05) / 0.5)) * 0.5;
    ymax = (sign(ymax) * ceil((abs(ymax) + 0.05) / 0.5)) * 0.5;
    
    axis equal;
    axis([min(xmin, ymin), max(xmax, ymax), ...
          min(xmin, ymin), max(xmax, ymax)])
      
    grid on;
    grid minor;
    
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$y$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('\mbox{\boldmath ${p}$}$_1$', '\mbox{\boldmath ${p}$}$_2$', ...
           'Interpreter', 'latex', 'FontSize', 10);
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
end
