//
//  UIImage+Utility.swift
//  Citygo
//
//  Created by venkata baisani on 27/10/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

  func withBackground(color: UIColor) -> UIImage? {
    var image: UIImage?
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(imageRect)
      draw(in: imageRect, blendMode: .normal, alpha: 1.0)
      image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return image
    }
    return nil
  }
 func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
      // Determine the scale factor that preserves aspect ratio
      let widthRatio = targetSize.width / size.width
      let heightRatio = targetSize.height / size.height
      let scaleFactor = min(widthRatio, heightRatio)
      // Compute the new image size that preserves aspect ratio
      let scaledImageSize = CGSize(
          width: size.width * scaleFactor,
          height: size.height * scaleFactor
      )
      // Draw and return the resized UIImage
      let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
      let scaledImage = renderer.image { _ in
          self.draw(in: CGRect(
              origin: .zero,
              size: scaledImageSize
          ))
      }
      return scaledImage
  }
}
