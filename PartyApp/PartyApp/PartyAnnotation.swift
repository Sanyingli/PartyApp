//
//  PartyAnnotation.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/6.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class PartyAnnotation: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var address: String
    
    init(title: String,coordinate: CLLocationCoordinate2D, address: String ) {
        self.title = title
        self.coordinate = coordinate
        self.address = address
    }

}
