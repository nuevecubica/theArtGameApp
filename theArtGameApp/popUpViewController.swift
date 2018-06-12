//
//  popUpViewController.swift
//  theArtGameApp
//
//  Created by alex vaught on 6/11/18.
//  Copyright © 2018 alex vaught. All rights reserved.
//

import UIKit



class popUpViewController: UIViewController {

    
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var modalTitle: UILabel!
    @IBOutlet weak var modalText: UITextView!
    @IBOutlet weak var modalImage: UIImageView!
    @IBOutlet weak var modalButton: UIButton!
    @IBAction func closeModal(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        viewPopUp.layer.cornerRadius = 10

         modalTitle.text = "SUOER TEST";
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
