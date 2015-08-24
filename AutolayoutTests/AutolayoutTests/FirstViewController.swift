//
//  FirstViewController.swift
//  AutolayoutTests
//
//  Created by Ulrich Winkler on 20/08/15.
//  Copyright (c) 2015 Kodira. All rights reserved.
//

import UIKit
import commons


let redColor = UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 0.5)
let orangeColor = UIColor(hue: 0.1, saturation: 1, brightness: 1, alpha: 0.5)


class RightLeftLabel : UIView {
    
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    var indent : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [
            "left" : leftLabel,
            "right" : rightLabel
        ]
        
        self.addSubviewDict(views)

        //
        // Label layout
        //
        
        rightLabel.numberOfLines = 1
        rightLabel.textAlignment = NSTextAlignment.Right
        rightLabel.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)

        
        leftLabel.numberOfLines = 11
        leftLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        
        
        self.addConstraints("H:[left]-(>=5)-[right]-|", views: views)
        self.addConstraints("V:|-[left(>=13)]-(>=5)-|", views: views)
        self.addConstraints("V:|-[right(>=13)]-(>=5)-|", views: views)
        
        
        rightLabel.backgroundColor = redColor
        
        leftLabel.backgroundColor = orangeColor
        
        
        //
        // Indent Constraint
        //
        self.indent = NSLayoutConstraint(item:leftLabel, attribute:NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 8)
        self.indent?.priority = 1000
        
        self.addConstraint(indent!)
        

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class FirstViewController: UIViewController {

    let slider1 = UISlider()
    let slider2 = UISlider()
    let indentSlider = UISlider()
    
    let label = RightLeftLabel(frame: CGRectZero)

    let label2 = RightLeftLabel(frame: CGRectZero)

    
    let lorem = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let views = [
            "label" : label,
            "label2" : label2,
            "slider1" : slider1,
            "slider2" : slider2,
            "indentSlider" : indentSlider

        ]

        self.view.addSubviewDict(views)

        
        //
        // Slider layout
        //
        self.view.addConstraints("H:|-[slider1]-|", views: views)
        self.view.addConstraints("H:|-[slider2]-|", views: views)
        self.view.addConstraints("H:|-[indentSlider]-|", views: views)

        
        //
        
        
        self.view.addConstraints("H:|[label]|", views: views)
        self.view.addConstraints("H:|[label2]|", views: views)
        self.view.addConstraints("V:|-(100)-[label]-[label2]", views: views)

    
        slider2.tintColor = redColor
        slider1.tintColor = orangeColor


        self.view.addConstraints("V:[slider1]-(100)-|", views: views)
        self.view.addConstraints("V:[slider2]-(140)-|", views: views)
        self.view.addConstraints("V:[indentSlider]-(180)-|", views: views)
        
        
        
        slider1.addTarget(self, action: "sliderChanged", forControlEvents: UIControlEvents.ValueChanged)
        slider2.addTarget(self, action: "sliderChanged", forControlEvents: UIControlEvents.ValueChanged)

        indentSlider.addTarget(self, action: "indentChanged", forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func sliderChanged () {
        self.label.leftLabel.text = ipsum(slider1.value)
        self.label2.leftLabel.text = ipsum(slider1.value)

        self.label.rightLabel.text = ipsum(slider2.value)
        self.label2.rightLabel.text = ipsum(slider2.value)

        
    }
    
    func indentChanged() {
        self.label.indent?.constant = CGFloat(self.indentSlider.value) * 100
        self.label2.indent?.constant = CGFloat(self.indentSlider.value) * 100

    }
    
    func ipsum(percent : Float) -> String {
        let length = lorem.length
        let size = Int(Float(length) * percent)
        let ret = lorem.substring(0, endIndex: size)
        return ret;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

