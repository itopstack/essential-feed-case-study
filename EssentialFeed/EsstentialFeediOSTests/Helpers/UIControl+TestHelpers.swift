//
//  UIControl+TestHelpers.swift
//  EsstentialFeediOSTests
//
//  Created by Kittisak Phetrungnapha on 16/5/2565 BE.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
