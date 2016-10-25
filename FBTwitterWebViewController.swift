//
//  FBTwitterWebViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/10/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class FBTwitterWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var webViewOf:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(webViewOf)
        if webViewOf == "facebook"{
            webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.facebook.com/g4ksahayyam")!))
        }else if webViewOf == "twitter"{
            webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://twitter.com/sahayyam")!))
        }else if webViewOf == "google"{
            webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://plus.google.com/110414095929861773394")!))
        }else{
           webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://in.pinterest.com/sahayyam")!))
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
