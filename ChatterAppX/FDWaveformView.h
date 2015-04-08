//
//  FDWaveformView.h
//  ChatterAppX
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

#ifndef ChatterAppX_FDWaveformView_h
#define ChatterAppX_FDWaveformView_h


#endif

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@protocol FDWaveformViewDelegate;

@interface FDWaveformView : UIView
@property (nonatomic, weak) id<FDWaveformViewDelegate> delegate;
@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, assign, readonly) unsigned long int totalSamples;
@property (nonatomic, assign) unsigned long int progressSamples;
@property (nonatomic, assign) unsigned long int zoomStartSamples;
@property (nonatomic, assign) unsigned long int zoomEndSamples;
@property (nonatomic) BOOL doesAllowScrubbing;
@property (nonatomic) BOOL doesAllowStretchAndScroll;
@property (nonatomic, copy) UIColor *wavesColor;
@property (nonatomic, copy) UIColor *progressColor;
@end

@protocol FDWaveformViewDelegate <NSObject>
@optional
- (void)waveformViewWillRender:(FDWaveformView *)waveformView;
- (void)waveformViewDidRender:(FDWaveformView *)waveformView;
- (void)waveformViewWillLoad:(FDWaveformView *)waveformView;
- (void)waveformViewDidLoad:(FDWaveformView *)waveformView;
@end
