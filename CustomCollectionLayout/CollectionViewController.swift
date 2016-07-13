import UIKit


class InventoryController: UICollectionViewController {
    
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    let alpha = CGFloat(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.registerNib(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView?.registerNib(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    
    // MARK - UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfRows(collectionView)
    }
    
    func numberOfRows(collectionView: UICollectionView) -> Int {
        return 50 // 49 rows + header
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfColumns(collectionView, numberOfItemsInSection: section)
    }
    
    func numberOfColumns(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = MultiColumnIndexPath(indexPath: indexPath)
        
        if cell.isOriginCell() {
            return initializeOriginCell(cell)
        } else if (cell.isHeaderColumn()) {
            return initializeHeaderColumnCell(cell)
        } else if (cell.isHeaderRow()) {
            return initializeHeaderRowCell(cell)
        } else {
            return initializeDataCell(cell)
        }
    }
    
    func initializeOriginCell(cell: MultiColumnIndexPath) -> MultiColumnViewCell {
        let dateCell: MultiColumnViewCell = collectionView?.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: cell.indexPath) as! MultiColumnViewCell
        
        dateCell.contentLabel.text = "Date"
        
        return dateCell
    }
    
    func initializeHeaderColumnCell(cell: MultiColumnIndexPath) -> MultiColumnViewCell {
        let contentCell : MultiColumnViewCell = collectionView?.dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: cell.indexPath) as! MultiColumnViewCell
        
        contentCell.contentLabel.text = String(cell.row)
        _setAlternatingCellBackground(cell, contentCell: contentCell)
        
        return contentCell
    }
    
    func _setAlternatingCellBackground(cellIndex: MultiColumnIndexPath, contentCell: MultiColumnViewCell) {
        if cellIndex.row % 2 != 0 {
            contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: alpha)
        } else {
            contentCell.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func initializeHeaderRowCell(cell: MultiColumnIndexPath) -> MultiColumnViewCell {
        let dateCell : MultiColumnViewCell = collectionView?.dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: cell.indexPath) as! MultiColumnViewCell
        
        dateCell.contentLabel.text = String(cell.column)
        
        _setAlternatingCellBackground(cell, contentCell: dateCell)
        
        return dateCell
    }
    
    func initializeDataCell(cell: MultiColumnIndexPath) -> MultiColumnViewCell {
        let contentCell : MultiColumnViewCell = collectionView?.dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: cell.indexPath) as! MultiColumnViewCell
        
        contentCell.contentLabel.text = "Content"
        
        _setAlternatingCellBackground(cell, contentCell: contentCell)
        return contentCell
    }
}