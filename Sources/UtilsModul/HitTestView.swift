//
//  File.swift
//  
//
//  Created by Yoav Dror on 22/07/2020.
//

import Foundation
import UIKit


public class HitTestView: UIView{

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        let uiview = super.hitTest(point, with: event)

        print("hittest", uiview as Any)
        return overlapHitTest(point: point, withEvent: event)
    }
}

extension UIView {
    func overlapHitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        // 1
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha == 0 {
            return nil
        }
        //2
        var hitView: UIView? = self
        if !self.point(inside: point, with: event) {
            if self.clipsToBounds {
                return nil
            } else {
                hitView = nil
            }
        }
        //3
        for subview in self.subviews.reversed() {
            let insideSubview = self.convert(point, to: subview)
            if subview is UISegmentedControl {
                if let v = subview.hitTest(insideSubview, with: event){
                    return v
                }
            }

            if let sview = subview.overlapHitTest(point: insideSubview, withEvent: event) {
                return sview
            }
        }
        return hitView
    }
}
