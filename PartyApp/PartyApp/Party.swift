//
//  Party.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/4.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import Foundation

class Party: NSObject, NSCoding{
    
    var id: String
    var startDate: Date
    var name: String
    var address: String
    
    let idKey = "id"
    let startDateKey = "startDate"
    let nameKey = "name"
    let addressKey = "address"
    
    init(id: String, startDate: Date, name: String, address: String) {
        self.id = id
        self.startDate = startDate
        self.name = name
        self.address = address
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: idKey) as! String
        startDate = aDecoder.decodeObject(forKey: startDateKey) as! Date
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        address = aDecoder.decodeObject(forKey: addressKey) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: idKey)
        aCoder.encode(startDate, forKey: startDateKey)
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(address, forKey: addressKey)
    }
}
