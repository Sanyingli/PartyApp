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
    let mainview = PartiesTableViewController()
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //called when save button being pressed. run addParty()
    @IBAction func saveButtonPress(_ sender: Any) {
        print("save party button pressed")
        addParty()
    }
    
    func addParty(){
        let id = UUID().uuidString //give random id to the party
        let startDate = datePicker.date
        
        //use guard check if name and address is blank. Call blankError if it is blank.
        guard let name = nameText.text, name.characters.count > 0 else {
            blankError(name: "Party Name")
            return
        }
        guard let address = addressText.text, address.characters.count > 0 else {
            blankError(name: "Address")
            return
        }
        let newParty = Party.init(id: id, startDate: startDate, name: name, address: address)
        
        //save the party into userDefault
        persistence.saveParty(party: newParty)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //press cancle button just dismiss this view
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    //show error messages, being called if name or address is blank
    func blankError(name: String){
        let ac = UIAlertController(title: "Error", message: "\(name) is empty", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    

}
