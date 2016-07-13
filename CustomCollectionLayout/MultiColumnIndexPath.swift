import Foundation


/**
 Wrapper around NSIndexPath because NSIndexPath.sections become rows under
 multiple columns, and NSIndexPath.rows are effectively columns.
 */
public class MultiColumnIndexPath {
    
    public let indexPath: NSIndexPath
    
    var column: Int {
        get {
            return indexPath.row
        }
    }
    
    var row: Int {
        get {
            return indexPath.section
        }
    }
    
    init(indexPath: NSIndexPath) {
        self.indexPath = indexPath
    }
    
    func isOriginCell() -> Bool {
        return column == 0 && row == 0
    }
    
    func isHeaderColumn() -> Bool {
        return column == 0
    }
    
    func isHeaderRow() -> Bool {
        return row == 0
    }
    
    func isDataCell() -> Bool {
        return !(isHeaderColumn() || isHeaderRow())
    }
}