import UIKit

class CalendarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var calendarCollection: UICollectionView!
    let cellMargin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         calendarCollection.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCell")
    }
    
    
}

extension CalendarVC {

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // "Cell" はストーリーボードで設定したセルのID
        let calendarCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell",
                                               for: indexPath)

        if let calendarCell = calendarCell as? CalendarCell {
            calendarCell.setupCell(date: "\(indexPath.row)")
        }
        return calendarCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 31
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横方向のスペース調整
        let horizonalCount:CGFloat = 6
        let horizonalSpace:CGFloat = self.calendarCollection.frame.height / horizonalCount

        let verticalCount:CGFloat = 7
        let verticalSpace:CGFloat = self.calendarCollection.frame.width / verticalCount
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: verticalSpace, height: horizonalSpace)
    }
    // セル間のスペースについて
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
}
