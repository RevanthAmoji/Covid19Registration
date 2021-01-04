//
//  FinalViewController.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    @IBOutlet weak var btnNext: SutherlandButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.btnEnable(boolVal: true)
        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
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
