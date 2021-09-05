import UIKit

@IBDesignable

class CircleView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 4, y: 4, width: rect.width - 8, height: rect.height - 8))
        UIColor(named: "BrandOrange")?.setFill()
      path.fill()
    }
}
