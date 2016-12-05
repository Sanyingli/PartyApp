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
        
        
        addParty()//addparty for test
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // number of rows, using the number of parites
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyInfo", for: indexPath)
        
        let party = parites[indexPath.row]
        
        cell.textLabel?.text = party.address
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addParty(){//test func
        
    }

}

