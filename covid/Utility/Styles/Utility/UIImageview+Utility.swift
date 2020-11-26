//
//  UIImageview+Utility.swift
//  Citygo
//
//  Created by venkata baisani on 29/10/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func applyCornerRadius() {
        let image = self.image
        let targetSize = CGSize(width: self.frame.size.width * 4, height: self.frame.size.height * 5)
        let scaledImage = image?.scalePreservingAspectRatio(targetSize: targetSize)
        self.image = scaledImage
        self.cornerRadiusV = 70
        self.contentMode = .scaleToFill
    }
    func removeCornerRadius() {
        let image = self.image
        let targetSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        let scaledImage = image?.scalePreservingAspectRatio(targetSize: targetSize)
        self.image = scaledImage
        self.cornerRadiusV = 0
        self.contentMode = .scaleAspectFit
    }
}
