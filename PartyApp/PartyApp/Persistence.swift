//
//  Persistence.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/8.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import Foundation

class  Persistence {
    let partykey = "parties"
    let userdef = UserDefaults.standard
    
    func saveParty(party: Party){
        
        var parties = fetchParty()
        
        parties.append(party)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: parties)
        userdef.set(data, forKey: partykey)
        userdef.synchronize()
    }
    
    func fetchParty() ->[Party]{
        
        print("fetchPartyCalled")
        
        let parties = userdef.object(forKey: partykey) as? Data
        
        if let parties = parties {
            return NSKeyedUnarchiver.unarchiveObject(with: parties) as! [Party]
        }
        else{
            return [Party]()
        }
    }
    
    func deletParty(indexPath: Int){
        
        var parties = fetchParty()
        parties.remove(at: indexPath)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: parties)
        userdef.set(data, forKey: partykey)
        userdef.synchronize()
    }
}
