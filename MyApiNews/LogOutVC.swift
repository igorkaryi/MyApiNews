//
//  LogOutVC.swift
//  MyApiNews
//
//  Created by Igor Karyi on 24.12.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogOutVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FIRAuth.auth()?.currentUser?.email ?? String())
        performSegue(withIdentifier: "logOutSegue", sender: self)

        self.addSlideMenuButton()
    }

}
