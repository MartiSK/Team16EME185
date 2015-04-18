//
//  FFT.swift
//  ChatterAppX
//
//  Created by David Carter on 4/14/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import Accelerate



//func createFFTWithBufferSize(bufferSize: Float , data: Float){
//    // Setup the length
//    let log2N = vDSP_Length(log2f(bufferSize))
//    let n = 1 << log2N
//    let fftLength = n/2
//    let numSamples: Int = 256
//    
//    // Calculate the weights array. This is a one-off operation
//    let fftSetup = vDSP_create_fftsetup(log2N, FFTRadix(kFFTRadix2))
//    
//    // For an FFT, numSamples must be a power of 2, i.e is always even
//    var nOver2 = bufferSize/2
//    
//    // Populate *window with the values for a hamming window function 
//    let window = malloc(sizeofValue(bufferSize))
//    vDSP_hamm_window(window, bufferSize, 0)        // fix syntx
//    
//    //Window the samples
//    vDSP_vmul(data, 1, window, 1, data, 1, bufferSize)  // fix syntx
//    free(window)
//    
//    // Define complex buffer
//    var realp = [Float](count:Int(fftLength), repeatedValue:0.0)
//    var imagp = realp
//    var splitComplex = DSPSplitComplex(realp:&realp, imagp:&imagp)
//    //vDSP_ctoz(signal, 1, &splitComplex, 1, log2N)     // fix syntx
//}
//
//func updateFFTWithBufferSize(bufferSize: Float, data: Float, fftLength: Int){
//    // For a FFT, numSamples must be a power of 2 i.e. is always even
//    var nOver2 = bufferSize/2
//    
//    var realp = [Float](count:Int(fftLength), repeatedValue:0.0)
//    var imagp = realp
//    var splitComplex = DSPSplitComplex(realp:&realp, imagp:&imagp)
//    
//    //Pack Samples:
//    // C(re) -> A[n], C(im)-> A[n+1]
//    vDSP_ctoz(&data, 2, &splitComplex, 1, nOver2)
//    
//    // Perform a forward FFT using fftSetup and Split Complex
//    // resuts are returned in split complex
//    vDSP_fft_zrip(fftSetup, &splitComplex, 1, log2N, FFT_FORWARD)
//    
//    // Convert COMPLEX_SPLIT result to magnitudes
//    var amplitude = amp[nOver2]
//

//}

//func spectrumForValues(signal: [Double]) -> [Double]{
//    //Find the largest power of two in samples
//    let log2N = vDSP_Length(log2(Double(signal.count)))
//    let n = 1 << log2N
//    let fftLength = n/2
//    let numSamples: Int = 256
//    
//    // This is expensive; factor it out if you need to call this funciton a lot
//    let fftsetup = vDSP_create_fftsetupD(log2N, FFTRadix(kFFTRadix2))
//    
//    // Generate a split complex vector from real data
//    var realp = [Double](count:Int(fftLength), repeatedValue:0.0)
//    var imagp = realp
//    var splitComplex = DSPDoubleSplitComplex(realp:&realp, imagp:&imagp)
//    
//    vDSP_ctozD(ConstUnsafePointer(signal), 2, &splitComplex, 1, numSamples)
//
//    //Take fft
//    vDSP_fft_zripD(fftsetup, &splitComplex, 1, log2N, FFTDirection(kFFTDirection_Forward))
//    
//    // Normalize
//    var normFactor = 1.0 / Double(2 * n)
//    vDSP_vsmulD(splitComplex.realp, 1, &normFactor, splitComplex.realp, 1, fftLength)
//    vDSP_vsmulD(splitComplex.imagp, 1, &normFactor, splitComplex.imagp, 1, fftLength)
//    
//    // Zero out Nyquist
//    splitComplex.imagp[0] = 0.0
//    
//    // Convert complex FFT to magnitude
//    var fft = [Double](count:Int(n), repeatedValue:0.0)
//    vDSP_zvmagsD(&splitComplex, 1, &fft, 1, fftLength)
//    
//    // Cleanup
//    vDSP_destroy_fftsetupD(fftsetup)
//    return fft
//}
//
//func fft(var inputArray:[Double]) -> [Double] {
//    var fftMagnitudes = [Double](count:inputArray.count, repeatedValue:0.0)
//    inputArray.withUnsafePointerToElements {(inputArrayPointer: UnsafePointer<Double>) -> () in
//        var zeroArray = [Double](count:inputArray.count, repeatedValue:0.0)
//        zeroArray.withUnsafePointerToElements { (zeroArrayPointer: UnsafePointer<Double>) -> () in
//            var splitComplexInput = DSPDoubleSplitComplex(realp: inputArrayPointer, imagp: zeroArrayPointer)
//            
//            vDSP_fft_zipD(fft_weights, &splitComplexInput, 1, vDSP_Length(log2(CDouble(inputArray.count))), FFTDirection(FFT_FORWARD));
//            vDSP_zvmagsD(&splitComplexInput, 1, &fftMagnitudes, 1, vDSP_Length(inputArray.count));
//        }
//    }
//    
//    return sqrt(fftMagnitudes)
//}


 func spectrumForValues1(signal: [Double]) -> [Double] {
    // Find the largest power of two in our samples
    let log2N = vDSP_Length(log2(Double(signal.count)))
    let n = 1 << log2N
    let fftLength = n / 2
    
    // This is expensive; factor it out if you need to call this function a lot
    let fftsetup = vDSP_create_fftsetupD(log2N, FFTRadix(kFFTRadix2))
    
    var fft = [Double](count:Int(n), repeatedValue:0.0)
    
    // Generate a split complex vector from the real data
    var realp = [Double](count:Int(fftLength), repeatedValue:0.0)
    var imagp = realp

    
    withExtendedLifetimes(realp, imagp) {
        var splitComplex = DSPDoubleSplitComplex(realp:&realp, imagp:&imagp)
        //vDSP_ctozD(ConstUnsafePointer(signal),2, &splitComplex, 1, fftLength)
        
        // Take the fft
        vDSP_fft_zripD(fftsetup, &splitComplex, 1, log2N, FFTDirection(kFFTDirection_Forward))
        
        // Normalize
        var normFactor = 1.0 / Double(2 * n)
        vDSP_vsmulD(splitComplex.realp, 1, &normFactor, splitComplex.realp, 1, fftLength)
        vDSP_vsmulD(splitComplex.imagp, 1, &normFactor, splitComplex.imagp, 1, fftLength)
        
        // Zero out Nyquist
        splitComplex.imagp[0] = 0.0
        
        // Convert complex FFT to magnitude
        vDSP_zvmagsD(&splitComplex, 1, &fft, 1, fftLength)
    }
    
    // Cleanup
    vDSP_destroy_fftsetupD(fftsetup)
    return fft
}

// To get rid of the `() -> () in` casting
func withExtendedLifetime<T>(x: T, f: () -> ()) {
    return Swift.withExtendedLifetime(x, f)
}

// In the spirit of withUnsafePointers
func withExtendedLifetimes<A0, A1>(arg0: A0, arg1: A1, f: () -> ()) {
    return withExtendedLifetime(arg0) { withExtendedLifetime(arg1, f) }
}