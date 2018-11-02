//
//  HomeVc.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
class HomeVc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //Outlets
    @IBOutlet weak var moviewTable: UITableView!
    //Buttons
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnMoview: UIButton!
    @IBOutlet weak var btnSerise: UIButton!
    
    //Labels
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblMoview: UILabel!
    @IBOutlet weak var lblSerise: UILabel!
    
    //Objects
    var responseArray : [ResponseSearch] = []
    var moviewArray : [ResponseSearch] = []
    var searchBar:UISearchBar!
    var selectedMoviewType : String!
    var activityIndicator = UIActivityIndicatorView()
    
    public enum MoviewType : String{
        case MOVIEW = "movie"
        case SERISE = "series"
        case ALL = "All"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.segmentInitialValue()
        self.setUpActivityIndicator()
        self.moviewTable.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        
        self.moviewTable.estimatedRowHeight = 132.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.makeAPICall(serchType: "s", searchText: "2017")
    }
    
    //MARK: - ButtonActions
    @IBAction func btnAllTapped(_ sender: Any) {
        self.lblAll.isHidden = false
        self.lblMoview.isHidden = true
        self.lblSerise.isHidden = true
        
        self.btnAll.setTitleColor(UIColor.white, for: .normal)
        self.btnMoview.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.btnSerise.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.selectedMoviewType = MoviewType.ALL.rawValue
        self.filterResponse()
    }
    @IBAction func btnMoviewTapped(_ sender: Any) {
        self.lblAll.isHidden = true
        self.lblMoview.isHidden = false
        self.lblSerise.isHidden = true
        
        self.btnAll.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.btnMoview.setTitleColor(UIColor.white, for: .normal)
        self.btnSerise.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.selectedMoviewType = MoviewType.MOVIEW.rawValue
        self.filterResponse()
        
    }
    @IBAction func btnSeriseTapped(_ sender: Any) {
        self.lblAll.isHidden = true
        self.lblMoview.isHidden = true
        self.lblSerise.isHidden = false
        
        self.btnAll.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.btnMoview.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.btnSerise.setTitleColor(UIColor.white, for: .normal)
        self.selectedMoviewType = MoviewType.SERISE.rawValue
        self.filterResponse()
        
    }
    
    func segmentInitialValue(){
        self.lblAll.isHidden = false
        self.lblMoview.isHidden = true
        self.lblSerise.isHidden = true
        
        self.btnAll.setTitleColor(UIColor.white, for: .normal)
        self.btnMoview.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.btnSerise.setTitleColor(UIColor.SegmentButtonColor, for: .normal)
        self.selectedMoviewType = MoviewType.ALL.rawValue
        self.filterResponse()
    }
    
    //MARK: - Helper
    func setUpActivityIndicator(){
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true

        searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 38, height: 40))
        searchBar.delegate = self
        searchBar.placeholder = "Search here"
        //searchBar.showsCancelButton = true
        searchBar.tintColor = UIColor.black
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    func filterResponse(){
             self.moviewArray = self.responseArray
            if self.selectedMoviewType != MoviewType.ALL.rawValue{
                self.moviewArray = self.moviewArray.filter({$0.Type == self.selectedMoviewType})
            }
            self.moviewTable.reloadData()
    }
    
    func makeAPICall(serchType : String, searchText : String){
        let requestMoview = RequestMoview()
               requestMoview.searchText = searchText
              requestMoview.searchType = serchType
           self.activityIndicator.startAnimating()
            WebServicesAPI.sharedInstance().getMoview(request: requestMoview, onComplition:{(result:ResponseMovieSearch?,error:PlatformError?) in
                   if error != nil{
                self.activityIndicator.stopAnimating()
                self.showAlert(title: "Error", message: error?.message ?? "Error", closure:{})
                   }
                  print(result?.Search ?? "")
                guard  !((result?.Error) != nil) else{
                    self.activityIndicator.stopAnimating()
                    self.showAlert(title: "Error", message: result?.Error, closure:{})
                    return
                }
                self.activityIndicator.stopAnimating()
                self.responseArray = result?.Search ?? []
                self.filterResponse()
            })
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
extension HomeVc{
    //MARK: - TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.moviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let moviewCell = moviewTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! moviewCell
        moviewCell.lblMoviewName.text = self.moviewArray[indexPath.row].Title ?? ""
        moviewCell.lblMoviewYear.text = self.moviewArray[indexPath.row].Year ?? ""
        print(self.moviewArray[indexPath.row].Type ?? "No type")
        
       //Assine image
        let url = URL(string: self.moviewArray[indexPath.row].Poster ?? "")
        moviewCell.imgMoviePoster.image = UIImage(named: "default.png")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                moviewCell.imgMoviePoster.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
        
        return moviewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objMoviewDetails = self.storyboard?.instantiateViewController(withIdentifier: "MoviewDetailsVC") as! MoviewDetailsVC
        objMoviewDetails.imdbID = self.moviewArray[indexPath.row].imdbID ?? ""
        self.navigationController?.pushViewController(objMoviewDetails, animated: true)
    }
    
}

extension HomeVc: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
        self.makeAPICall(serchType: "s", searchText: searchBar.text ?? "")
       
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
        self.searchBar.text = ""
        self.makeAPICall(serchType: "s", searchText: "2017")
    }
}
