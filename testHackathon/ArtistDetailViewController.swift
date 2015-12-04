//
//  ArtistDetailViewController.swift
//  testHackathon
//
//  Created by Gabriel Pezanoski-Cohen on 11/21/15.
//  Copyright © 2015 Gabriel Pezanoski-Cohen. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {

    @IBOutlet weak var artistName: UITextField!
    
    var name: String? = ""
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "doneSegue" {
            name = artistName.text
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
