//
//  ViewController.swift
//  ABOTPView
//
//  Created by Adwait Barkale on 08/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var otpView: ABOTPView!
    
    var isOTPHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOTPView()
    }
    
    func setupOTPView()
    {
        otpView.otpViewDelegate = self
        otpView.filledBottomBorderColor = .green
        otpView.unfilledBottomBorderColor = .red
        otpView.enteredOTPViewTextColor = .brown
        otpView.enteredOTPViewFilledColor = .cyan
        otpView.setInitialOTPView()
    }

    @IBAction func btnShowHideOTPTapped(_ sender: UIButton) {
        otpView.showHideOTP(isShown: !isOTPHidden)
    }
    
}

extension ViewController: ABOTPCircleViewDelegate {
    
    func userEnteredOTP(otp: String) {
        let alert = UIAlertController(title: "", message: "User Entered OTP = \(otp)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            self.otpView.resetOTPField()
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

