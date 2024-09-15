% Task 3: Compute Pi with User-Defined Precision 
function computed_pi = compute_pi()
   
    % Ask user for the desired precision level
    desired_precision = input('Enter the desired precision level (for example: 1 or 2 or 3): ');

    % Initialize variables
    tolerance = 10^-(desired_precision);  % Tolerance based on user-specified precision
    inside_circle = 0;  
    N = 0;  
    computed_pi = 0;  % Initial estimate of Pi
    previous_pi = NaN;  % To store the previous computed value of Pi
    min_iterations = 5000;  % Minimum iterations to prevent early stopping
    
    % figure for graphical display
    figure;
    hold on;
    axis equal;
    axis([0 1 0 1]);
    title(sprintf('Estimating Pi with Precision: %d ', desired_precision));
    xlabel('X');
    ylabel('Y');
    
    % Start the Monte Carlo simulation
    tic;  % Start timer
    
    while true
        N = N + 1;  
        x = rand;  
        y = rand;  
        
        % Check if the point is inside the quarter circle
        if x^2 + y^2 <= 1
            inside_circle = inside_circle + 1;
            plot(x, y, 'g.');  % Plot points inside the circle in green
        else
            plot(x, y, 'r.');  % Plot points outside the circle in red
        end
        
        % Estimate Pi based on the number of points
        previous_pi = computed_pi;  % Store the previous Pi value
        computed_pi = 4 * inside_circle / N;  % Monte Carlo estimation of Pi
        
        % Ensure a minimum number of iterations
        if N > min_iterations
            % Check if the computed Pi value is stable to the desired significant figures
            if abs(round(computed_pi, desired_precision) - round(previous_pi, desired_precision)) < tolerance
                break;  % Exit the loop if the desired precision is achieved
            end
        end
        
        
        if mod(N, 100) == 0
            drawnow;
        end
    end
    
    % Stop timer and calculate execution time
    execution_time = toc;

    % print the results 
    fprintf('Computed Pi = %.10f\n', computed_pi);
    fprintf('Number of iterations = %d\n', N);
    fprintf('Execution time = %.5f seconds\n', execution_time);

    % final result on the plot
    text(0.5, 0.5, sprintf('\\pi \\approx %.10f', computed_pi), 'FontSize', 14, 'HorizontalAlignment', 'center');
      
end
