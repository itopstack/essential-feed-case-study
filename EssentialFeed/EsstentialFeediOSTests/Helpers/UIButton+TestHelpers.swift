//
//  UIButton+TestHelpers.swift
//  EsstentialFeediOSTests
//
//  Created by Kittisak Phetrungnapha on 16/5/2565 BE.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
