//
//  ViewController.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/4.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import UIKit

class PartiesTableViewController: UITableViewController {
    
    var parites = [Party]()
    let persistence = Persistence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if its the first time open app, if true, add sample party
        if(persistence.fetchOpenTime()){
        defaParty()
        }
        
        //get the parties info from userDefault
        parites = persistence.fetchParty()
        
        //navigationBar call addPaty() which will open AddPartyView
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addParty))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //when viewWillAppear, update rows
        DispatchQueue.main.async {
            //have to get parties again, or the reloadData wont have effect
            self.parites = self.persistence.fetchParty()
            self.tableView.reloadData()
            print("viewWillAppear reload call")
        }
    }
    
    // number of rows, using the number of parites
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parites.count
    }
    
    //contents show in the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyInfo", for: indexPath)
        
        let party = parites[indexPath.row]
        
        //call dateFormating() to formating date to required formate and send back string date
        let date = dateFormating(data: party.startDate)
        
        //combine info shows in the row
        let showinfo = party.name + " - " + date
        cell.textLabel?.text = showinfo
        
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
            persistence.saveIndex(rowNum: indexPath.row)//save row number then MapView can use it
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //swap then show delect option
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //remove the object in parties array, must do it beacause .delete ask to delete the object
            parites.remove(at: indexPath.row)
            //remove the data in userDefault
            persistence.deletParty(indexPath: indexPath.row)
            //delete the Row
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //func to add sample party.
    func defaParty(){
        let date = Date()
        let id = UUID().uuidString
        print(id)
        print("add default party run")
        let temp = Party.init(id: id, startDate: date , name: "SampleParty", address: "2000 F St NW, DC, USA")
        persistence.saveParty(party: temp)
        
        //set userDefault to false, so next time user open it will not add sample party
        persistence.saveOpenTime()
    }
    
    //transfer Date data in to string with required format
    func dateFormating(data: Date) -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mm a MM/dd"
        let returnDate = dateFormatter.string(from: data)
        
        return returnDate
    }

}

