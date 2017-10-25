//
//  ViewController.swift
//  ZCarousel
//
//  Created by Ricardo Zertuche on 2/11/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZCarouselDelegate {

    var menu: ZCarousel?
    var images: ZCarousel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            y: 100,
            width: (self.view.frame.size.width/5)*3,
            height: 50))
        menu?.ZCdelegate = self
        menu?.addButtons(["iOS 8 by Tutorials", "Swift by Tutorials", "Core Data by Tutorials", "WatchKit by Tutorials"])
        
        self.view.addSubview(menu!)
        
        images = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            y: 200,
            width: (self.view.frame.size.width/5)*3,
            height: 150))
        images?.ZCdelegate = self
        
        images?.addImages(["1", "2", "3"])
        
        if let images = images {
            self.view.addSubview(images)
        }
        
    }
    
    func ZCarouselShowingIndex(_ scrollView: ZCarousel, index: Int) {
        if scrollView == menu {
            print("Showing Button at index \(index)")
        }
        else if scrollView == images {
            print("Showing Image at index \(index)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

