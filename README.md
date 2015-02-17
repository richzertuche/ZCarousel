# ZCarousel

<h6>Swift Carousel using a Paged UIScrollView</h6>

<p>This is a infite carousel made using a Paged UIScrollView 
and some easy maths. You can create a Carousel of UIImageViews or UIButtons.
<br>
Carousels must be of at least 3 items and as long as you want.<br></p>
<br>

[![ZCarousel](http://img.youtube.com/vi/0y5JBGjXVtU/0.jpg)](http://www.youtube.com/watch?v=0y5JBGjXVtU)

<br>
**You need to add the ZCarousel Delegate to your Controller:**

```swift
class ViewController: UIViewController, ZCarouselDelegate {
}
```
<br>
**To create a UIButtons Carousel just go on and create a ZCarousel variable with frame. 
Set thee delegate and use the method .addButtons() and add it to your view.**

```swift
var menu = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            y: 100,
            width: (self.view.frame.size.width/5)*3,
            height: 50))
menu.ZCdelegate = self
menu.addButtons(["iOS 8 by Tutorials", "Swift by Tutorials", "Core Data by Tutorials", "WatchKit by Tutorials"])
        
self.view.addSubview(menu!)
```

<br>
**To create a UIImageViews Carousel just go on and create a ZCarousel variable with frame. 
Set thee delegate and use the method .addImages() and add it to your view.**
<br>
Note: Just add the image title as a String.

```swift
images = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            y: 200,
            width: (self.view.frame.size.width/5)*3,
            height: 150))
images.ZCdelegate = self
images.addImages(["1", "2", "3"])

self.view.addSubview(images)
```
<br>
**Add the delegate function ZCarouselShowingIndex() to your controller to know the index showing.**
<br>
Note: scrollview is to know the difference between two ZCarousels and show the correct index if both are on the same controller
```swift
func ZCarouselShowingIndex(scrollview: ZCarousel, index: Int) {
        if scrollview == menu {
            println("Showing Button at index \(index)")
        }
        else if scrollview == images {
            println("Showing Image at index \(index)")
        }
 }
```

Hope you find it useful.
<br>
<p>Follow me on Twitter <a href="https://www.twitter.com/richzertuche" target="_blank"> @richzertuche</a></p>
[![Join the chat at https://gitter.im/richzertuche/ZCarousel](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/richzertuche/ZCarousel?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
