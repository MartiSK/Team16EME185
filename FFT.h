//
//  FFT.h
//  ChatterAppX
//
//  Created by David Carter on 4/15/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EZAudio.h"

#import "EZMicrophone.h"

@interface FFT : NSObject

// class methods +

// Instance Methods -
-(void)createFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data;

-(void)updateFFTWithBufferSize:(float)bufferSize withAudioData:(float*)data;

-(void)microphone:(EZMicrophone*)microphone hasAudioReceved:(float**)buffer withBufferSize:(UInt32)buffersize withNumberOFChannels:(UInt32)numberOFChannels plotOutput:(EZAudioPlot*)audioPlotFrequency;

@property int nOver2;
@property float  buffer;
@property (nonatomic, strong) EZMicrophone *microphone;

@end
