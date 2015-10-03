//
//  ViewController.swift
//  Mailbox
//
//  Created by Jessie on 9/29/15.
//  Copyright © 2015 Jessie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    var messageInitialCenter: CGPoint!
    var messageOriginalCenter: CGPoint!
    var laterIconInitialCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var gray: UIColor!
    var yellow: UIColor!
    var brown: UIColor!
    var green: UIColor!
    var red: UIColor!
    var slide = CGFloat()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.alpha = 0
        rescheduleView.alpha = 0
        scrollView.contentSize = feedView.image!.size
        laterIcon.alpha = 0
        archiveIcon.alpha = 0
        gray = makeRGB(227, G: 227, B: 227, alpha: 1)
        yellow = makeRGB(245, G: 208, B: 77, alpha: 1)
        brown = makeRGB(216, G: 166, B: 117, alpha: 1)
        green = makeRGB(112, G: 217, B: 98, alpha: 1)
        red = makeRGB(235, G: 84, B: 51, alpha: 1)
        
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
           
            messageInitialCenter = messageView.center
            laterIconInitialCenter = laterIcon.center
            laterIcon.image = UIImage(named: "later_icon")
            
        }else if sender.state == UIGestureRecognizerState.Changed{
            print("changed!")
            NSLog("you panned me\nlocation: \(location)")
            NSLog("\ntranslation: \(translation)")
            slide = translation.x
            
            laterIcon.alpha = 1
            //archiveIcon.alpha = 1
            messageView.center = CGPoint(x: messageInitialCenter.x + slide, y:messageInitialCenter.y)
            
            if slide < 0 && slide > -45{
                laterIcon.alpha = -1/60*slide*0.7
                bgView.backgroundColor = gray
                print("alpha: \(laterIcon.alpha)")
                laterIcon.image = UIImage(named: "later_icon")
            }
            else if slide <= -45 && slide > -60{
                laterIcon.alpha = -1/60*slide
                bgView.backgroundColor = gray
                print("alpha: \(laterIcon.alpha)")
                laterIcon.image = UIImage(named: "later_icon")
            }else if slide <= -60 && slide > -220{
                laterIcon.alpha = 1
                laterIcon.image = UIImage(named: "later_icon")
                bgView.backgroundColor = yellow
                laterIcon.center = CGPoint(x: laterIconInitialCenter.x + slide + 60, y: laterIconInitialCenter.y)
                print("alpha: \(laterIcon.alpha)")
            }else if slide <= -220{
                laterIcon.image = UIImage(named: "list_icon")
                bgView.backgroundColor = brown
                laterIcon.center = CGPoint(x: laterIconInitialCenter.x + slide + 60, y: laterIconInitialCenter.y)
            }else if slide > 0 && slide < 45 {
//                archiveIcon.alpha = -1/60*slide*0.7
//                bgView.backgroundColor = gray
//                print("alpha: \(archiveIcon.alpha)")
//                archiveIcon.image = UIImage(named: "archive_icon")
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
                laterIcon.image = UIImage(named: "later_icon")
                print("alpha: \(laterIcon.alpha)")
                print("messageOriginalCenter.x: \(messageOriginalCenter.x)")
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = self.messageOriginalCenter.x
                    self.laterIcon.center.x = self.laterIconOriginalCenter.x

                })
                            }else if slide < -60 && slide > -220{
                laterIcon.alpha = 1
                bgView.backgroundColor = yellow
                laterIcon.image = UIImage(named: "later_icon")
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    print("Transforming: self.messageView.center.x: \(self.messageView.center.x)")
                    self.messageView.transform = CGAffineTransformMakeTranslation(-1*self.messageView.center.x - 250, 0.0)
                    self.laterIcon.transform = CGAffineTransformMakeTranslation(-1*self.messageView.center.x - 250, 0.0)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleView.alpha = 1
                        self.messageView.center = self.messageOriginalCenter
                        self.laterIcon.center = self.laterIconOriginalCenter
                        })
        
                })
                
            }else{
                laterIcon.alpha = 1
                bgView.backgroundColor = brown
                laterIcon.image = UIImage(named: "list_icon")
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    print("Transforming: self.messageView.center.x: \(self.messageView.center.x)")
                    self.messageView.transform = CGAffineTransformMakeTranslation(-1*self.messageView.center.x - 250, 0.0)
                    self.laterIcon.transform = CGAffineTransformMakeTranslation(-1*self.messageView.center.x - 250, 0.0)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listView.alpha = 1
                            
                            delay(0.3, closure: { () ->
                                () in
                                    self.messageView.center = self.messageOriginalCenter
                                    self.laterIcon.center = self.laterIconOriginalCenter
                            })})})
            }
        }
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
        print("rescheduleView.alpha: \(rescheduleView.alpha)")
        print("listView.alpha: \(listView.alpha)")
        
        if rescheduleView.alpha == 1{
        
            rescheduleView.alpha = 0
            laterIcon.image = UIImage(named: "later_icon")
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.messageView.transform = CGAffineTransformMakeTranslation(20, 0.0)
                self.laterIcon.transform = CGAffineTransformMakeTranslation(20, 0.0)
                
                print("messageOriginalCenter.x: \(self.messageOriginalCenter.x)")
                print("messageView.center.x: \(self.messageView.center.x)")
                print("laterIconOriginalCenter.x: \(self.laterIconOriginalCenter.x)")
                print("laterIcon.center.x: \(self.laterIcon.center.x)")
                
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        self.messageView.transform = CGAffineTransformMakeTranslation(0, 0.0)
                        self.laterIcon.transform = CGAffineTransformMakeTranslation(0, 0.0)
                        
                    })
            })
            
        }else if listView.alpha == 1{
            listView.alpha = 0
            laterIcon.image = UIImage(named: "list_icon")
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.messageView.transform = CGAffineTransformMakeTranslation(20, 0.0)
                self.laterIcon.transform = CGAffineTransformMakeTranslation(20, 0.0)
                
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                       
                print("in COMPLETION - Before")
                    self.messageView.transform = CGAffineTransformMakeTranslation(0, 0.0)
                    self.laterIcon.transform = CGAffineTransformMakeTranslation(0, 0.0)
                        print("in COMPLETION - After")
                    })
            })
            
        }
        
    }
}

