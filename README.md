# 📱 BLE Image Transmission System with GFSK Modulation

## ⚠️ Important Implementation Note
The current implementation has significant limitations in the packetization system. While the code structure includes packet handling functions, the actual data transmission largely bypasses the packet system due to implementation challenges. This means:
- Packet headers are generated but not fully utilized
- Error detection at packet level is limited
- Packet reassembly is not fully implemented
- The system essentially operates as a continuous bit stream

Users should be aware that this is more of an educational demonstration of GFSK modulation and basic signal processing rather than a complete BLE protocol implementation.

## 🎯 Overview
This MATLAB implementation simulates a **Bluetooth Low Energy (BLE)** image transmission system using **Gaussian Frequency Shift Keying (GFSK)**. The system demonstrates image data transmission through an **Additive White Gaussian Noise (AWGN)** channel, incorporating error correction and data whitening techniques.

## Features
- 🎨 **Image Processing**: 
  - Supports both RGB and grayscale images
  - Automatic RGB to grayscale conversion
  - Binary data conversion and reconstruction
- 📊 **Signal Processing**:
  - GFSK modulation and demodulation
  - Configurable modulation index and sampling rate
  - AWGN channel simulation
- 🛡️ **Error Correction**:
  - Hamming code implementation
  - Data whitening for improved transmission
  - Basic packet structure (partially implemented)

## System Architecture

```
Transmission Pipeline:
Image → Binary → (Packet Headers*) → Hamming Encoding → Whitening → GFSK Modulation

* Packet system present but not fully functional

Reception Pipeline:
GFSK Demodulation → De-whitening → Hamming Decoding → Binary → Image
```

## Requirements
- MATLAB R2020a or higher
- Required Toolboxes:
  - Image Processing Toolbox
  - Signal Processing Toolbox
  - Communications Toolbox

## Parameters
- **Modulation**:
  - Samples per bit: 8
  - GFSK modulation index: 0.7
  - Gaussian filter BT product: 0.5
- **Error Correction**:
  - Hamming(7,4) coding
  - Basic interleaving
- **Channel**:
  - Configurable SNR (default: 30 dB)
  - AWGN channel simulation

## 🚀 Usage
```matlab
% Basic usage
test_ble_system('path/to/your/image.jpg');

% Advanced usage with custom parameters
params.samples_per_bit = 8;
params.modulation_index = 0.7;
params.SNR_dB = 30;
test_ble_system('path/to/your/image.jpg', params);
```

## 📷 Output Images
Below are the output images generated from different stages of transmission and reception:

1. **BLE transmission Stages**:
   ![Original Image](https://github.com/SarthakB01/BLE-Image-Transmission-System-with-GFSK-Modulation/blob/master/Output/Screenshot%20(501).png)

2. **BLE receiver Stages**:
   ![Transmitted Spectrum](https://github.com/SarthakB01/BLE-Image-Transmission-System-with-GFSK-Modulation/blob/master/Output/Screenshot%20(502).png)

3. **Histrogram of Image Before and After Transmission**:
   ![Received Image](https://github.com/SarthakB01/BLE-Image-Transmission-System-with-GFSK-Modulation/blob/master/Output/Screenshot%20(503).png)

## Known Limitations
1. **Major Packetization Issues** 🚨
   - Packet system is mostly non-functional
   - No proper packet synchronization
   - Missing packet loss handling
   - Limited error detection at packet level

2. **Other Limitations**
   - High sensitivity to noise
   - Large memory requirements for big images
   - Processing speed issues with high-resolution images

## Debug Features
- Signal constellation visualization
- BER and PSNR measurements
- Debug data saved to `debug_data.mat`
- Real-time performance metrics

## 🔧 Troubleshooting
If you encounter issues:
1. Start with small test images
2. Use high SNR values initially (>25dB)
3. Monitor memory usage
4. Check constellation plots
5. Review debug data in `debug_data.mat`

## Future Improvements Needed
1. **Critical**:
   - Complete packetization system implementation
   - Proper packet synchronization
   - Error detection and handling at packet level

2. **General**:
   - Noise resistance improvement
   - Memory optimization
   - Processing speed enhancement

## 📚 Documentation
All functions include detailed comments explaining their operation. Key files:
- `transmit_ble_image.m`: Main transmission function
- `receive_ble_signal.m`: Main reception function
- `test_ble_system.m`: System testing and visualization

---

🔬 *Note: This implementation is primarily for educational purposes and demonstrates basic GFSK modulation concepts. It should not be used as a reference for actual BLE protocol implementation.*

For technical questions or contributions, please create an issue or submit a pull request.

