//
//  ViewController.swift
//  Mailbox
//
//  Created by Jessie on 9/29/15.
//  Copyright © 2015 Jessie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var composeView: UIView!
    @IBOutlet weak var composeImage: UIImageView!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var toTextfield: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var viewControl: UISegmentedControl!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var hiddenImage: UIImageView!
    
    @IBOutlet weak var laterImage: UIImageView!
    
    
    @IBOutlet weak var hiddenNavImage: UIImageView!
    @IBOutlet weak var laterNavImage: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var laterView: UIView!
    
    
    var messageInitialCenter: CGPoint!
    var messageOriginalCenter: CGPoint!
    var contentViewInitialCenter: CGPoint!
    var contentViewOriginalCenter: CGPoint!
    var bgViewOriginalCenter: CGPoint!
    var laterIconInitialCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var archiveIconInitialCenter: CGPoint!
    var archiveIconOriginalCenter: CGPoint!
    var feedViewInitialCenter: CGPoint!
    var previousSelection: String!
    var gray: UIColor!
    var yellow: UIColor!
    var brown: UIColor!
    var green: UIColor!
    var red: UIColor!
    var blue: UIColor!
    var slide = CGFloat()
    var open: Bool!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.alpha = 0
        rescheduleView.alpha = 0
        scrollView.contentSize = feedView.image!.size
        laterIcon.alpha = 0
        archiveIcon.alpha = 0
        hiddenNavImage.alpha = 0
        laterNavImage.alpha = 0
        previousSelection = "mail"
        gray = makeRGB(227, G: 227, B: 227, alpha: 1)
        yellow = makeRGB(245, G: 208, B: 77, alpha: 1)
        brown = makeRGB(216, G: 166, B: 117, alpha: 1)
        green = makeRGB(112, G: 217, B: 98, alpha: 1)
        red = makeRGB(235, G: 84, B: 51, alpha: 1)
        blue = makeRGB(87, G: 199, B: 227, alpha: 1)
        
        contentViewOriginalCenter = contentView.center
        bgView.backgroundColor = gray
        bgViewOriginalCenter = bgView.center
        messageOriginalCenter = messageView.center
        laterIconOriginalCenter = laterIcon.center
        archiveIconOriginalCenter = archiveIcon.center
        open = false
        
        var leftEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onLeftEdgePan:")
        leftEdgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(leftEdgeGesture)
        
        var rightEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onRightEdgePan:")
        rightEdgeGesture.edges = UIRectEdge.Right
        contentView.addGestureRecognizer(rightEdgeGesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didChangeViewControl(sender: AnyObject) {
        
        var viewSelections = ["later", "mail", "hidden"]
        var viewSelection = viewSelections[viewControl.selectedSegmentIndex]
        
        
        switch (viewSelection){
        case "later":
            print("later")
            laterNavImage.alpha = 1
            hiddenNavImage.alpha = 0
            previousSelection = "later"
            viewControl.tintColor = yellow
            contentView.bringSubviewToFront(laterView)
            contentView.bringSubviewToFront(navView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.laterView.center.x = 160
                
                delay(0.5, closure: { () ->
                    () in
                    self.hiddenView.center.x = 480
                    self.scrollView.center.x = 480
                })
            })
            
        case "mail":
            print("mail")
            if previousSelection == "later"{
                hiddenNavImage.alpha = 0
                laterNavImage.alpha = 0
                previousSelection = "mail"
                viewControl.tintColor = blue
                contentView.bringSubviewToFront(scrollView)
                contentView.bringSubviewToFront(navView)
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.scrollView.center.x = 160
                    
                    delay(0.5, closure: { () ->
                        () in
                        self.laterView.center.x = -160
                        self.hiddenView.center.x = 480
                    })
                    
                })

            }else if previousSelection == "hidden"{
                hiddenNavImage.alpha = 0
                laterNavImage.alpha = 0
                previousSelection = "mail"
                viewControl.tintColor = blue
                contentView.bringSubviewToFront(scrollView)
                contentView.bringSubviewToFront(navView)
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.scrollView.center.x = 160
                    
                    delay(0.5, closure: { () ->
                        () in
                        self.laterView.center.x = -160
                        self.hiddenView.center.x = 480
                    })
                    
                })

                
            }else{
                previousSelection == "mail"
            }
            
            
        case "hidden":
            print("hidden")
            hiddenNavImage.alpha = 1
            laterNavImage.alpha = 0
            previousSelection = "hidden"
            viewControl.tintColor = green
            contentView.bringSubviewToFront(hiddenView)
            contentView.bringSubviewToFront(navView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.hiddenView.center.x = 160
                
                delay(0.5, closure: { () ->
                    () in
                    self.laterView.center.x = -160
                    self.scrollView.center.x = -160
                })
                
            })
            
        default:
            print("default")
            
        }

    }
    
    
    @IBAction func didClickCompose(sender: AnyObject) {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.composeView.center.y = 302
            self.toTextfield.becomeFirstResponder()
            
            }) { (Bool) -> Void in
                
        }
    }
    
    @IBAction func didPressCancel(sender: AnyObject) {
        
        contentView.endEditing(true)
        
        var actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Delete Draft", otherButtonTitles: "Keep Draft")
        
        actionSheet.showInView(view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            dismissViewControllerAnimated(true, completion: nil)
            composeView.center.y = 852
        }
    }

    
    func onRightEdgePan(sender: UIScreenEdgePanGestureRecognizer){
        print("Right edge panned!")
        print("contentView.center.x #1: \(contentView.center.x)")
        print("self.contentViewOriginalCenter: \(self.contentViewOriginalCenter)")
        
        if open == true{
        
        if sender.state == UIGestureRecognizerState.Began{
            
            contentViewInitialCenter = contentView.center
            
        }else if sender.state == UIGestureRecognizerState.Changed{
            let translation = sender.translationInView(view)
            print("Edge Pan changed!")
            print("Translation.x: \(translation.x)")
            contentView.center = CGPoint(x: contentViewInitialCenter.x + translation.x, y:contentViewInitialCenter.y)
            print("contentView.center.x: \(contentView.center.x)")
            
        }else if sender.state == UIGestureRecognizerState.Ended{
            
            
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.contentView.transform = CGAffineTransformMakeTranslation(self.contentView.center.x * -1 + 160, 0)
                    self.open = false
                })
            
            print("contentView.center.x #2: \(contentView.center.x)")
            
            }
        }

        
    }
    
    func onLeftEdgePan(sender: UIScreenEdgePanGestureRecognizer){
        print("Edge panning")
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began{
            print("Start Edge Pan!")
            
            contentViewInitialCenter = contentView.center
            
        }else if sender.state == UIGestureRecognizerState.Changed{
            
            print("Edge Pan changed!")
            print("Translation.x: \(translation.x)")
            contentView.center = CGPoint(x: contentViewInitialCenter.x + translation.x, y:contentViewInitialCenter.y)
            print("contentView.center.x: \(contentView.center.x)")
        
            
        }else if sender.state == UIGestureRecognizerState.Ended{
            
            print("Edge Pan Ended!")
            print("Translation.x: \(translation.x)")
            print("contentView.center.x: \(contentView.center.x)")
            
            if translation.x > 90{
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.contentView.transform = CGAffineTransformMakeTranslation(446 - self.contentView.center.x, 0)
                    self.open = true
                })
            }else {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center = self.contentViewOriginalCenter
                    self.open = false
                })
                
            }
            
        }

        
    }

    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began{
           
            messageInitialCenter = messageView.center
            laterIconInitialCenter = laterIcon.center
            feedViewInitialCenter = feedView.center
            laterIcon.image = UIImage(named: "later_icon")
            archiveIconInitialCenter = archiveIcon.center
            archiveIcon.image = UIImage(named: "archive_icon")
            
        }else if sender.state == UIGestureRecognizerState.Changed{
            print("changed!")
            NSLog("you panned me\nlocation: \(location)")
            NSLog("\ntranslation: \(translation)")
            slide = translation.x
            
            laterIcon.alpha = 1
            archiveIcon.alpha = 1
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
                archiveIcon.alpha = 1/60*slide*0.7
                bgView.backgroundColor = gray
                print("alpha: \(archiveIcon.alpha)")
                archiveIcon.image = UIImage(named: "archive_icon")
            }else if slide >= 45 && slide < 60{
                archiveIcon.alpha = 1/60*slide
                bgView.backgroundColor = gray
                print("alpha: \(archiveIcon.alpha)")
                archiveIcon.image = UIImage(named: "archive_icon")
            }else if slide >= 60 && slide < 220{
                archiveIcon.alpha = 1
                archiveIcon.image = UIImage(named: "archive_icon")
                bgView.backgroundColor = green
                archiveIcon.center = CGPoint(x: archiveIconInitialCenter.x + slide - 60, y: archiveIconInitialCenter.y)
                print("alpha: \(archiveIcon.alpha)")
            }else if slide >= 220{
                archiveIcon.image = UIImage(named: "delete_icon")
                bgView.backgroundColor = red
                archiveIcon.center = CGPoint(x: archiveIconInitialCenter.x + slide - 60, y: archiveIconInitialCenter.y)
            }
            
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
                print("archiveIconOriginalCenter.x: \(self.archiveIconOriginalCenter.x)")
                
                print("messageView.center.x: \(messageView.center.x)")
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = self.messageOriginalCenter.x
                    self.laterIcon.center.x = self.laterIconOriginalCenter.x
                    
                print("messageView.center.x: \(self.messageView.center.x)")
                })
        }else if slide <= -60 && slide > -220{
                laterIcon.alpha = 1
                archiveIcon.alpha = 0
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
                
            }else if slide <= -220{
                laterIcon.alpha = 1
                archiveIcon.alpha = 0
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
            }else if slide > 0 && slide < 60{
                
                print("Inside!")
                archiveIcon.alpha = 1
                laterIcon.alpha = 0
                bgView.backgroundColor = gray
                archiveIcon.image = UIImage(named: "archive_icon")
                print("alpha: \(archiveIcon.alpha)")
                print("messageOriginalCenter.x: \(messageOriginalCenter.x)")
                print("archiveIconOriginalCenter.x: \(self.archiveIconOriginalCenter.x)")
                print("messageView.center.x: \(messageView.center.x)")

                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center.x = self.messageOriginalCenter.x
                    self.archiveIcon.center.x = self.archiveIconOriginalCenter.x
                    
                })
                
                print("messageView.center.x: \(messageView.center.x)")
                print("slide: \(slide)")
                
            }else if slide >= 60 && slide < 220{
                archiveIcon.alpha = 1
                laterIcon.alpha = 0
                bgView.backgroundColor = green
                archiveIcon.image = UIImage(named: "archive_icon")
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    print("Transforming: self.messageView.center.x: \(self.messageView.center.x)")
                    print("archiveIcon.center.x: \(self.archiveIcon.center.x)")
                    self.messageView.transform = CGAffineTransformMakeTranslation(self.messageView.center.x + 250, 0.0)
                    self.archiveIcon.transform = CGAffineTransformMakeTranslation(self.messageView.center.x + 250, 0.0)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.4, animations: { () -> Void in
                            print("In Completion: self.messageView.center.x: \(self.messageView.center.x)")
                            print("archiveIcon.center.x: \(self.archiveIcon.center.x)")
                                self.bgView.transform = CGAffineTransformMakeTranslation(0, -86)
                                self.feedView.center.y = self.feedViewInitialCenter.y - 86
                            
                            
                                
                                delay(0.4, closure: { () ->
                                    () in
                                    self.bgView.transform = CGAffineTransformMakeTranslation(0, 0)
                                    self.messageView.transform = CGAffineTransformMakeTranslation(-1*self.messageView.center.x + 160, 0)
                                    self.archiveIcon.transform = CGAffineTransformMakeTranslation(-1*self.archiveIcon.center.x + 30, 0)
                                   
                               
                                })
                                
                                
                        })
                })
                
            }else if slide >= 220{
                archiveIcon.alpha = 1
                laterIcon.alpha = 0
                bgView.backgroundColor = red
                archiveIcon.image = UIImage(named: "delete_icon")
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    print("Transforming: self.messageView.center.x: \(self.messageView.center.x)")
                    print("archiveIcon.center.x: \(self.archiveIcon.center.x)")
                    self.messageView.transform = CGAffineTransformMakeTranslation(self.messageView.center.x + 250, 0.0)
                    self.archiveIcon.transform = CGAffineTransformMakeTranslation(self.messageView.center.x + 250, 0.0)
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.4, animations: { () -> Void in
                            print("In Completion: self.messageView.center.x: \(self.messageView.center.x)")
                            print("archiveIcon.center.x: \(self.archiveIcon.center.x)")
                            self.bgView.transform = CGAffineTransformMakeTranslation(0, -86)
                            self.feedView.center.y = self.feedViewInitialCenter.y - 86
                            
                            
                            delay(0.4, closure: { () ->
                                () in
                                self.bgView.transform = CGAffineTransformMakeTranslation(0, 0)
                                self.messageView.transform = CGAffineTransformMakeTranslation(-1*self.messageView.center.x + 160, 0)
                                self.archiveIcon.transform = CGAffineTransformMakeTranslation(-1*self.archiveIcon.center.x + 30, 0)
                            })
                            
                            
                        })
                })
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

