//
//  ViewController.swift
//  ScreenKit
//
//  Created by Hainess on 06/04/2022.
//  Copyright (c) 2022 Hainess. All rights reserved.
//

import UIKit
import ScreenKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SKTool.startup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SKTool.show()
    }

}

