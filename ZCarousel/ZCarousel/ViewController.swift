//
//  ViewController.swift
//  ZCarousel
//
//  Created by Ricardo Zertuche on 2/11/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZCarouselDelegate {

    var menu: ZCarousel!
    var images: ZCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            y: 100,
            width: (self.view.frame.size.width/5)*3,
            height: 50))
        menu.ZCdelegate = self
        menu.addButtons(["iOS 8 by Tutorials", "Swift by Tutorials", "Core Data by Tutorials", "WatchKit by Tutorials"])
        
        self.view.addSubview(menu!)
        
        images = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            y: 200,
            width: (self.view.frame.size.width/5)*3,
            height: 150))
        images.ZCdelegate = self
        
        images.addImages(["1", "2", "3"])
        
        self.view.addSubview(images)
        
    }
    
    func ZCarouselShowingIndex(scrollview: ZCarousel, index: Int) {
        if scrollview == menu {
            println("Showing Button at index \(index)")
        }
        else if scrollview == images {
            println("Showing Image at index \(index)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

