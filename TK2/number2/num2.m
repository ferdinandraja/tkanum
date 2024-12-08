a = 0;
b = 10;

y_labels = [1, 0];
num_labels = length(y_labels);

N_values = [10, 50, 100, 500, 1000];
num_trials = length(N_values);

TOL = 1e-4;

m_values = [4, 6, 7, 9, 10];
romberg_subdivisions = 2.^(m_values - 1);
num_romberg_trials = length(m_values);

reference_integrals = zeros(1, num_labels);
reference_times = zeros(1, num_labels);

for label = 1:num_labels
    y = y_labels(label);
    fprintf('========== Reference Integral (y = %d) ==========\n', y);
    tic;
    reference_integral = romberg_method(a, b, 10, y);
    time_ref = toc;
    reference_integrals(label) = reference_integral;
    reference_times(label) = time_ref;
    fprintf('Reference Integral (Romberg Method, m = 10, y = %d): %.10f\n', y, reference_integral);
    fprintf('Computation Time: %.6f seconds\n\n', time_ref);
end

for label = 1:num_labels
    y = y_labels(label);
    fprintf('========== Composite Simpson Method Trials (y = %d) ==========\n', y);
    fprintf('N\tIntegral\t\t\tComputation Time (s)\tError\n');

    simpson_integrals = zeros(1, num_trials);
    simpson_times = zeros(1, num_trials);
    errors_simpson = zeros(1, num_trials);
    
    for i = 1:num_trials
        N = N_values(i);

        if mod(N, 2) ~= 0
            N_simpson = N + 1;
        else
            N_simpson = N;
        end

        tic;

        integral = composite_simpson(a, b, N_simpson, y);
        
        time_elapsed = toc;

        simpson_integrals(i) = integral;
        simpson_times(i) = time_elapsed;
        errors_simpson(i) = abs(integral - reference_integrals(label));

        fprintf('%d\t%.10f\t%.6f\t\t%.10f\n', N_simpson, integral, time_elapsed, errors_simpson(i));
    end
    fprintf('====================================================\n\n');

    simpson_results_integral(label, :) = simpson_integrals;
    simpson_results_time(label, :) = simpson_times;
    simpson_results_error(label, :) = errors_simpson;
end

for label = 1:num_labels
    y = y_labels(label);
    fprintf('========== Adaptive Quadrature Method (y = %d) ==========\n', y);
    tic;
    [adaptive_integral, N_total] = adaptive_quadrature(a, b, TOL, y);
    adaptive_time = toc;
    fprintf('Integral: %.10f\n', adaptive_integral);
    fprintf('Error: %.10f\n', abs(adaptive_integral - reference_integrals(label)));
    fprintf('Total Subdivisions (N): %d\n', N_total);
    fprintf('Computation Time: %.6f seconds\n\n', adaptive_time);

    if mod(N_total, 2) ~= 0
        N_total = N_total + 1;
    end
    
    fprintf('========== Composite Simpson Method (N = %d, y = %d) ==========\n', N_total, y);
    tic;
    simpson_integral_adaptive = composite_simpson(a, b, N_total, y);
    simpson_time_adaptive = toc;
    fprintf('Integral: %.10f\n', simpson_integral_adaptive);
    fprintf('Error: %.10f\n', abs(simpson_integral_adaptive - reference_integrals(label)));
    fprintf('Computation Time: %.6f seconds\n\n', simpson_time_adaptive);
    
    fprintf('========== Comparison: Adaptive Quadrature vs. Composite Simpson (y = %d) ==========\n', y);
    fprintf('Integral Difference: %.10f\n', abs(adaptive_integral - simpson_integral_adaptive));
    fprintf('Time Difference: %.6f seconds\n', abs(adaptive_time - simpson_time_adaptive));
    fprintf('====================================================\n\n');
end


for label = 1:num_labels
    y = y_labels(label);
    fprintf('========== Romberg Method Experiments (y = %d) ==========\n', y);
    fprintf('m\tN=2^(m-1)\tIntegral\t\tComputation Time (s)\tError\n');
    
    % Initialize arrays to store Romberg results
    romberg_integrals = zeros(1, num_romberg_trials);
    romberg_times = zeros(1, num_romberg_trials);
    errors_romberg = zeros(1, num_romberg_trials);
    
    for i = 1:num_romberg_trials
        m = m_values(i);
        N_romberg = romberg_subdivisions(i);
        
        tic;
        integral_romberg = romberg_method(a, b, m, y);
        time_romberg = toc;
        
        error_romberg = abs(integral_romberg - reference_integrals(label));
        
        romberg_integrals(i) = integral_romberg;
        romberg_times(i) = time_romberg;
        errors_romberg(i) = error_romberg;
        
        fprintf('%d\t%d\t\t%.10f\t%.6f\t%.10f\n', m, N_romberg, integral_romberg, time_romberg, error_romberg);
    end
    fprintf('====================================================\n\n');
    
    % Store results for plotting
    romberg_results_integral(label, :) = romberg_integrals;
    romberg_results_time(label, :) = romberg_times;
    romberg_results_error(label, :) = errors_romberg;
end


for label = 1:num_labels
    y = y_labels(label);
    fprintf('========== Summary Table (y = %d) ==========\n\n', y);
    
    % Composite Simpson
    fprintf('--- Composite Simpson Method ---\n');
    fprintf('| N    | Integral        | Computation Time (s) | Absolute Error |\n');
    fprintf('|------|-----------------|----------------------|-----------------|\n');
    for i = 1:num_trials
        fprintf('| %4d | %15.10f | %20.6f | %15.10f |\n', ...
                N_values(i), simpson_results_integral(label, i), simpson_results_time(label, i), simpson_results_error(label, i));
    end
    fprintf('\n');

    fprintf('--- Adaptive Quadrature vs. Composite Simpson ---\n');
    fprintf('| Method                 | Integral        | Computation Time (s) | Absolute Error |\n');
    fprintf('|------------------------|-----------------|----------------------|-----------------|\n');
    fprintf('| Adaptive Quadrature    | %15.10f | %20.6f | %15.10f |\n', ...
            adaptive_integral, adaptive_time, 0); 
    fprintf('| Composite Simpson (N)  | %15.10f | %20.6f | %15.10f |\n', ...
            simpson_integral_adaptive, simpson_time_adaptive, abs(adaptive_integral - simpson_integral_adaptive));
    fprintf('\n');

    fprintf('--- Romberg Method ---\n');
    fprintf('| m  | N=2^(m-1) | Integral        | Computation Time (s) | Absolute Error |\n');
    fprintf('|----|----------|-----------------|----------------------|-----------------|\n');
    for i = 1:num_romberg_trials
        fprintf('| %2d | %8d | %15.10f | %20.6f | %15.10f |\n', ...
                m_values(i), romberg_subdivisions(i), romberg_integrals(i), romberg_times(i), romberg_results_error(label, i));
    end
    fprintf('\n');
end
