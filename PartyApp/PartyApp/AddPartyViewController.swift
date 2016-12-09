//
//  AddPartyViewController.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/5.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import UIKit

class AddPartyViewController: UIViewController {
    let persistence = Persistence()
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonPress(_ sender: Any) {
        print("save party")
        addParty()
    }
    
    func addParty(){
        let id = UUID().uuidString
        let startDate = datePicker.date
        let name = nameText.text
        let address = addressText.text
        let newParty = Party.init(id: id, startDate: startDate, name: name!, address: address!)
        
        persistence.saveParty(party: newParty)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Main") as? ViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
