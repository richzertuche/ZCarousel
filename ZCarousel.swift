//
//  Carrousel.swift
//  ZCScrollMenu
//
//  Created by Ricardo Zertuche on 2/8/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

import UIKit

@objc protocol ZCarouselDelegate {
    func ZCarouselShowingIndex(scrollview:ZCarousel, index: Int)
}

class ZCarousel: UIScrollView, UIScrollViewDelegate {
    
    var ZCButtons:[UIButton] = []
    var ZCImages:[UIImageView] = []
    private var buttons:[UIButton] = []
    private var images:[UIImageView] = []
    private var page: CGFloat!
    private var isImage: Bool!
    private var originalArrayCount: Int!
    
    var ZCdelegate: ZCarouselDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        super.pagingEnabled = true
        super.contentSize = CGSize(width: 0, height: self.frame.height)
        super.clipsToBounds = false
        super.delegate = self
        super.showsHorizontalScrollIndicator = false
        isImage = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.pagingEnabled = true
        super.contentSize = CGSize(width: 0, height: self.frame.height)
        super.clipsToBounds = false
        super.delegate = self
        super.showsHorizontalScrollIndicator = false
        isImage = false
    }
    
    func addButtons(titles: [String]){
        originalArrayCount = titles.count
        //1
        var buttonFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.height)

        //a
        var finalButtons = titles
        //b
        var firstItem       = titles[0]
        var secondItem      = titles[1]
        var almostLastItem  = titles[titles.count-2]
        var lastItem        = titles.last
        //c
        finalButtons.insert(almostLastItem, atIndex: 0)
        finalButtons.insert(lastItem!, atIndex: 1)
        finalButtons.append(firstItem)
        finalButtons.append(secondItem)
        
        //2
        for i in 0..<finalButtons.count {
            //3
            //println("\(i) - \(finalButtons[i])")
            if i != 0 {
               buttonFrame = CGRectMake(buttonFrame.origin.x+buttonFrame.width,
                                        self.frame.height/2-self.frame.height/2,
                                        self.frame.size.width,
                                        self.frame.height)
            }
            //4
            var button = UIButton(frame: buttonFrame)
            button.setTitle(finalButtons[i], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            //6
            self.addSubview(button)
            self.contentSize.width = super.contentSize.width+button.frame.width
            
            buttons.append(button)
        }
        
        let middleButton = buttons[(buttons.count/2)]
        self.scrollRectToVisible(middleButton.frame, animated: false)
    }
    
    func addImages(imagesToUSe: [String]){
        originalArrayCount = imagesToUSe.count
        //1
        var imageViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.height)
        
        //a
        var finalImageViews = imagesToUSe
        //b
        var firstItem       = imagesToUSe[0]
        var secondItem      = imagesToUSe[1]
        var almostLastItem  = imagesToUSe[imagesToUSe.count-2]
        var lastItem        = imagesToUSe.last
        //c
        finalImageViews.insert(almostLastItem, atIndex: 0)
        finalImageViews.insert(lastItem!, atIndex: 1)
        finalImageViews.append(firstItem)
        finalImageViews.append(secondItem)
        
        //2
        for i in 0..<finalImageViews.count {
            var image = UIImage(named: finalImageViews[i])
            //3
            //println("\(i) - \(finalButtons[i])")
            if i != 0 {
                imageViewFrame = CGRectMake(imageViewFrame.origin.x+imageViewFrame.width,
                    self.frame.height/2-self.frame.height/2,
                    self.frame.size.width,
                    self.frame.height)
            }
            //4
            var imageView = UIImageView(frame: imageViewFrame)
            imageView.image = image
            //6
            self.addSubview(imageView)
            self.contentSize.width = super.contentSize.width+imageView.frame.width
            
            images.append(imageView)
        }
        
        isImage = true
        let middleImage = images[(images.count/2)]
        self.scrollRectToVisible(middleImage.frame, animated: false)
    }
    
    func scrollViewDidScroll(scrollView: ZCarousel) {
        //1
        page = scrollView.contentOffset.x / self.frame.width
        //2
        var objectsCount: CGFloat!
        var objects = []
        if isImage==true {
            objectsCount = CGFloat(images.count)
            objects = images
        }
        else {
            objectsCount = CGFloat(buttons.count)
            objects = buttons
        }
        //3
        if page <= 1{
            let scrollToObject: AnyObject = objects[Int(objectsCount-3)]
            self.scrollRectToVisible(scrollToObject.frame, animated: false)
        }
        if page >= objectsCount-2{
            let scrollToObject: AnyObject = objects[2]
            self.scrollRectToVisible(scrollToObject.frame, animated: false)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: ZCarousel) {
        //1
        page = scrollView.contentOffset.x / self.frame.width
        //2
        var pageInt = Int(round(Float(page)))-2
        
        if pageInt == -1 {
            pageInt = pageInt + originalArrayCount
        }
        
        if pageInt == originalArrayCount {
            pageInt = 0
        }
        
        //println(pageInt)
        self.ZCdelegate?.ZCarouselShowingIndex(self, index: pageInt)
    }
}
