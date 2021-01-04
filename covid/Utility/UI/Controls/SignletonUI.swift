//
//  SignletonUI.swift
//  covid
//
//  Created by venkata baisani on 18/11/20.
//

import Foundation
import UIKit


class SingletonUI {
    static let shared = SingletonUI()
    private init() {
    }
    
    //Language variable
    public var selectedLanguage:String? = "English"
    
    
    func navigationColor() {
        // MARK: Navigation Bar Customisation

        // To change background colour.
        UINavigationBar.appearance().barTintColor = UIColor.Citygo.navigationBar

        // To change colour of tappable items.
        UINavigationBar.appearance().tintColor = UIColor.Citygo.buttonfieldsactive
        

        // To apply textAttributes to title i.e. colour, font etc.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.Citygo.buttonfieldsactive, .font : UIFont.init(name: "AvenirNext-DemiBold", size: 22.0)!]
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = false
        
       
        
        
        
        self.barButtonColor()
    }
    
    func naviagationBarRightButton(vc: UIViewController,barItem:UIBarButtonItem) {
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 25))

         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
         imageView.contentMode = .scaleAspectFill
         let image = UIImage(named: "headerImage")
         imageView.image = image
         logoContainer.addSubview(imageView)
         vc.navigationItem.titleView = logoContainer
        
        let isEnable=UserData.shared.getIsUserLogin()
        if isEnable ?? false {
            barItem.isEnabled = true
            vc.navigationController?.navigationItem.rightBarButtonItem = barItem
        } else {
            barItem.isEnabled = false
            vc.navigationController?.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    func barButtonColor() {
    
        UIBarButtonItem.appearance().tintColor = .white
    }
    
    func viewMenuBackGndColor(viewController: UIViewController) {
        viewController.view.backgroundColor = UIColor.Citygo.formsubtitlesnotselected
        let arr = viewController.view.subviews(ofType: SutherlandLabel.self)
        
        for item in arr {
            let itemVal = item as SutherlandLabel
            if itemVal.tag == 1000 {
                itemVal.font = UIFont.Citygo.quicksandSemiBold700
                itemVal.textColor = UIColor.white
            } else if itemVal.tag == 1001 {
                itemVal.font = UIFont.Citygo.lato700
                itemVal.textColor = UIColor.white
            }
        }
        let btnArr = viewController.view.subviews(ofType: SutherlandButton.self)
        
        for item in btnArr {
            let itemVal = item as SutherlandButton
            itemVal.titleLabel?.font = UIFont.Citygo.latobtn700
        }
        
        let tfArr = viewController.view.subviews(ofType: SutherlandTextField.self)
        
        for item in tfArr {
            let itemVal = item as SutherlandTextField
            itemVal.font = UIFont.Citygo.lato700
            itemVal.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
        }
    }
    
    func viewObjectsBackGndColor(viewController: UIViewController) {
        
        let arr = viewController.view.subviews(ofType: SutherlandLabel.self)
        
        for item in arr {
            let itemVal = item as SutherlandLabel
            if itemVal.tag == 1000 {
                itemVal.font = UIFont.Citygo.quicksandBold700
                itemVal.textColor = UIColor.Citygo.h1headingone
            }
            else if itemVal.tag == 1001 {
                itemVal.font = UIFont.Citygo.lato700
              //  itemVal.textColor = UIColor.Citygo.mainbody
                itemVal.textColor = UIColor.Citygo.h1headingone
            }
            else if itemVal.tag == 1002 {
                itemVal.font = UIFont.Citygo.lato700
               // itemVal.textColor = UIColor.Citygo.mainbodybold
                itemVal.textColor = UIColor.Citygo.h1headingone
            }
            else if itemVal.tag == 1003 {
                itemVal.font = UIFont.Citygo.lato400
               // itemVal.textColor = UIColor.Citygo.formtitles
                itemVal.textColor = UIColor.Citygo.h1headingone
            }
            else if itemVal.tag == 1004 {
                itemVal.font = UIFont.Citygo.lato400
               // itemVal.textColor = UIColor.Citygo.formsubtitlesnotselected
                itemVal.textColor = UIColor.Citygo.h1headingone
            }
            else if itemVal.tag == 1005 {
                itemVal.font = UIFont.Citygo.lato400
               // itemVal.textColor = UIColor.Citygo.formsubtitlesentryfields
                itemVal.textColor = UIColor.Citygo.h1headingone
            }
            else if itemVal.tag == 1006 {
                itemVal.font = UIFont.Citygo.latoinfo400
              //  itemVal.textColor = UIColor.Citygo.formtitles
                itemVal.textColor = UIColor.Citygo.infoTextColor
            }
        }
        let btnArr = viewController.view.subviews(ofType: SutherlandButton.self)
        
        for item in btnArr {
            let itemVal = item as SutherlandButton
            itemVal.titleLabel?.font = UIFont.Citygo.latobtn700
        }
        
        let tfArr = viewController.view.subviews(ofType: SutherlandTextField.self)
        
        for item in tfArr {
            let itemVal = item as SutherlandTextField
            itemVal.font = UIFont.Citygo.lato700
//            itemVal.textColor = UIColor.Citygo.formsubtitlesentryfields
            itemVal.textColor = UIColor.Citygo.textFieldTextColor
            itemVal.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
        }
    }
    
}
