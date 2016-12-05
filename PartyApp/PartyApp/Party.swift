//
//  Party.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/4.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import Foundation

class Party {
    
    var id: String
    var startDate: Date
    var name: String
    var address: String
    
    init(id: String, startDate: Date, name: String, address: String) {
        self.id = id
        self.startDate = startDate
        self.name = name
        self.address = address
    }
    
}
