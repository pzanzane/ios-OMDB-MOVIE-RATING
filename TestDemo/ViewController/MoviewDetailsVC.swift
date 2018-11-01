//
//  MoviewDetailsVC.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MoviewDetailsVC: UIViewController,UIPopoverPresentationControllerDelegate {
    
//Outlets
    @IBOutlet weak var ratingContainer: UIView!
    @IBOutlet weak var moviewDetailsContainer: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblMoviewName: UILabel!
    @IBOutlet weak var lblMoviewDetailsInfo: UILabel!
    
    @IBOutlet weak var lblRateValue: UILabel!
    @IBOutlet weak var lblVotes: UILabel!
    @IBOutlet weak var imgRateIcon: UIImageView!
    
    @IBOutlet weak var lblMetaScore: UILabel!
    @IBOutlet weak var lblMetacoreReview: UILabel!
    
//Objects
    var imdbID : String!
    var moviewDetails : ResponseMoviewDetails?
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpActivityIndicator()
        self.setUpUI()
        self.makeAPiCall()

        // Do any additional setup after loading the view.
    }
    //MARK: - Helper
    func setUpActivityIndicator(){
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
    }
    func setUpUI(){
        self.navigationController?.title = "Details Info"
        ratingContainer.layer.cornerRadius = 7.0
        ratingContainer.layer.shadowOffset = CGSize(width:0, height:8)
        ratingContainer.layer.shadowOpacity = 0.8
        ratingContainer.layer.shadowColor = UIColor.lightGray.cgColor
        
        moviewDetailsContainer.layer.cornerRadius = 7.0
        moviewDetailsContainer.layer.shadowOffset = CGSize(width:0, height:8)
        moviewDetailsContainer.layer.shadowOpacity = 0.8
        moviewDetailsContainer.layer.shadowColor = UIColor.lightGray.cgColor
    }
    func setUpValue(){
        if let moviewInfo = self.moviewDetails{
            //Assine image
            let url = URL(string: moviewInfo.Poster ?? "")
            let data = try? Data(contentsOf: url!)
            if let imagedata = data{
                self.imgPoster.image = UIImage(data: imagedata)
            }
            self.lblMoviewName.text = moviewInfo.Title ?? ""
            let infostring = "\(moviewInfo.Year ?? ""), \(moviewInfo.Runtime ?? ""), \(moviewInfo.Type ?? ""), \(moviewInfo.Genre ?? "")"
            self.lblMoviewDetailsInfo.text = infostring
            
            //Rating view details
            if let rating = moviewInfo.Ratings{
                self.lblRateValue.text = rating.count > 0 ? rating[0].Value : ""
            }
            self.lblVotes.text = moviewInfo.imdbVotes ?? ""
            self.lblMetaScore.text = moviewInfo.Metascore ?? ""
            self.lblMetacoreReview.text = moviewInfo.totalSeasons ?? ""
    
        }
    }
    
    func makeAPiCall(){
        let requestMoview = RequestMoview()
        requestMoview.searchText = self.imdbID
        requestMoview.searchType = "i"
        self.activityIndicator.startAnimating()
        WebServicesAPI.sharedInstance().getMoviewDetails(request: requestMoview, onComplition:{(result:ResponseMoviewDetails?,error:PlatformError?) in
            if error != nil{
                self.activityIndicator.stopAnimating()
                self.showAlert(title: "Error", message: error?.message ?? "Error", closure:{})
            }
            if let response = result{
                self.moviewDetails = response
                self.setUpValue()
            }

        })
    }

    //MARK: - btnAction
    @IBAction func btnRateTapped(_ sender: Any) {
        let popOverControllerVC = self.storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        popOverControllerVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popOverControllerVC.moviewObj = self.moviewDetails
        popOverControllerVC.modalPresentationStyle = .overCurrentContext
        popOverControllerVC.modalTransitionStyle = .coverVertical
        self.present(popOverControllerVC, animated: true, completion: nil)
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
