//
//  MainTableViewController.swift
//  ChatterApp2.0
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    
    var chatterFiles: [ChatterFile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // LGI
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        var chatterFilePath = NSBundle.mainBundle().pathForResource("whistle", ofType: "m4a")
        var chatterFileURL = NSURL.fileURLWithPath(chatterFilePath!)
        
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        var sound1 = NSEntityDescription.insertNewObjectForEntityForName("ChatterFile", inManagedObjectContext: context) as  ChatterFile
        
        sound1.name = "chatter"
        sound1.url = chatterFileURL!.absoluteString!
        
//        var sound1 = ChatterFile()
//        sound1.name = "chatter"
//        sound1.URL = chatterFileURL!
//        
//        var sound2 = ChatterFile()
//        sound2.name = "chatter 2"
//        sound2.URL = chatterFileURL!
//        
//        self.chatterFiles.append(sound1)
//        self.chatterFiles.append(sound2)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatterFiles.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var chatterfile = self.chatterFiles[indexPath.row]
        var cell = UITableViewCell()
        cell.textLabel!.text = chatterfile.name
        return cell
    }
    
    // when tapped do
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        var chatterfile = self.chatterFiles[indexPath.row]
        
        //self.audioPlayer = AVAudioPlayer(contentsOfURL: chatterfile.URL, error: nil)
        self.audioPlayer.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var chatterFileViewController = segue.destinationViewController as ChatterFileViewController
        chatterFileViewController.previousViewController = self
    }
    
}

