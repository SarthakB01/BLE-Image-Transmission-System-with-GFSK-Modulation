function test_ble_system(image_path)
    % Load and validate image
    original_image = imread(image_path);
    if size(original_image, 3) == 3
        original_image = rgb2gray(original_image);
    end
    original_size = size(original_image);
    
    % Set parameters with higher SNR for initial testing
    params.samples_per_bit = 8;
    params.modulation_index = 0.7;
    params.packet_size = 32;
    params.SNR_dB = 30;  % Increased SNR for better reliability

    % Transmit and show constellation before noise
    [I_signal, Q_signal] = transmit_ble_image(image_path, params.SNR_dB);

    % Add noise and show noisy constellation
    noise_power = 10^(-params.SNR_dB/10);
    complex_noise = sqrt(noise_power/2) * (randn(size(I_signal)) + 1j*randn(size(Q_signal)));
    I_noisy = I_signal + real(complex_noise);
    Q_noisy = Q_signal + imag(complex_noise);
    
    % Print signal statistics
    fprintf('Signal Statistics:\n');
    fprintf('I signal range: [%.3f, %.3f]\n', min(I_signal), max(I_signal));
    fprintf('Q signal range: [%.3f, %.3f]\n', min(Q_signal), max(Q_signal));
    fprintf('Signal power: %.3f\n', mean(I_signal.^2 + Q_signal.^2));
    fprintf('Noise power: %.3f\n', noise_power);
    
    % Receive and show histogram of received data
    received_image = receive_ble_signal(I_noisy, Q_noisy, original_size, params);
    
    % Calculate comparison metrics
    mse = mean((double(original_image(:)) - double(received_image(:))).^2);
    psnr = 10 * log10(255^2 / mse);
    fprintf('PSNR: %.2f dB\n', psnr);

    % Calculate Bit Error Rate (BER)
    original_bits = dec2bin(original_image(:), 8);  % Convert image pixels to binary
    received_bits = dec2bin(received_image(:), 8);  % Convert received pixels to binary
    bit_errors = sum(original_bits(:) ~= received_bits(:));
    total_bits = numel(original_bits);
    ber = bit_errors / total_bits;
    fprintf('Bit Error Rate (BER): %.5f\n', ber);

    % Plot histograms for original and received images
    figure;
    subplot(1,2,1);
    imhist(original_image);
    title('Original Image Histogram');
    
    subplot(1,2,2);
    imhist(received_image);
    title('Received Image Histogram');
    
    % Save debug data
    save('debug_data.mat', 'I_signal', 'Q_signal', 'I_noisy', 'Q_noisy', ...
         'original_image', 'received_image', 'params', 'psnr', 'ber');
end
