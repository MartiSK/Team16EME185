//
//  FFTViewController.m
//  ChatterAppX
//
//  Created by David Carter on 4/18/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

#import "FFTViewController.h"
#import "AKFoundation.h"
#import "Microphone.h"
#import "AKAudioAnalyzer.h"
#import "AKInstrumentPropertyPlot.h"
#import "AKFloatPlot.h"

@implementation FFTViewController
{
        Microphone *microphone;
        AKAudioAnalyzer *analyzer;
        AKSequence *analysisSequence;
        AKEvent *updateAnalysis;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    microphone = [[Microphone alloc] init];
    [AKOrchestra addInstrument:microphone];
    analyzer = [[AKAudioAnalyzer alloc] initWithAudioSource:microphone.auxilliaryOutput];
    [AKOrchestra addInstrument:analyzer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [analyzer start];
    [microphone start];
    
    analysisSequence = [AKSequence sequence];
    updateAnalysis = [[AKEvent alloc] initWithBlock:^{
     //   [self performSelectorOnMainThread:@selector(updateUI) withObject:self waitUntilDone:NO];
        [analysisSequence addEvent:updateAnalysis afterDuration:0.1];
    }];
    
    [analysisSequence addEvent:updateAnalysis];
    [analysisSequence play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [analyzer stop];
    [microphone stop];
}

@end
