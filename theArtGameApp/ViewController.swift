//
//  ViewController.swift
//  theArtGameApp
//
//  Created by alex vaught on 8/3/17.
//  Copyright © 2017 alex vaught. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
	
	@IBOutlet weak var gameImage: UIImageView!
	@IBOutlet weak var gameQuestion: UILabel!
	@IBOutlet weak var gameA1: UIButton!
	@IBOutlet weak var gameA2: UIButton!
	@IBOutlet weak var gameA3: UIButton!
	
	//LOAD DATA
	//
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
		let dataUrl = URL(string: "https://nuevecubica.net/apps/theartgame/api/service.php")
		let task = URLSession.shared.dataTask(with: dataUrl!) { (data, response, error) in guard let data = data,
			let dataJson = (try? JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions.mutableContainers)) as? [Any]
			else {
				print("error: \(error)");
				return
			}
			
			
			//let jsonCount = dataJson.count
			
			
			
			print("_____________")
			print("preguntas: ")
			print(dataJson.count)
			//print((dataJson[0] as AnyObject).count)
			
			
			
			if let question = dataJson[0] as? [String: Any]{
				let theQuestion = question["question"]
				let theA1 = question["a1"]
				let theA2 = question["a2"]
				let theA3 = question["a3"]
				let theGameImage = question["image"]
				//print(theQuestion ?? "")
				//print(theA1 ?? "")
				self.gameQuestion.text = theQuestion as! String?
				self.gameA1.setTitle(theA1 as! String?, for: UIControlState.normal)
				self.gameA2.setTitle(theA2 as! String?, for: UIControlState.normal)
				self.gameA3.setTitle(theA3 as! String?, for: UIControlState.normal)
				

				self.gameImage.image?.accessibilityIdentifier = "https://nuevecubica.net/apps/theartgame/assets/img/game/\(theGameImage).jpg"
				
			}
			
			
			
			
		}
		
		task.resume()
		
	}
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	@IBAction func gameA1Action(_ sender: Any) {
	}
	@IBAction func gameA2Action(_ sender: Any) {
	}
	@IBAction func gameA3Action(_ sender: Any) {
	}
	//----------------
	
	
	//-----------------
}

