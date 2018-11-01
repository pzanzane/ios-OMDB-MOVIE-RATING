//
//  RatingVC.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Cosmos

class RatingVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblRatingInfo: UILabel!
    
    //Objects
    var moviewObj : ResponseMoviewDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpValue()
        
        self.ratingView.didFinishTouchingCosmos = { rating in
            print(rating)
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Helper
    func setUpUI(){
        self.ratingView.rating = 0
        self.btnSubmit.layer.cornerRadius = 6.0
        self.containerView.layer.cornerRadius = 6.0
    }
    
    func setUpValue(){
        if let objMoview = moviewObj{
            self.lblRatingInfo.text = "How would you rate \(objMoview.Title ?? "")"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func makeAPICall(){
        //Rating api call
    }
    
    //MARK: - ButtonAction
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if txtUserName.text?.count == 0{
         self.showAlert(title: "", message: "Name is mandetory", closure:{})
        }else{
             self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
