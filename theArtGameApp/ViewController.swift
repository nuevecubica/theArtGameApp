//
//  ViewController.swift
//  theArtGameApp
//
//  Created by alex vaught on 8/3/17.
//  Copyright © 2017 alex vaught. All rights reserved.
//

import UIKit
import SDWebImage


class ViewController: UIViewController {
	
	@IBOutlet weak var gameImage: UIImageView!
	@IBOutlet weak var gameQuestion: UILabel!
	@IBOutlet weak var gameA1: UIButton!
	@IBOutlet weak var gameA2: UIButton!
	@IBOutlet weak var gameA3: UIButton!
	@IBOutlet weak var gameScore: UILabel!
	@IBOutlet weak var questionCount: UILabel!

	
	//LOAD DATA
	
	var Questions : String!
	var Image : String!
	var Answer : String!
	var correct: String!
	var Value : String!
	var HowMany : Int!
	var thisScore : Int!
	var dataJson : JSONSerialization!
	var question : Array<Any>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		// Do stuff to UI
		self.getData();
	}
	
	let dataUrl = URL(string: "https://nuevecubica.net/apps/theartgame/api/service.php")
	
	func getData(){
		
		let task = URLSession.shared.dataTask(with: dataUrl!) { (data, response, error) in
			DispatchQueue.main.async() {
				guard
					let data = data,
					let dataJson = (try? JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions.mutableContainers)) as? [Any]
					else {
						print("error: \(String(describing: error))");
						return
				}
				
				//print((dataJson[0] as AnyObject).count)
				if let question = dataJson[0] as? [String: Any]{
					let theQuestion = question["question"]
					let theA1 = question["a1"]
					let theA2 = question["a2"]
					let theA3 = question["a3"]
					let theGameImage = "https://nuevecubica.net/apps/theartgame/assets/img/game/\(question["image"]!).jpg"
					let correctAnswer = question["correct"]
					let questionValue = question["qvalue"]
					let AnswerFocus = question["answer"]
					
					print(theGameImage)

					self.gameQuestion.text = theQuestion as! String?
					self.gameA1.setTitle(theA1 as! String?, for: UIControlState.normal)
					self.gameA2.setTitle(theA2 as! String?, for: UIControlState.normal)
					self.gameA3.setTitle(theA3 as! String?, for: UIControlState.normal)
					self.gameImage.sd_setShowActivityIndicatorView(true)
					self.gameImage.sd_setIndicatorStyle(.white)
					self.gameImage.sd_setImage(with: URL(string: (theGameImage as String?)!), placeholderImage: UIImage(named: "placeholder.png"))

					
					
					self.gameA1.tag = 1
					self.gameA2.tag = 2
					self.gameA3.tag = 3
					
					self.correct = correctAnswer as! String
					self.Answer = AnswerFocus as! String
					self.Value = questionValue as! String
					self.HowMany = dataJson.count
                    self.questionCount.text = "Questions \(String("1")) / \(String(self.HowMany))"
					
					
				}
			}
		}
		task.resume()
	}
	
	func testJson(){
		print(question)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func resetButtons(){
		self.gameA1.backgroundColor = UIColor(red:0.14, green:0.40, blue:0.56, alpha:1.0)
		self.gameA2.backgroundColor = UIColor(red:0.14, green:0.40, blue:0.56, alpha:1.0)
		self.gameA3.backgroundColor = UIColor(red:0.14, green:0.40, blue:0.56, alpha:1.0)
	}
	
	
	func rightAnswer() {
		
		resetButtons()
		getData()
		let aValue:Int? = Int(self.gameScore.text!)
		let bValue:Int? = Int(self.Value)
		if (aValue != nil) && (bValue != nil){
			 thisScore = aValue! + bValue!
		}
		self.gameScore.text = String(thisScore)
         changeScoreColor()
	}
    
	func wrongAnswer(){
		resetButtons()
		getData()
		let aValue:Int? = Int(self.gameScore.text!)
		let bValue:Int? = Int(self.Value)
		if (aValue != nil) && (bValue != nil){
			thisScore = aValue! - bValue!
		}
        self.gameScore.text = String(thisScore)
         changeScoreColor()
	}
    
    func changeScoreColor(){
        if((thisScore)! < 0){
        print("es maypr")
        self.gameScore.textColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        }else{
        self.gameScore.textColor = UIColor.white
        }
    }
    
    
    
	@IBAction func selectAnswer(_ sender: UIButton) {
       
		let senderTag = "a\(sender.tag)"
        
		print("\(senderTag) \(correct)")
        
		if senderTag == correct {
            
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let popUpViewController = segue.destination as? popUpViewController{
                    popUpViewController.modalTitle.text = "punchino"
                    popUpViewController.modalText.text = Answer!
                }
            }
            //performSegue(withIdentifier: "presentModal", sender: nil)
            rightAnswer()
            
         
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "lepopup") as! popUpViewController
            //vc.modalTitle.text = "Beautiful"
           
            navigationController?.pushViewController(vc, animated: true)
         
			//sender.backgroundColor = UIColor(red:0.44, green:0.51, blue:0.23, alpha:1.0)
            
            /*
			let alertController = UIAlertController(title: "Yay!!", message: "RIGHT ANSWER\n\(Answer!)", preferredStyle: .alert)
			let image =  UIImage(named: "icon_pdf_ok")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
			let action = UIAlertAction(title: "OK", style: .default, handler: nil)
			action.setValue(image, forKey: "image")
			alertController.addAction(action)
			alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: rightAnswer))
			present(alertController, animated: true, completion: nil)
             */
            
            
            
			
			
			
		} else {
            wrongAnswer()
             performSegue(withIdentifier: "presentModal", sender: nil)
			//sender.backgroundColor = UIColor(red:1.00, green:0.38, blue:0.41, alpha:1.0)
            /*
			let alertController = UIAlertController(title: "NAY!!", message: "WRONG ANSWER!!!", preferredStyle: .alert)
			let image = UIImage(named: "icon_pdf_not_ok")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
			let action = UIAlertAction(title: "OK", style: .default, handler: nil)
			action.setValue(image, forKey: "image")
			alertController.addAction(action)
			alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: wrongAnswer))
			present(alertController, animated: true, completion: nil)
			*/
		}
		
	}
	//----------------
    
	
	//-----------------
}
