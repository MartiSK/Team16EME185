//
//  ChatterFileViewController.swift
//  ChatterApp2.0
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import UIKit
import AVFoundation

class ChatterFileViewController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        var pathComponents = [baseString, "MyAudio.m4a"]
        self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)!
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: self.audioURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        // super init below
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet weak var chatterTextField: UITextField! // chatter file name text field
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder
    var audioURL: NSURL
    var previousViewController = MainTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // LGI
    }
    // cancel button
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // save button 
    @IBAction func saveTapped(sender: AnyObject) {
        // create a sound object
        var chatterfile = ChatterFile()
        chatterfile.name = chatterTextField.text
        //chatterfile.URL = self.audioURL
        
        // add sound into chatterFiles array
        self.previousViewController.chatterFiles.append(chatterfile)
        
        // dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // record button
    @IBAction func recordTapped(sender: AnyObject) {
        if self.audioRecorder.recording { // if recording
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
        }else{ // if not recording
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Stop Recording", forState: UIControlState.Normal)
        }
        
        
    }
    
}
