//
//  UIView+ViewController.swift
//  Scoresheet
//
//  Created by Jack Cook on 2/19/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

extension UIView {
    
    var viewController: UIViewController? {
        guard let responder = next else {
            return nil
        }
        
        if let viewController = responder as? UIViewController {
            return viewController
        } else if let view = responder as? UIView {
            return view.viewController
        } else {
            return nil
        }
    }
}
