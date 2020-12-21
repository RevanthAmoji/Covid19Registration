//
//  UIViewController+LoaderShower.swift
//  SmartHealthAnalytics
//
//  Created by integra on 10/09/18.
//  Copyright © 2018 DES. All rights reserved.
//

import UIKit

protocol ProgressBarShower {
    func showProgressBar()
    func hideProgressBar()
    func showMenuProgressBar()
   
}

/*
 UIViewController Extension for Progress Bar
*/
extension ProgressBarShower where Self: UIViewController {
    
    func showProgressBar() {
        if SHProgressBarViewController.progressBarVC == nil {
            let storyboard = UIStoryboard(name: "ProgressBar", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SHProgressBarViewController") as! SHProgressBarViewController
            SHProgressBarViewController.progressBarVC = controller
        }
        self.navigationController?.view.addSubview(SHProgressBarViewController.progressBarVC.view)

    }
    func showMenuProgressBar() {
        
        if SHProgressBarViewController.progressBarVC == nil {
            let storyboard = UIStoryboard(name: "ProgressBar", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SHProgressBarViewController") as! SHProgressBarViewController
            SHProgressBarViewController.progressBarVC = controller
            
        }
        self.view.addSubview(SHProgressBarViewController.progressBarVC.view)
//        SHProgressBarViewController.progressBarVC.xcenter.constant = 0
//        SHProgressBarViewController.progressBarVC.ycenter.constant = 0
    }
    func hideProgressBar() {
        SHProgressBarViewController.progressBarVC.view.removeFromSuperview()
    }
    
}
