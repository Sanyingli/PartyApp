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
    let persistence = Persistence()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get a default party, let the main page not that empty
        defaParty()
        
        parites = persistence.fetchParty()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addParty))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // number of rows, using the number of parites
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parites.count
    }
    
    //contents show in the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyInfo", for: indexPath)
        
        let party = parites[indexPath.row]
        
        let showinfo = party.name + " - " + party.startDate.description
        cell.textLabel?.text = showinfo
        print("print call", party.address)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //called when tap navigation right bar "+". then instantiate "add" view.
    //"showDetailViewCOntroller" is the func to present modally
    func addParty(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Add") as? AddPartyViewController{
            navigationController?.showDetailViewController(vc, sender: self)
        }
    }
    
    //called when tap the party cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MapView") as? MapViewController {
            persistence.saveIndex(rowNum: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //swap then show delect option
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row) remove objects
            parites.remove(at: indexPath.row)
            persistence.deletParty(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //func to add sample party.
    func defaParty(){
        let date = Date()
        let id = UUID().uuidString
        print(id)
        let temp = Party.init(id: id, startDate: date , name: "SampleName", address: "1 Infinite Loop, CA, USA")
        persistence.saveParty(party: temp)
        //parites.append(temp)
    }

}

