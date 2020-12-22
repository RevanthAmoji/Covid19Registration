//
//  FinalViewController.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class FinalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
