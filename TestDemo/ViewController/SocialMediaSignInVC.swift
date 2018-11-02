//
//  SocialMediaSignInVC.swift
//  TestDemo
//
//  Created by Apple on 02/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn
protocol googleSignInProtocol {
    func signIncomplete(userEmail : String)
}

class SocialMediaSignInVC: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
    @IBOutlet weak var container: UIView!
    
    var signInDelegate : googleSignInProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
    container.layer.cornerRadius = 6.0
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self

        // Do any additional setup after loading the view.
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error?) {
        //UIActivityIndicatorView.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let email = user.profile.email{
            UserDefaults.standard.set(email, forKey: "UserEmail")
            self.dismiss(animated: true, completion: nil)
            self.signInDelegate.signIncomplete(userEmail: email)
            self.showAlert(title: "Login Successful", message: email, closure:{})
        }
        //self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    @IBAction func closeTapped(_ sender: Any) {
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
