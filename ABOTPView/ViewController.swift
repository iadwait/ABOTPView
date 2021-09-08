//
//  ViewController.swift
//  ABOTPView
//
//  Created by Adwait Barkale on 08/09/21.
//

import UIKit

/// This ViewController Class is to Test OTP View
class ViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var otpView: ABOTPView!
    
    //MARK:- Variable Declarations
    var isOTPHidden = true
    
    //MARK:- View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOTPView()
    }
    
    //MARK:- User Defined Functions
    
    /// Function Call to setup OTP View
    func setupOTPView()
    {
        otpView.otpViewDelegate = self // Set otpViewDelegate as instance of your view controller 'Self'
        otpView.filledBottomBorderColor = .yellow // Bottom Border Color When OTP is Entered
        otpView.unfilledBottomBorderColor = .white // Bottom Border Color Where OTP is not Entered
        otpView.enteredOTPViewTextColor = .white // OTP Entered and is visible/Shown to user eg:- 123445
        otpView.enteredOTPViewFilledColor = .yellow // OTP Entered and is hidden to user with round circles
        otpView.setInitialOTPView() // Setup OTP View
    }

    //MARK:- IBActions
    /// Function Call when User Tap's on Show Hide OTP
    /// - Parameter sender: UIButton
    @IBAction func btnShowHideOTPTapped(_ sender: UIButton) {
        otpView.showHideOTP(isShown: !isOTPHidden)
    }
    
}

//MARK:- Extensions
//MARK:- ABOTPViewDelegate
extension ViewController: ABOTPViewDelegate {
    
    /// This Function Get's Called When all 6 digit OTP is Entered
    /// - Parameter otp: User Entered OTP Received Here
    func userEnteredOTP(otp: String) {
        let alert = UIAlertController(title: "", message: "User Entered OTP = \(otp)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            self.otpView.resetOTPField()
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
