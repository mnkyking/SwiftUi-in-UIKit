//
//  SecondViewController.swift
//  SwiftUi In UiKitTable
//
//  Created by Robin G on 8/13/21.
//

import UIKit

protocol DismissMeDelegate: AnyObject {
    func didDismiss()
}

class SecondViewController: UIViewController {
    var delegate: DismissMeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let delegate = delegate else { return }
        delegate.didDismiss()
    }
}
