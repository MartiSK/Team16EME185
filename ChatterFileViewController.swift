//
//  ChatterFileViewController.swift
//  ChatterApp2.0
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ChatterFileViewController : UIViewController {
    

    @IBOutlet var fftPlot: AKAudioInputFFTPlot!
    let microphone = Microphone()
    
    @IBOutlet weak var chatterTextField: UITextField! // chatter file name text field
    @IBOutlet weak var recordButton: UIButton!
    
//    var audioRecorder : AVAudioRecorder
//    var audioURL: String
    var previousViewController = MainTableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AKManager.sharedManager().isLogging = true
        AKOrchestra.addInstrument(microphone)
        // LGI
        microphone.play()
        AKManager.addBinding(fftPlot)

//        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
//        self.audioURL = NSUUID().UUIDString + ".m4a"
//        var pathComponents = [baseString, self.audioURL]
//        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
//
//        var session = AVAudioSession.sharedInstance()
//        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
//
//        var recordSettings: [NSObject : AnyObject] = Dictionary()
//        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
//        recordSettings[AVSampleRateKey] = 44100.0
//        recordSettings[AVNumberOfChannelsKey] = 2
//
//        self.audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings, error: nil)
//        self.audioRecorder.meteringEnabled = true
//        self.audioRecorder.prepareToRecord()
    }
    
    // cancel button
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // save button
    @IBAction func saveTapped(sender: AnyObject) {
//        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        // create a chatterfile object
//        var chatterfile = NSEntityDescription.insertNewObjectForEntityForName("ChatterFile", inManagedObjectContext: context) as! ChatterFile
//        chatterfile.name = chatterTextField.text
//        chatterfile.url = self.audioURL
//        
//        // save sound to core data
//        context.save(nil)
//        
//        // dismiss this view controller
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // record button
//    @IBAction func recordTapped(sender: AnyObject) {
//        if self.audioRecorder.recording { // if recording
//            self.audioRecorder.stop()
//            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
//        }else{ // if not recording
//            var session = AVAudioSession.sharedInstance()
//            session.setActive(true, error: nil)
//            self.audioRecorder.record()
//            self.recordButton.setTitle("Stop Recording", forState: UIControlState.Normal)
        }
        


