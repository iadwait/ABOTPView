//
//  ABOTPView.swift
//  ABOTPView
//
//  Created by Adwait Barkale on 08/09/21.
//

import UIKit

/// Protocol to get OTP in your View Controllers
protocol ABOTPViewDelegate {
    // This Function is Called when all 6 digit OTP is Entered by User
    func userEnteredOTP(otp: String)
}

/// Enum to Decide Size of OTP Circles
enum otpSize {
    case small
    case medium
    case large
}

/// This is Reusable Class that wil help you achieve Circular OTP View
class ABOTPView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet weak var txtOTP1: MyTextField!
    @IBOutlet weak var txtOTP2: MyTextField!
    @IBOutlet weak var txtOTP3: MyTextField!
    @IBOutlet weak var txtOTP4: MyTextField!
    @IBOutlet weak var txtOTP5: MyTextField!
    @IBOutlet weak var txtOTP6: MyTextField!
    //Constraints
    @IBOutlet weak var cStkViewWidth: NSLayoutConstraint!
    @IBOutlet weak var cStkViewHeight: NSLayoutConstraint!
    
    //MARK:- Variable Declarations
    var curTflTag = 0
    var isShow = false
    var originalText = ""
    let whiteColor = UIColor.white
    let yellowColor = UIColor.yellow
    let blackColor = UIColor.black
    var otpViewDelegate: ABOTPViewDelegate?
    //User Usage
    var filledBottomBorderColor: UIColor = UIColor.green
    var unfilledBottomBorderColor: UIColor = UIColor.darkGray
    var enteredOTPViewTextColor: UIColor = UIColor.green // When OTP is Entered(Shown) - Text/Number Shown Color
    var enteredOTPViewFilledColor: UIColor = UIColor.darkGray// When OTP is Entered(Hidden) - Fill Color
    var otpSize: otpSize = .medium // Size of OTP Fields
    
    //MARK:- View Xib Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNibName(nibName: "ABOTPView") else { return }
        view.frame = self.bounds
        setInitialOTPView()
        self.addSubview(view)
    }
    
    //MARK:- User Usage Functions
    
    
    //MARK:- UI Handling
    
    /// Function Call to set Initial OTP View
    func setInitialOTPView()
    {
        self.backgroundColor = .clear
     
        if otpSize == .small {
            cStkViewWidth.constant = 170
            cStkViewHeight.constant = 20
        } else if otpSize == .medium {
            cStkViewWidth.constant = 200
            cStkViewHeight.constant = 25
        } else if otpSize == .large {
            cStkViewWidth.constant = 230
            cStkViewHeight.constant = 30
        }
        self.layoutIfNeeded()
        
        txtOTP1.tag = 1
        txtOTP2.tag = 2
        txtOTP3.tag = 3
        txtOTP4.tag = 4
        txtOTP5.tag = 5
        txtOTP6.tag = 6
        
        setUnfilledBorderRadius(tfl: txtOTP1)
        setUnfilledBorderRadius(tfl: txtOTP2)
        setUnfilledBorderRadius(tfl: txtOTP3)
        setUnfilledBorderRadius(tfl: txtOTP4)
        setUnfilledBorderRadius(tfl: txtOTP5)
        setUnfilledBorderRadius(tfl: txtOTP6)
        
        addBottomBorder(tfl: txtOTP1, color: unfilledBottomBorderColor)
        addBottomBorder(tfl: txtOTP2, color: unfilledBottomBorderColor)
        addBottomBorder(tfl: txtOTP3, color: unfilledBottomBorderColor)
        addBottomBorder(tfl: txtOTP4, color: unfilledBottomBorderColor)
        addBottomBorder(tfl: txtOTP5, color: unfilledBottomBorderColor)
        addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        
        makeTextFieldCircular(tfl: txtOTP1)
        makeTextFieldCircular(tfl: txtOTP2)
        makeTextFieldCircular(tfl: txtOTP3)
        makeTextFieldCircular(tfl: txtOTP4)
        makeTextFieldCircular(tfl: txtOTP5)
        makeTextFieldCircular(tfl: txtOTP6)
        
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        txtOTP5.delegate = self
        txtOTP6.delegate = self
        
        txtOTP1.myDelegate = self
        txtOTP2.myDelegate = self
        txtOTP3.myDelegate = self
        txtOTP4.myDelegate = self
        txtOTP5.myDelegate = self
        txtOTP6.myDelegate = self
        
        txtOTP1.keyboardType = .numberPad
        txtOTP2.keyboardType = .numberPad
        txtOTP3.keyboardType = .numberPad
        txtOTP4.keyboardType = .numberPad
        txtOTP5.keyboardType = .numberPad
        txtOTP6.keyboardType = .numberPad
    }
    
    /// Function to add bottom border to TextField
    /// - Parameter tfl: UITextfield
    func addBottomBorder(tfl: UITextField,color: UIColor)
    {
        let layer = CALayer()
        layer.backgroundColor = color.cgColor
        if otpSize == .small {
            layer.frame = .init(x: 0, y: tfl.frame.size.height + 4.0, width: tfl.frame.size.width + 5.0, height: 2.0)
        } else if otpSize == .medium {
            layer.frame = .init(x: 0, y: tfl.frame.size.height + 4.0, width: tfl.frame.size.width + 5.0, height: 2.0)
        } else if otpSize == .large {
            layer.frame = .init(x: 0, y: tfl.frame.size.height + 4.0, width: tfl.frame.size.width + 5.0, height: 2.0)
        }
        tfl.layer.addSublayer(layer)
    }
    
    /// Function to make Textfield Circular
    /// - Parameter tfl: UITextfield
    func makeTextFieldCircular(tfl: UITextField)
    {
        tfl.layer.cornerRadius = tfl.frame.size.height / 2
    }
    
    /// Function call to make textfield empty bordered
    /// - Parameter tfl: UITextfield
    func setUnfilledBorderRadius(tfl: UITextField)
    {
        tfl.backgroundColor = .clear
        tfl.layer.borderColor = UIColor.clear.cgColor
        tfl.layer.borderWidth = 1
        tfl.textColor = .black
    }
    
    /// Function ca;; to make textfield not hidden
    func setAllNotHidden()
    {
        setTextFieldNotHidden(tfl: txtOTP1)
        setTextFieldNotHidden(tfl: txtOTP2)
        setTextFieldNotHidden(tfl: txtOTP3)
        setTextFieldNotHidden(tfl: txtOTP4)
        setTextFieldNotHidden(tfl: txtOTP5)
        setTextFieldNotHidden(tfl: txtOTP6)
    }
    
    /// Function call to make textfield not hidden
    /// - Parameter tfl: UITextfield
    func setTextFieldNotHidden(tfl: UITextField)
    {
        tfl.backgroundColor = .clear
        tfl.layer.borderColor = UIColor.clear.cgColor
        tfl.textColor = enteredOTPViewTextColor
        setBottomBorder(forTextfields: originalText.count)
    }
    
    /// This Function is used to set bottom border
    /// - Parameter forTextfields: Send Original text count here
    func setBottomBorder(forTextfields: Int)
    {
        switch forTextfields {
        case 0:
            addBottomBorder(tfl: txtOTP1, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        case 1:
            addBottomBorder(tfl: txtOTP1, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        case 2:
            addBottomBorder(tfl: txtOTP1, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        case 3:
            addBottomBorder(tfl: txtOTP1, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        case 4:
            addBottomBorder(tfl: txtOTP1, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: unfilledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        case 5:
            addBottomBorder(tfl: txtOTP1, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: unfilledBottomBorderColor)
        case 6:
            addBottomBorder(tfl: txtOTP1, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP2, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP3, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP4, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP5, color: filledBottomBorderColor)
            addBottomBorder(tfl: txtOTP6, color: filledBottomBorderColor)
        default:
            break
        }
    }
    
    /// Function call to make textfield Filled with Data
    func setDataFilled()
    {
        switch originalText.count {
        case 0:
            setBottomBorder(forTextfields: 0)
            setUnfilledBorderRadius(tfl: txtOTP1)
            setUnfilledBorderRadius(tfl: txtOTP2)
            setUnfilledBorderRadius(tfl: txtOTP3)
            setUnfilledBorderRadius(tfl: txtOTP4)
            setUnfilledBorderRadius(tfl: txtOTP5)
            setUnfilledBorderRadius(tfl: txtOTP6)
        case 1:
            setBottomBorder(forTextfields: 1)
            setTextFieldHidden(tfl: txtOTP1)
            setUnfilledBorderRadius(tfl: txtOTP2)
            setUnfilledBorderRadius(tfl: txtOTP3)
            setUnfilledBorderRadius(tfl: txtOTP4)
            setUnfilledBorderRadius(tfl: txtOTP5)
            setUnfilledBorderRadius(tfl: txtOTP6)
        case 2:
            setBottomBorder(forTextfields: 2)
            setTextFieldHidden(tfl: txtOTP1)
            setTextFieldHidden(tfl: txtOTP2)
            setUnfilledBorderRadius(tfl: txtOTP3)
            setUnfilledBorderRadius(tfl: txtOTP4)
            setUnfilledBorderRadius(tfl: txtOTP5)
            setUnfilledBorderRadius(tfl: txtOTP6)
        case 3:
            setBottomBorder(forTextfields: 3)
            setTextFieldHidden(tfl: txtOTP1)
            setTextFieldHidden(tfl: txtOTP2)
            setTextFieldHidden(tfl: txtOTP3)
            setUnfilledBorderRadius(tfl: txtOTP4)
            setUnfilledBorderRadius(tfl: txtOTP5)
            setUnfilledBorderRadius(tfl: txtOTP6)
        case 4:
            setBottomBorder(forTextfields: 4)
            setTextFieldHidden(tfl: txtOTP1)
            setTextFieldHidden(tfl: txtOTP2)
            setTextFieldHidden(tfl: txtOTP3)
            setTextFieldHidden(tfl: txtOTP4)
            setUnfilledBorderRadius(tfl: txtOTP5)
            setUnfilledBorderRadius(tfl: txtOTP6)
        case 5:
            setBottomBorder(forTextfields: 5)
            setTextFieldHidden(tfl: txtOTP1)
            setTextFieldHidden(tfl: txtOTP2)
            setTextFieldHidden(tfl: txtOTP3)
            setTextFieldHidden(tfl: txtOTP4)
            setTextFieldHidden(tfl: txtOTP5)
            setUnfilledBorderRadius(tfl: txtOTP6)
        case 6:
            setBottomBorder(forTextfields: 6)
            setTextFieldHidden(tfl: txtOTP1)
            setTextFieldHidden(tfl: txtOTP2)
            setTextFieldHidden(tfl: txtOTP3)
            setTextFieldHidden(tfl: txtOTP4)
            setTextFieldHidden(tfl: txtOTP5)
            setTextFieldHidden(tfl: txtOTP6)
        default:
            break
        }
    }
    
    /// Function call to make textfield hidden
    /// - Parameter tfl: UITextfield
    func setTextFieldHidden(tfl: UITextField)
    {
        tfl.backgroundColor = enteredOTPViewFilledColor
        tfl.textColor = .clear
    }
    
    /// Function Call to Show or Hide OTP
    /// - Parameter isShown: isShown or Not
    func showHideOTP(isShown: Bool) {
        if !isShow == false {
            switch originalText.count {
            case 0:
                setBottomBorder(forTextfields: 0)
                setUnfilledBorderRadius(tfl: txtOTP1)
                setUnfilledBorderRadius(tfl: txtOTP2)
                setUnfilledBorderRadius(tfl: txtOTP3)
                setUnfilledBorderRadius(tfl: txtOTP4)
                setUnfilledBorderRadius(tfl: txtOTP5)
                setUnfilledBorderRadius(tfl: txtOTP6)
            case 1:
                setBottomBorder(forTextfields: 1)
                setTextFieldHidden(tfl: txtOTP1)
                setUnfilledBorderRadius(tfl: txtOTP2)
                setUnfilledBorderRadius(tfl: txtOTP3)
                setUnfilledBorderRadius(tfl: txtOTP4)
                setUnfilledBorderRadius(tfl: txtOTP5)
                setUnfilledBorderRadius(tfl: txtOTP6)
            case 2:
                setBottomBorder(forTextfields: 2)
                setTextFieldHidden(tfl: txtOTP1)
                setTextFieldHidden(tfl: txtOTP2)
                setUnfilledBorderRadius(tfl: txtOTP3)
                setUnfilledBorderRadius(tfl: txtOTP4)
                setUnfilledBorderRadius(tfl: txtOTP5)
                setUnfilledBorderRadius(tfl: txtOTP6)
            case 3:
                setBottomBorder(forTextfields: 3)
                setTextFieldHidden(tfl: txtOTP1)
                setTextFieldHidden(tfl: txtOTP2)
                setTextFieldHidden(tfl: txtOTP3)
                setUnfilledBorderRadius(tfl: txtOTP4)
                setUnfilledBorderRadius(tfl: txtOTP5)
                setUnfilledBorderRadius(tfl: txtOTP6)
            case 4:
                setBottomBorder(forTextfields: 4)
                setTextFieldHidden(tfl: txtOTP1)
                setTextFieldHidden(tfl: txtOTP2)
                setTextFieldHidden(tfl: txtOTP3)
                setTextFieldHidden(tfl: txtOTP4)
                setUnfilledBorderRadius(tfl: txtOTP5)
                setUnfilledBorderRadius(tfl: txtOTP6)
            case 5:
                setBottomBorder(forTextfields: 5)
                setTextFieldHidden(tfl: txtOTP1)
                setTextFieldHidden(tfl: txtOTP2)
                setTextFieldHidden(tfl: txtOTP3)
                setTextFieldHidden(tfl: txtOTP4)
                setTextFieldHidden(tfl: txtOTP5)
                setUnfilledBorderRadius(tfl: txtOTP6)
            case 6:
                setBottomBorder(forTextfields: 6)
                setTextFieldHidden(tfl: txtOTP1)
                setTextFieldHidden(tfl: txtOTP2)
                setTextFieldHidden(tfl: txtOTP3)
                setTextFieldHidden(tfl: txtOTP4)
                setTextFieldHidden(tfl: txtOTP5)
                setTextFieldHidden(tfl: txtOTP6)
            default:
                break
            }
            isShow = !isShow
        } else {
            //Show Numbers
            setTextFieldNotHidden(tfl: txtOTP1)
            setTextFieldNotHidden(tfl: txtOTP2)
            setTextFieldNotHidden(tfl: txtOTP3)
            setTextFieldNotHidden(tfl: txtOTP4)
            setTextFieldNotHidden(tfl: txtOTP5)
            setTextFieldNotHidden(tfl: txtOTP6)
            isShow = !isShow
        }
    }
    
    /// Function Call to Reset OTP Fields
    func resetOTPField() {
        let count = originalText.count
        switch count {
        case 1:
            txtOTP2.resignFirstResponder()
        case 2:
            txtOTP3.resignFirstResponder()
        case 3:
            txtOTP4.resignFirstResponder()
        case 4:
            txtOTP5.resignFirstResponder()
        case 5:
            txtOTP6.resignFirstResponder()
        default:
            break
        }
        
        originalText = ""
        curTflTag = 0
        setBottomBorder(forTextfields: 0)
        
        setUnfilledBorderRadius(tfl: txtOTP1)
        setUnfilledBorderRadius(tfl: txtOTP2)
        setUnfilledBorderRadius(tfl: txtOTP3)
        setUnfilledBorderRadius(tfl: txtOTP4)
        setUnfilledBorderRadius(tfl: txtOTP5)
        setUnfilledBorderRadius(tfl: txtOTP6)
        
        setAllNotHidden()
        txtOTP1.text = ""
        txtOTP2.text = ""
        txtOTP3.text = ""
        txtOTP4.text = ""
        txtOTP5.text = ""
        txtOTP6.text = ""
        
    }
    
    //MARK:- IBActions
    
    /// Function call when user tap on button which is placed on top of all 6 textfields/OTP View
    /// - Parameter sender: UIButton
    @IBAction func btnActivateOTPTapped(_ sender: UIButton) {
        if originalText == ""
        {
            txtOTP1.becomeFirstResponder()
        } else {
            //Check Count and Count + 1 will be Responder, if count == 6 than 6 will be responder
            if originalText.count == 6
            {
                txtOTP6.becomeFirstResponder()
            } else {
                switch originalText.count {
                case 1:
                    txtOTP2.becomeFirstResponder()
                case 2:
                    txtOTP3.becomeFirstResponder()
                case 3:
                    txtOTP4.becomeFirstResponder()
                case 4:
                    txtOTP5.becomeFirstResponder()
                case 5:
                    txtOTP6.becomeFirstResponder()
                default:
                    break
                }
            }
        }
    }
    
    
}

//MARK:- Extensions
//MARK:- UITextFieldDelegate
extension ABOTPView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.curTflTag = textField.tag + 1
        
        if string.isBackspace {
            originalText.removeLast()
        }
        
        if string != ""
        {
            originalText.append(string)
        }
        
        if isShow{
            setAllNotHidden()
        } else {
            setDataFilled()
        }
        if textField.text!.count >= 1 && string.count == 0 {
            if textField == txtOTP2 {
                txtOTP1.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP5 {
                txtOTP4.becomeFirstResponder()
            }
            
            if textField == txtOTP6 {
                txtOTP5.becomeFirstResponder()
            }
            
            if textField == txtOTP1 {
                txtOTP1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        }
        else if textField.text!.count < 1 && string.count > 0
        {
            if textField == txtOTP1 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP2 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP4.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP5.becomeFirstResponder()
            }
            
            if textField == txtOTP5 {
                txtOTP6.becomeFirstResponder()
            }
            
            if textField == txtOTP6 {
                txtOTP6.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if textField.text!.count >= 1 {
            textField.text = string
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Hit Api and Clear OTP View
        if curTflTag == 7 && originalText.count == 6
        {
            // OriginalText contains 6 digit OTP Entered
            otpViewDelegate?.userEnteredOTP(otp: originalText)
        }
    }
    
}

//MARK:- MyTextfield Class
protocol MyTextFieldDelegate: AnyObject {
    func textFieldDidDelete()
}

/// Class to Detect Backspace on Empty Textfield
class MyTextField: UITextField {
    
    weak var myDelegate: MyTextFieldDelegate?
    
    /// Function call when user press backspace even when textfield count is 0
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }
    
}

//MARK:- MyTextFieldDelegate
extension ABOTPView: MyTextFieldDelegate {
    
    func textFieldDidDelete() {
        switch curTflTag {
        case 2:
            //txtOTP1.resignFirstResponder()
            self.endEditing(true)
            originalText.removeLast()
            txtOTP1.text = ""
            
        case 3:
            
            txtOTP2.becomeFirstResponder()
            originalText.removeLast()
            txtOTP2.text = ""
            
        case 4:
            txtOTP3.becomeFirstResponder()
            originalText.removeLast()
            txtOTP3.text = ""
            
        case 5:
            
            txtOTP4.becomeFirstResponder()
            originalText.removeLast()
            txtOTP4.text = ""
            
        case 6:
            
            txtOTP5.becomeFirstResponder()
            originalText.removeLast()
            txtOTP5.text = ""
            
        default:
            break
        }
        curTflTag -= 1
        if isShow{
            setAllNotHidden()
        } else {
            setDataFilled()
        }
    }
    
}
