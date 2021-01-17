//
//  SHProgressBarViewController.swift
//  SmartHealthAnalytics
//
//  Created by integra on 18/09/18.
//  Copyright © 2018 DES. All rights reserved.
//

import UIKit
import SwiftGifOrigin

/*
   - Viewcontroller to show progress bar 
 */
class SHProgressBarViewController: UIViewController {
    static var progressBarVC: SHProgressBarViewController!
    
    @IBOutlet var imgLoader: UIImageView!
    @IBOutlet var viewLoader: UIView!
    @IBOutlet weak var xcenter: NSLayoutConstraint!
    @IBOutlet weak var ycenter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            
            let blurEffect = UIBlurEffect.init()
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           // blurEffectView.alpha = 0.75
            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            view.bringSubviewToFront(viewLoader)
        } else {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        }
        
        imgLoader.image = UIImage.gif(name: "covid")
    }
}


