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
        UINavigationBar.appearance().barTintColor = UIColor.init(hex: Colors.navigationBar.rawValue)

        // To change colour of tappable items.
        UINavigationBar.appearance().tintColor = UIColor.init(hex: Colors.buttonInactiveColor.rawValue)
        

        // To apply textAttributes to title i.e. colour, font etc.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.init(hex: Colors.buttonInactiveColor.rawValue), .font : UIFont.init(name: "AvenirNext-DemiBold", size: 22.0)!]
        // To control navigation bar's translucency.
        UINavigationBar.appearance().isTranslucent = false
        
        self.barButtonColor()
    }
    
    
    
    func barButtonColor() {
    
        UIBarButtonItem.appearance().tintColor = .white
    }
}
