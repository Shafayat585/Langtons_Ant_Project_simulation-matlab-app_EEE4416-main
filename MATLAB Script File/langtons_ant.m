function langtons_ant(gridsize, num_of_steps, speed)

    % Initializing grid,ant's position and direction
    g = zeros(gridsize);       % 0 = white, 1 = black
    % Ant's starting position (Middle of the grid)
    antX = ceil(gridsize / 2); % initial X position of ant
    antY = ceil(gridsize / 2); % initial Y position of ant
    % direction declare: 0 = up, 1 = right, 2 = down, 3 = left
    direction = 0;             % initially ant is facing upward                 

    % Visualization setup
    figure;
    axis off;
    hold on;
    
    % Simulation loop
    for step = 1:num_of_steps
        % Ploting the current state of the grid at declared speed
        if mod(step, speed) == 0  % updating plot for every speed step
            % speed is the interval at which user want to update the plot
            % Plot the grid
            imagesc(g * 255); % Scale the grid to 255 for black/white display
            colormap([1 1 1; 0 0 0]); % White([1 1 1]) for 0, Black([0 0 0]) for 1
            hold on;  % holds or stores the grid state so that new plot can be added without deleting the current plot
            % Plot the ant
            plot(antY, antX, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Ploting the ant
            hold off; % releases the hold so that current ant position is plotted & previous positions are eraised
            drawnow;  % plot is rendered in real-time during the simulation
        end

        % Moving the ant depending on current grid cell colour & ant's current direction
        if g(antX, antY) == 0       % current gird cell colour = white
            % White cell: turn right (condition of langtons ant)
            g(antX, antY) = 1;      % changing grid cell colour to black
            if direction == 0       % current direction = up
                direction = 1;      % new direction = right
            elseif direction ==1    % current direction = right
                direction = 2;      % new direction = down
            elseif direction == 2   % current direction = down
                direction = 3;      % new direction = left
            elseif direction == 3   % current direction = left
                direction = 0;      % new direction = up
            end
            
        elseif g(antX, antY) == 1   % current gird cell colour = black
            % Black cell: turn left (condition of langtons ant)
            g(antX, antY) = 0;      % changing grid cell colour to white
            if direction == 0       % current direction = up
                direction = 3;      % new direction = left
            elseif direction ==1    % current direction = right
                direction = 0;      % new direction = up
            elseif direction == 2   % current direction = down
                direction = 1;      % new direction = right
            elseif direction == 3   % current direction = left
                direction = 2;      % new direction = down
            end
        end
        
        % Moving the ant forward in the grid
        if direction == 0     % Up
            antX = antX - 1;  % ant goes upward by one grid cell
        elseif direction == 1 % Right
            antY = antY + 1;  % ant goes right by one grid cell 
        elseif direction == 2 % Down
            antX = antX + 1;  % ant goes down by one grid cell
        elseif direction ==3  % Left
            antY = antY - 1;  % ant goes left by one grid cell
        end

        % if movement of ant exceeds grid limit (boundary conditions to make the movement continuous)
        % X-axis condition to make the movement continuous
        if antX < 1              % ant crossing the upper boundary
            antX = gridsize;     % ant will continue from lower boundary
        elseif antX > gridsize   % ant crossing the lower boundary
            antX = 1;            % ant will continue from upper boundary
        end
        % Y-axis condition to make the movement continuous
        if antY < 1              % ant crossing the left-side boundary
            antY = gridsize;     % ant will continue from right-side boundary
        elseif antY > gridsize   % ant crossing the right-side boundary
            antY = 1;            % ant will continue from left-side boundary
        end
    end

    % Final plot of the grid
    imagesc(g * 255); % Scale the grid to 255 for black/white display(display is black & white as we used [1 1 1; 0 0 0]) as colours are scaled to 0 to 255
    colormap([1 1 1; 0 0 0]); % White for 0, Black for 1 ; [1 1 1] makes background white, [0 0 0] makes movement colour black; these three are [R G B] colouring
    hold on;   % holds or stores the grid state so that privious grid state doesn't get eraised
    plot(antY, antX, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Plot the ant
    hold off;  % releases the hold so that current ant position is plotted & previous positions are eraised
    title(['Langton''s Ant after ', num2str(num_of_steps), ' steps']); % gives tittle to the plot
end