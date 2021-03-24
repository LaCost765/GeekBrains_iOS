//
//  RoundedImageView.swift
//  GeekMobile
//
//  Created by Egor on 16.03.2021.
//

import UIKit

@IBDesignable class RoundedImageView: UIView {

    var imageView: UIImageView = UIImageView()
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            imageView.layer.masksToBounds = cornerRadius > 0
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 4 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 4, height: 4) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageView.image = image
            imageView.setNeedsDisplay()
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(imageView)
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
    

}
