import UIKit

class AddTaskV: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.nibInit()
    }
    
    fileprivate func nibInit() {
        // File's OwnerをXibViewにしたので ownerはself になる
        guard let view = UINib(nibName: "AddTaskV", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    @IBAction func outSideTap(_ sender: Any) {
        self.superview?.removeFromSuperview()
    }
    
}

protocol AddTaskVManager {
    func setAddTaskV(superView: UIView)
}

extension AddTaskVManager {
    
    func setAddTaskV(superView: UIView) {
        let transparentBackground = UIView(frame: UIScreen.main.bounds)
        transparentBackground.backgroundColor = UIColor(white: 0.0, alpha: 0.54)
        UIApplication.shared.keyWindow!.addSubview(transparentBackground)
        let addTaskV = AddTaskV(frame: CGRect(x: 0.0, y: 0.0, width: superView.frame.width, height: superView.frame.height))
        transparentBackground.addSubview(addTaskV)
        UIApplication.shared.keyWindow!.bringSubviewToFront(transparentBackground)
        superView.bringSubviewToFront(transparentBackground)
    }
    
}
