//
//  UIColor.randomBrightColor.swift
//  CircleSpawn
//
//  Created by Krystian Duma on 01/04/2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  static func randomBrightColor() -> UIColor {
    return UIColor(hue: .random(),
             saturation: .random(min: 0.5, max: 1.0),
             brightness: .random(min: 0.7, max: 1.0),
             alpha: 1.0)
  }
}
