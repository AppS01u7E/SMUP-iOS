//
//  UIViewExt.swift
//  test
//
//  Created by 최형우 on 2022/01/09.
//

import UIKit

extension UIView{
    func addSubViews(_ subView: UIView...){
        subView.forEach(addSubview(_:))
    }
    func setDashedBorder(color: UIColor){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        layer.addSublayer(shapeLayer)
    }
    func applyGradient(
        colors: [CGColor],
        locations: [NSNumber],
        startPoint: CGPoint,
        endPoint: CGPoint
    ){
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
