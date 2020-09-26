//
//  AVTabBar.swift
//  AVTabBar
//
//  Created by Umesh on 26/09/20.
//

import UIKit

@IBDesignable
@objcMembers open class AVTabBar: UITabBar {
    
    /**
     * HeightRatio will cross with screen height to calculate tabbar height.
     * Default value will change in different enviroments iphone, iphoneX, iPad, etc.
     */
    @IBInspectable public var heightRatio: CGFloat = CGFloat(AVTabBarHeightRatios.bestSize.rawValue) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * CornerRadius of top edges for TabBar container.
     * Default value will change in different enviroments iphone, iphoneX, iPad, etc.
     */
    @IBInspectable public var topCornerRadious: CGFloat = AVTabBarHeightRatios.bestSize.cornerRadius(){
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * CornerRadius of bottom edges for Tabbar container.
     * Default value will change in different enviroments iphone, iphoneX, iPad, etc.
     */
    @IBInspectable public var bottomCornerRadious: CGFloat = AVTabBarHeightRatios.bestSize.cornerRadius(){
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * Change the background color of tabbar.
     */
    @IBInspectable public var tabbarBackgroundColor: UIColor = .white  {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * Shadow color of tabbar
     */
    @IBInspectable public var shadowColor: UIColor = UIColor(white: 0, alpha: 0.2)  {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * HeightRatio will cross with screen height to calculate tabbar height.
     * Default value will change in different enviroments iphone, iphoneX, iPad, etc.
     */
    @IBInspectable public var shadowRadius: CGFloat = 10.0  {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * Selected font of tabbar titles
     */
    public var selectedFont: UIFont = .systemFont(ofSize: 12)
    
    /**
     * Set font name as `string` name.
     */
    @IBInspectable public var fontName: String = "Ubuntu" {
        didSet {
            self.selectedFont = UIFont(name: fontName, size: 12) ?? .systemFont(ofSize: 12)
            layoutIfNeeded()
        }
    }
    
    /**
     * Selected Color of Tab bar Item.
     */
    @IBInspectable public var selectedColor: UIColor = .blue  {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * Not Selected Color of Tab bar Item
     */
    @IBInspectable public var unSelectedColor: UIColor = .blue  {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * Hide is tabbar title text.
     */
    @IBInspectable public var isShowTitle: Bool = true {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /**
     * LabelOffset is the space between tab's icon and the title lable
     */
    @IBInspectable public var labelOffset: CGFloat = 0.0  {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override public func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        items?.forEach({ (item) in
            item.setTitleTextAttributes([NSAttributedString.Key.font: selectedFont], for: .normal)
            item.setTitleTextAttributes([NSAttributedString.Key.font: selectedFont,NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
            item.setTitleTextAttributes([NSAttributedString.Key.font: selectedFont,NSAttributedString.Key.foregroundColor: unSelectedColor], for: .normal)
            setupTabBarLabel(barItem: item, hidden: isShowTitle)
        })
        unselectedItemTintColor = unSelectedColor
        tintColor = selectedColor
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: labelOffset)
    }
    
    override public func draw(_ rect: CGRect) {
        addBackgroundShape()
    }
    
    private var shapeLayer: CALayer?
    public var containerInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private func addBackgroundShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = tabbarBackgroundColor.cgColor
        shapeLayer.shadowColor = shadowColor.cgColor
        shapeLayer.shadowRadius = shadowRadius
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowOpacity = 1.0
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createPath() -> CGPath {
        
        //Properties
        let path = UIBezierPath()
        let ratioConvertion = UIScreen.main.bounds.height * heightRatio
        let height = ratioConvertion > 0 && heightRatio < 1.0 ? ratioConvertion : UIScreen.main.bounds.height * CGFloat(AVTabBarHeightRatios.bestSize.rawValue)
        
        //Corners
        let firstCorner = CGPoint(x: containerInsets.left, y: containerInsets.top)
        let secondCorner = CGPoint(x: containerInsets.left, y: height - containerInsets.bottom)
        let thirdCorner = CGPoint(x: bounds.width - containerInsets.right, y: height - containerInsets.bottom)
        let fourthCorner = CGPoint(x: bounds.width - containerInsets.right, y: containerInsets.top)
        
        //Curve Points
        let startPoint = CGPoint(x: firstCorner.x + topCornerRadious, y: firstCorner.y)
        let firstPoint = CGPoint(x: firstCorner.x, y:  firstCorner.y + topCornerRadious)
        let secondCurvePoint1 = CGPoint(x: secondCorner.x, y: secondCorner.y - bottomCornerRadious)
        let secondCurvePoint2 = CGPoint(x: secondCorner.x + bottomCornerRadious, y: secondCorner.y)
        let thirdCurvePoint1 = CGPoint(x: thirdCorner.x - bottomCornerRadious, y: thirdCorner.y)
        let thirdCurvePoint2 = CGPoint(x: thirdCorner.x, y: thirdCorner.y - bottomCornerRadious)
        let endCurvePoint1 = CGPoint(x: fourthCorner.x, y:  fourthCorner.y + topCornerRadious)
        let endPoint = CGPoint(x: fourthCorner.x - topCornerRadious, y: fourthCorner.y)
        
        //Draw
        path.move(to: startPoint)
        path.addQuadCurve(to: firstPoint, controlPoint: firstCorner)
        path.addLine(to: secondCurvePoint1)
        path.addQuadCurve(to: secondCurvePoint2, controlPoint: secondCorner)
        path.addLine(to: thirdCurvePoint1)
        path.addQuadCurve(to: thirdCurvePoint2, controlPoint: thirdCorner)
        path.addLine(to: endCurvePoint1)
        path.addQuadCurve(to: endPoint, controlPoint: fourthCorner)
        path.addLine(to: startPoint)
        path.close()
        
        return path.cgPath
    }
    
    private func setupTabBarLabel(barItem: UITabBarItem, hidden: Bool) {
        if let itemView = (barItem.value(forKey: "view") as? UIView) {
            if let titleLabel = itemView.subviews.last {
                titleLabel.isHidden = !hidden
            }
        }
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        let ratioConvertion = UIScreen.main.bounds.height * heightRatio
        let height = ratioConvertion > 0 && heightRatio < 1.0 ? ratioConvertion : UIScreen.main.bounds.height * CGFloat(AVTabBarHeightRatios.bestSize.rawValue)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = height
        return sizeThatFits
    }
}
