//
//  RatingVC.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class RatingVC: UIViewController,UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblRatingInfo: UILabel!
    @IBOutlet weak var txtFeedback: UITextField!
    
    //Objects
    var moviewObj : ResponseMoviewDetails?
    var ref : DatabaseReference!
    var userRating : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpValue()
        
        self.ratingView.didFinishTouchingCosmos = { rating in
            print(rating)
            self.userRating = String(rating)
        }
        // Do any additional setup after loading the view.
        //firebase object
        ref = Database.database().reference()
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
        if let email = UserDefaults.standard.value(forKey: "UserEmail"){
            self.txtUserName.text = email as? String
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
    
        if txtUserName.text?.count == 0 || txtFeedback.text?.count == 0{
            self.showAlert(title: "", message: "Name is mandetory", closure:{})
        }else{

            ref.child("RatingInfo").child("UserName").setValue(txtUserName.text)
            ref.child("RatingInfo").child("Feedback").setValue(txtFeedback.text)
            ref.child("RatingInfo").child("Rating").setValue(self.userRating ?? "0")

            self.showAlert(title: "", message: "Submitted successfuly", closure:{})
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
