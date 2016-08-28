//
//  Image.swift
//  Sahayyam
//
//  Created by Aman on 8/14/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {

    func imageFromUrl(convertedImageString:String) {
    
        if let url = NSURL(string: convertedImageString){
            Alamofire.request(.GET, url).response { (request, response, data, error) in
                self.image = UIImage(data: data!, scale:0)
            }
        }
    }

//    func imagefromUrl(convertedImageString:String) -> UIImage{
//        let url = NSURL(string: convertedImageString)
//        var image = UIImage()
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            let data = NSData(contentsOfURL: url!)  // make sure your image in this url does exist,                                   otherwise unwrap in a if let check
//            dispatch_async(dispatch_get_main_queue(), {
//                image = UIImage(data: data!)!
//            });
//        }
//        return image
//    }

}
