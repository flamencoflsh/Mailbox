//
//  MessageViewController.swift
//  Mailbox
//
//  Created by Jessie on 9/30/15.
//  Copyright © 2015 Jessie. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    var messageInitialCenter: CGPoint!
    var messageOriginalCenter: CGPoint!
    var laterIconInitialCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var gray: UIColor!
    var slide = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laterIcon.alpha = 0
        archiveIcon.alpha = 0
        gray = UIColor(red: 227.0/255.0, green: 227.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        bgView.backgroundColor = gray
        messageOriginalCenter = messageView.center
        laterIconOriginalCenter = laterIcon.center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        

          if sender.state == UIGestureRecognizerState.Began{
            print("started!")
            messageInitialCenter = messageView.center
            laterIconInitialCenter = laterIcon.center
            
        }else if sender.state == UIGestureRecognizerState.Changed{
            print("changed!")
            NSLog("you panned me\nlocation: \(location)")
            NSLog("\ntranslation: \(translation)")
            slide = translation.x
            
            laterIcon.alpha = 1
            messageView.center = CGPoint(x: messageInitialCenter.x + slide, y:messageInitialCenter.y)
            
            if slide < 0 && slide > -60{
                laterIcon.alpha = -1/60*slide
                bgView.backgroundColor = gray
                print("alpha: \(laterIcon.alpha)")
            }else{
                laterIcon.alpha = 1
                let yellow = UIColor(red: 245.0/255.0, green: 208.0/255.0, blue: 77.0/255.0, alpha: 1.0)
                bgView.backgroundColor = yellow
                //bgView.backgroundColor = UIColor.yellowColor()
                //laterIcon.center.x = laterIconInitialCenter.x + slide
                laterIcon.center = CGPoint(x: laterIconInitialCenter.x + slide + 60, y: laterIconInitialCenter.y)
                print("alpha: \(laterIcon.alpha)")
            }
            print("laterIcon.center.x: \(laterIcon.center.x)")
            print("slide: \(slide)")
            
           

            
            
        }else if sender.state == UIGestureRecognizerState.Ended{
            print("stopped!")
            print("slide: \(slide)")

            if ((slide < 0) && (slide > -60)){
                print("Inside!")
                laterIcon.alpha = 0
                bgView.backgroundColor = gray
                print("alpha: \(laterIcon.alpha)")
                 print("messageOriginalCenter.x: \(messageOriginalCenter.x)")
                messageView.center = messageOriginalCenter
                laterIcon.center = laterIconOriginalCenter
            }else{
                laterIcon.alpha = 1
                let yellow = UIColor(red: 245.0/255.0, green: 208.0/255.0, blue: 77.0/255.0, alpha: 1.0)
                bgView.backgroundColor = yellow
                //bgView.backgroundColor = UIColor.yellowColor()
                //laterIcon.center.x = laterIconInitialCenter.x + slide
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.transform = CGAffineTransformMakeTranslation(-320, 0.0)
                    self.laterIcon.transform = CGAffineTransformMakeTranslation(-320, 0.0)
                })
                
                
            }

        }

    }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
