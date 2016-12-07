//
//  ViewController.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/4.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var parites = [Party]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get a default party, let the main page not that empty
        defaParty()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addParty))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // number of rows, using the number of parites
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyInfo", for: indexPath)
        
        let party = parites[indexPath.row]
        
        let showinfo = party.name + party.address + party.startDate.description
        
        cell.textLabel?.text = showinfo
        print("print call", party.address)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addParty(){//test func
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Add") as? AddPartyViewController{
            navigationController?.showDetailViewController(vc, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MapView") as? MapViewController {
            //todo: func to add party info to map
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row) remove objects
            parites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func defaParty(){
        let date = Date()
        let id = UUID().uuidString
        print(id)
        let temp = Party.init(id: id, startDate: date , name: "testName", address: "testAddress")
        parites.append(temp)
    }

}

