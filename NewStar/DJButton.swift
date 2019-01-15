//
//  DJButton.swift
//  DJButton
//
//  Created by dajia on 2017/8/9.
//  Copyright © 2017年 shile. All rights reserved.
//

import UIKit

public enum ButtonLayoutStyle: Int {
    case defaultLayout
    case leftTitleImage
    case upTitleImage
    case upImageTitle
}

@IBDesignable
public class DJButton: UIButton {
    
    @IBInspectable
    var layoutStyleRawValue: Int = ButtonLayoutStyle.defaultLayout.rawValue
    @IBInspectable
    public var gap: CGFloat = 0
    
    private var imageSize: CGSize = CGSize.zero
    private var titleSize: CGSize = CGSize.zero
    
    public convenience init(layoutStyle: ButtonLayoutStyle) {
        self.init(frame: CGRect.zero)
        self.layoutStyleRawValue = layoutStyle.rawValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if let size = self.imageView?.frame.size {
            imageSize = size
        }
        
        if let size = self.titleLabel?.frame.size {
            titleSize = size
        }
        
        switch layoutStyleRawValue {
        case ButtonLayoutStyle.leftTitleImage.rawValue:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width - gap, bottom: 0, right: imageSize.width)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width, bottom: 0, right: -titleSize.width - gap)
        case ButtonLayoutStyle.upTitleImage.rawValue:
            self.titleEdgeInsets = UIEdgeInsets(top: -imageSize.height - gap, left: -imageSize.width, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -titleSize.height - gap, right: -titleSize.width)
        case ButtonLayoutStyle.upImageTitle.rawValue:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - gap, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - gap, left: 0, bottom: 0, right: -titleSize.width)
        default:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -gap)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -gap, bottom: 0, right: 0)
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        switch layoutStyleRawValue {
        case ButtonLayoutStyle.leftTitleImage.rawValue, ButtonLayoutStyle.defaultLayout.rawValue:
            let superSize = super.intrinsicContentSize
            return CGSize(width: superSize.width + gap, height: superSize.height)
        default:
            let superSize = super.intrinsicContentSize
            let height = min(imageSize.height, titleSize.height)
            return CGSize(width: superSize.width, height: superSize.height + gap + height)
        }
    }
}
