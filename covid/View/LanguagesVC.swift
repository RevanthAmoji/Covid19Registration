//
//  LanguagesVC.swift
//  covid
//
//  Created by venkata baisani on 20/11/20.
//

import UIKit

class LanguagesVC: UIViewController {
    
    @IBOutlet weak var languagesTableView: UITableView!
    var languagesList:[String] = ["English", "Español"]
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SingletonUI.shared.viewMenuBackGndColor(viewController: self)
        // Do any additional setup after loading the view.
        self.languagesTableView.reloadData()
        
    }
    override func viewWillAppear (_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }

    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
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

extension LanguagesVC: UITableViewDelegate, UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesCell", for: indexPath) as! LanguagesCell
        cell.titleLbl.text = languagesList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SingletonUI.shared.selectedLanguage = languagesList[indexPath.row]
        
        var item1 = LanguageDatasourceItem()
        item1.title = languagesList[indexPath.row]
        item1.selected = true
        LocalizationManager.shared.currentLanguage = item1
        
        self.navigationController?.popViewController(animated: true)
    }

}
