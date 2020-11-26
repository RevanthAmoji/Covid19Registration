//
//  MenuVC.swift
//  covid
//
//  Created by venkata baisani on 20/11/20.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var laguageLabel: SutherlandLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SingletonUI.shared.viewMenuBackGndColor(viewController: self)
        // Do any additional setup after loading the view.
        // Hidden backbutton
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.laguageLabel.text = SingletonUI.shared.selectedLanguage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closeBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
     
}
