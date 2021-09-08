//
//  Extensions.swift
//  ABOTPView
//
//  Created by Adwait Barkale on 08/09/21.
//

import Foundation
import UIKit

extension UIView {
    
    func loadViewFromNibName(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}

extension String {
    
    /// Detect backspace in textfield
    var isBackspace: Bool {
      let char = self.cString(using: String.Encoding.utf8)!
      return strcmp(char, "\\b") == -92
    }
    
}
