//
//  GetStartedVC.swift
//  MovieBrowser-Demo
//
//  Created by pushpsen airekar on 29/03/19.
//  Copyright © 2019 pushpsen airekar. All rights reserved.
//

import UIKit

class GetStartedVC: UIViewController {

    @IBOutlet weak var logoBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // function calling
        self.handleGetStartedVCAppearance()
    }
    
    func handleGetStartedVCAppearance(){
        
        logoBackground.roundCorners([ .layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 25, borderColor: .clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
    }

    
}
