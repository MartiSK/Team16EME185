//
//  FFT.m
//  ChatterAppX
//
//  Created by David Carter on 4/15/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//


// Class for implementing and storing fft data froum audio imput for plotting and signal conditioning
#import "FFT.h"

// Import Accelerate Framework
#import <Accelerate/Accelerate.h>
#import "EZMicrophone.h"

@class ChatterFileViewController;
@

@interface FFT (){
    COMPLEX_SPLIT _A;
    FFTSetup      _FFTSetup;
    BOOL          _isFFTSetup;
    vDSP_Length   _log2n;
    
    struct Buffer {
       float amp, size;
    };
    
}
@end



@implementation FFT
@synthesize microphone;
@synthesize buffer;

// struct to hold multiple outputs to pass to fft plot

-(void)createFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data{

        
        // Setup the length
        _log2n = log2f(bufferSize);
        
        // Calculate the weights array. This is a one-off operation.
        _FFTSetup = vDSP_create_fftsetup(_log2n, FFT_RADIX2);
        
        // For an FFT, numSamples must be a power of 2, i.e. is always even
        int nOver2 = bufferSize/2;
        
        // Populate *window with the values for a hamming window function
        float *window = (float *)malloc(sizeof(float)*bufferSize);
        vDSP_hamm_window(window, bufferSize, 0);
        // Window the samples
        vDSP_vmul(data, 1, window, 1, data, 1, bufferSize);
        free(window);
        
        // Define complex buffer
        _A.realp = (float *) malloc(nOver2*sizeof(float));
        _A.imagp = (float *) malloc(nOver2*sizeof(float));
        
    }



-(void)updateFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data {
    
    
    
    //intoAmp:(float*)ampOut Novr2:(float*)nOver2Out optionals to pass more than one output 
    
        // For an FFT, numSamples must be a power of 2, i.e. is always even
        int nOver2 = bufferSize/2;
        
        // Pack samples:
        // C(re) -> A[n], C(im) -> A[n+1]
        vDSP_ctoz((COMPLEX*)data, 2, &_A, 1, nOver2);
        
        // Perform a forward FFT using fftSetup and A
        // Results are returned in A
        vDSP_fft_zrip(_FFTSetup, &_A, 1, _log2n, FFT_FORWARD);
        
        // Convert COMPLEX_SPLIT A result to magnitudes
        float amp[nOver2];
        float maxMag = 0;
        
        for(int i=0; i<nOver2; i++) {
            // Calculate the magnitude
            float mag = _A.realp[i]*_A.realp[i]+_A.imagp[i]*_A.imagp[i];
            maxMag = mag > maxMag ? mag : maxMag;
        }
        for(int i=0; i<nOver2; i++) {
            // Calculate the magnitude
            float mag = _A.realp[i]*_A.realp[i]+_A.imagp[i]*_A.imagp[i];
            // Bind the value to be less than 1.0 to fit in the graph
            amp[i] = [EZAudio MAP:mag leftMin:0.0 leftMax:maxMag rightMin:0.0 rightMax:1.0];

//            struct Buffer buffer;
//            buffer.amp = amp[i];
//            buffer.size = bufferSize;
         
           
        }
    
    // Update the frequency domain plot
    ChatterFileViewController.audioPlotFrequency(amp, nOver2)
                                                 
                                                 }

        // Update the frequency domain plot
   //     [self.audioPlotFreq updateBuffer:amp
   //                       withBufferSize:nOver2];
    
    -(void)microphone:(EZMicrophone*)microphone hasAudioReceved:(float**)buffer withBufferSize:(UInt32)buffersize withNumberOFChannels:(UInt32)numberOFChannels plotOutput:(EZAudioPlot*)audioPlotFrequency{ dispatch_async(dispatch_get_main_queue(), ^{
    //Setup the fft
    if(!_isFFTSetup){
        [self createFFTWithBufferSize:buffersize withAudioData:buffer[0]];
        _isFFTSetup = YES;
    }
    // Get the FFT data
    [self updateFFTWithBufferSize:buffersize withAudioData:buffer[0]];
    
    
    });
    }


@end


