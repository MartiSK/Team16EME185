//
//  keyboard.m
//  ChatterAppX
//
//  Created by Marti Sarigul-Klijn on 4/8/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

#import <Foundation/Foundation.h>

func keyboardWasShown(notification: NSNotifcation) {
    var info = notication.userInfo!
    var keyboardFrame: CGRect = (info[UIKeboardFrameEndUserInfoKey] as NSValue).CGRectValue
    
    UIView.animateWithDuration(0.1, animations: { () -> Void in
        self.bottomContraint.constant = keboardFrame.size.height; +20
    })
}
