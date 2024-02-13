//
//  KHQRTriangleView.swift
//  WingKHQRTest
//
//  Created by Ouch Kemvanra on 2/6/24.
//

import UIKit

class KHQRTriangleView: UIView {
   
    var color: UIColor
   
    var firstPoint: CGPoint = .init(x: 0, y: 0)
    var secondPoint: CGPoint = .init(x: 1, y: 0)
    var thirdPoint: CGPoint = .init(x: 1, y: 1)

    init(color: UIColor){
        self.color = color
        super.init(frame: .zero)
    }
    
    init(first: CGPoint, second: CGPoint, third: CGPoint, color: UIColor){
        self.firstPoint = first
        self.secondPoint = second
        self.thirdPoint = third
        
        self.color = color
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: self.firstPoint.x * rect.width, y: self.firstPoint.y * rect.height))
        aPath.addLine(to: CGPoint(x: self.secondPoint.x * rect.width, y: self.secondPoint.y * rect.height))
        aPath.addLine(to: CGPoint(x: self.thirdPoint.x * rect.width, y: self.thirdPoint.y * rect.height))
        aPath.close()
        self.color.set()
        self.backgroundColor = .clear
        aPath.fill()
   }

}
