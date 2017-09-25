//
//  Carrousel.swift
//  ZCScrollMenu
//
//  Created by Ricardo Zertuche on 2/8/15.
//  Copyright (c) 2015 Ricardo Zertuche. All rights reserved.
//

import UIKit

@objc protocol ZCarouselDelegate {
    func ZCarouselShowingIndex(_ scrollView:ZCarousel, index: Int)
}

class ZCarousel: UIScrollView, UIScrollViewDelegate {
    
    var ZCButtons = [UIButton]()
    var ZCImages = [UIImageView]()
    private var buttons = [UIButton]()
    private var images = [UIImageView]()
    private var page: CGFloat?
    private var isImage: Bool?
    private var originalArrayCount: Int?
    
    var ZCdelegate: ZCarouselDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initalizeScrollViewProperties()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.initalizeScrollViewProperties()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initalizeScrollViewProperties()
    }
    
    func initalizeScrollViewProperties(){
        super.isPagingEnabled = true
        super.contentSize = CGSize(width: 0, height: self.frame.height)
        super.clipsToBounds = false
        super.delegate = self
        super.showsHorizontalScrollIndicator = false
        isImage = false
    }
    
    func addButtons(_ titles: [String]){
        originalArrayCount = titles.count
        //1
        var buttonFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.height)
        
        //a
        var finalButtons = titles
        //b
        
        if titles.count > 2 {
            //c
            finalButtons.insert(titles[titles.count-2], at: 0)
            
            if let lastItem = titles.last {
                finalButtons.insert(lastItem, at: 1)
            }
            
            finalButtons.append(titles[0])
            finalButtons.append(titles[1])
        }
        
        //2
        for i in 0..<finalButtons.count {
            //3
            //println("\(i) - \(finalButtons[i])")
            if i != 0 {
                buttonFrame = CGRect(x: buttonFrame.origin.x+buttonFrame.width, y: self.frame.height/2-self.frame.height/2, width: self.frame.width, height: self.frame.height)
            }
            //4
            let button = UIButton(frame: buttonFrame)
            button.setTitle(finalButtons[i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            //6
            self.addSubview(button)
            self.contentSize.width = super.contentSize.width+button.frame.width
            
            buttons.append(button)
        }
        
        let middleButton = buttons[(buttons.count/2)]
        self.scrollRectToVisible(middleButton.frame, animated: false)
    }
    
    func addImages(_ imagesToUse: [String]){
        originalArrayCount = imagesToUse.count
        //1
        var imageViewFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.height)
        
        //a
        var finalImageViews = imagesToUse
        //b
        
        if imagesToUse.count > 2 {
            //c
            finalImageViews.insert(imagesToUse[imagesToUse.count-2], at: 0)
            
            if let lastItem = imagesToUse.last {
                finalImageViews.insert(lastItem, at: 1)
            }
            
            finalImageViews.append(imagesToUse[0])
            finalImageViews.append(imagesToUse[1])
        }
        
        //2
        for i in 0..<finalImageViews.count {
            let image = UIImage(named: finalImageViews[i])
            //3
            //println("\(i) - \(finalButtons[i])")
            if i != 0 {
                imageViewFrame = CGRect(x: imageViewFrame.origin.x+imageViewFrame.width, y: self.frame.height/2-self.frame.height/2, width: self.frame.size.width, height: self.frame.height)
            }
            //4
            let imageView = UIImageView(frame: imageViewFrame)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1
        page = scrollView.contentOffset.x / self.frame.width
        //2
        var objectCount : CGFloat = 0
        var objects = [AnyObject]()
        if isImage==true {
            objectCount = CGFloat(images.count)
            objects = images
        }
        else {
            objectCount = CGFloat(buttons.count)
            objects = buttons
        }
        
        if let page = page {
            //3
            if page <= 1{
                let scrollToObject: AnyObject = objects[Int(objectCount-3)]
                self.scrollRectToVisible(scrollToObject.frame, animated: false)
            }
            if page >= objectCount-2{
                let scrollToObject: AnyObject = objects[2]
                self.scrollRectToVisible(scrollToObject.frame, animated: false)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //1
        page = scrollView.contentOffset.x / self.frame.width
        //2
        
        if let page = page, let originalArrayCount = originalArrayCount {
            var pageInt = Int(round(Float(page)))-2
            
            if pageInt == -1 {
                pageInt = pageInt + originalArrayCount
            }
            
            if pageInt == originalArrayCount {
                pageInt = 0
            }
            
            self.ZCdelegate?.ZCarouselShowingIndex(self, index: pageInt)
        }
    }
}
