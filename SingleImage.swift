//
//  SingleImage.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//
    

    
import UIKit
    
extension UIImage {
        
    func resizeWith(width: CGFloat , height : CGFloat) -> UIImage? {
            let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
            imageView.contentMode = .ScaleAspectFit
            imageView.image = self
            UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            imageView.layer.renderInContext(context)
            guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
            UIGraphicsEndImageContext()
            return result
    }

}



