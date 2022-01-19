//
//  UIViewExt.swift
//  test
//
//  Created by 최형우 on 2022/01/09.
//

import UIKit
import SnapKit

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
    func applyUnderline(){
        let view = UIView()
        view.backgroundColor = .gray
        addSubViews(view)
        view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(self.snp.bottom)
        }
    }
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
