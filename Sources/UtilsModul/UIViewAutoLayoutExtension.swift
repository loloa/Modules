//
//  UIViewAutoLayoutExtension.swift
//  AutolayoutDemo
//
//  Created by Stephen Yao on 8/07/2015.
//  Converted to Swift 2.0 by Misha Koval
//  Copyright (c) 2015 SilverBear. All rights reserved.
//
import UIKit

public extension NSLayoutConstraint {
    @objc class func constraintsWithVisualFormat(_ visualFormat: String, views: [String : AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
    }
    
    @objc class func constraintsWithVisualFormat(_ visualFormat: String,  metrics: [String : AnyObject]?, views: [String : AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: views)
    }
    
    @objc class func constraintsWithVisualFormat(_ visualFormat: String,  options: NSLayoutConstraint.FormatOptions, views: [String : AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: options, metrics: nil, views: views)
    }
}

public extension NSLayoutConstraint {
    /**
     Change multiplier constraint

     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
    */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

public extension UIView {
    
    // Given an item, stretches the width and height of the view to the toItem.
    @discardableResult
    @objc func  stretchToBoundsOfSuperView() -> [NSLayoutConstraint] {
        let constraints =
        NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["item" : self]) +
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[item]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["item" : self])
        if let superview = self.superview {
            superview.addConstraints(constraints)
        }
        return constraints 
    }
    
    @discardableResult
    @objc func alignTopTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func alignBottomTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func alignLeftTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func alignRightTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func centerHorizontallyTo(_ toItem: UIView) -> [NSLayoutConstraint] {
        return self.centerHorizontallyTo(toItem, padding: 0)
    }
    
    @discardableResult
    @objc func centerHorizontallyTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func centerVerticallyTo(_ toItem: UIView) -> [NSLayoutConstraint] {
        return self.centerVerticallyTo(toItem, padding: 0)
    }
    
    
    @objc func centerHorizontallyInSuperView()
    {
        _ = self.centerHorizontallyTo(self.superview!)
    }
    
    
    @objc func centerVerticallyInSuperView()
    {
        _ = self.centerVerticallyTo(self.superview!)
    }
    
    @discardableResult
    @objc func centerVerticallyTo(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: padding)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func stretchToWidthOfSuperView() -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func stretchToWidthOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[item]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func stretchToHeightOfSuperView() -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[item]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func stretchToHeightOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[item]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainToTopOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[item]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainToLeftOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[item]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainToBottomOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[item]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainToBottomOfSuperView(_ padding: CGFloat, priority: UILayoutPriority) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[item]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        constraints.first!.priority = priority
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainToRightOfSuperView(_ padding: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[item]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["padding" : padding], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainWidthToItem(_ toItem: UIView) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[item(==otherItem)]", metrics: nil, views: ["item" : self, "otherItem" : toItem])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainHeightToItem(_ toItem: UIView) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[item(==otherItem)]", metrics: nil, views: ["item" : self, "otherItem" : toItem])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainSizeToItem(_ toItem: UIView) -> [NSLayoutConstraint] {
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[item(==otherItem)]", metrics: nil, views: ["item" : self, "otherItem" : toItem])
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[item(==otherItem)]", metrics: nil, views: ["item" : self, "otherItem" : toItem])
        let bothConstraints = widthConstraints + heightConstraints
        self.superview?.addConstraints(bothConstraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainWidth(_ width: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[item(width)]", metrics: ["width" : width], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainHeight(_ height: CGFloat) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[item(height)]", metrics: ["height" : height], views: ["item" : self])
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    @objc func constrainWidthTo(_ toItem: UIView, multiplyer: CGFloat = 1) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.width, multiplier: multiplyer, constant: 0)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func constrainHeightTo(_ toItem: UIView, multiplyer: CGFloat = 1) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.height, multiplier: multiplyer, constant: 0)
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func anchorToBottom(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func anchorToRight(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func anchorToTop(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: -padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func anchorToLeft(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint] {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.left , multiplier: 1.0, constant: -padding)
        
        self.superview?.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func stretchHeight(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint]
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: padding)
        
        self.addConstraint(constraint)
        return [constraint]
    }
    
    @discardableResult
    @objc func stretchWidth(_ toItem: UIView, padding: CGFloat) -> [NSLayoutConstraint]
    {
        let constraint:NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: padding)
        
        self.addConstraint(constraint)
        return [constraint]
    }
}
