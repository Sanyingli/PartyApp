//
//  MapViewController.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/5.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import UIKit
import Social

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(shareTapped))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareTapped()
    {
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook){
            vc.setInitialText("join this party!")
            present(vc, animated: true)}
    }
}
