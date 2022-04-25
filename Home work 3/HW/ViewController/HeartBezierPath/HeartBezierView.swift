//
//  HeartBezierView.swift
//  HW
//
//  Created by Денис Шишкин on 31.03.2022.
//

import UIKit

@IBDesignable class HeartBezierView: UIView {
  
  @IBInspectable var filled: Bool = true
  @IBInspectable var strokeWidth: CGFloat = 2.0
  @IBInspectable var strokeColor: UIColor?
  
  override func draw(_ rect: CGRect) {
    let bezierPath = UIBezierPath(heartIn: self.bounds)
    
    if self.strokeColor != nil {
      self.strokeColor!.setStroke()
    } else {
      self.tintColor.setStroke()
    }
    
    bezierPath.lineWidth = self.strokeWidth
    bezierPath.stroke()
    
    if self.filled {
      self.tintColor.setFill()
      bezierPath.fill()
    }
  }
  
}

