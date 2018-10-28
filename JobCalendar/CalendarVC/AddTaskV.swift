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

}

protocol AddTaskVManager {
    func setAddTaskV(superView: UIView)
}

extension AddTaskVManager {
    
    func setAddTaskV(superView: UIView) {
        let addTaskV = AddTaskV(frame: CGRect(x: 0.0, y: 0.0, width: superView.frame.width, height: superView.frame.height))
        superView.addSubview(addTaskV)
    }
    
}
