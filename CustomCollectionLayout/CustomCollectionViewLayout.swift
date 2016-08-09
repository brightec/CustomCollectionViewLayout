//
//  CustomCollectionViewLayout.swift
//  CustomCollectionLayout
//
//  Created by JOSE MARTINEZ on 15/12/2014.
//  Copyright (c) 2014 brightec. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {

    private let numberOfColumns = 8
    private var itemAttributes = [[UICollectionViewLayoutAttributes]]()
    private var itemsSize = [CGSize]()
    private var contentSize = CGSizeZero
    
    override func prepareLayout() {
        if collectionView!.numberOfSections() == 0 {
            return
        }
        
        if (itemAttributes.count > 0) {
            for section in 0..<collectionView!.numberOfSections() {
                let numberOfItems = collectionView!.numberOfItemsInSection(section)
                for index in 0..<numberOfItems {
                    if section != 0 && index != 0 {
                        continue
                    }
                    
                    let attributes = layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: index, inSection: section))
                    if section == 0 {
                        var frame = attributes!.frame
                        frame.origin.y = collectionView!.contentOffset.y
                        attributes!.frame = frame
                    }
                    
                    if index == 0 {
                        var frame = attributes!.frame
                        frame.origin.x = collectionView!.contentOffset.x
                        attributes!.frame = frame
                    }
                }
            }
            return
        }
        
        if itemsSize.count != numberOfColumns {
            calculateItemsSize()
        }
        
        var column = 0
        var xOffset : CGFloat = 0
        var yOffset : CGFloat = 0
        var contentWidth : CGFloat = 0
        var contentHeight : CGFloat = 0
        
        for section in 0..<collectionView!.numberOfSections() {
            var sectionAttributes = [UICollectionViewLayoutAttributes]()
            
            for index in 0..<numberOfColumns {
                let itemSize = itemsSize[index]
                let indexPath = NSIndexPath(forItem: index, inSection: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height))
                
                if section == 0 && index == 0 {
                    attributes.zIndex = 1024;
                } else  if section == 0 || index == 0 {
                    attributes.zIndex = 1023
                }
                
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView!.contentOffset.y
                    attributes.frame = frame
                }
                if index == 0 {
                    var frame = attributes.frame
                    frame.origin.x = collectionView!.contentOffset.x
                    attributes.frame = frame
                }
                
                sectionAttributes.append(attributes)
                
                xOffset += itemSize.width
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }

            itemAttributes.append(sectionAttributes)
        }
      
        let attributes = itemAttributes.last!.last!
        contentHeight = attributes.frame.origin.y + attributes.frame.size.height
        contentSize = CGSizeMake(contentWidth, contentHeight)
    }
    
    override func collectionViewContentSize() -> CGSize {
        return contentSize
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var attributes = [UICollectionViewLayoutAttributes]()
      
      for section in itemAttributes {
        let filteredArray = section.filter { obj -> Bool in
          return CGRectIntersectsRect(rect, obj.frame)
        }
        attributes.appendContentsOf(filteredArray)
      }
      
      return attributes
    }
  
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    func sizeForItemWithColumnIndex(columnIndex: Int) -> CGSize {
        let text = "Col \(columnIndex)"
        let size = (text as NSString).sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17.0)])
        let width = size.width + 25
        return CGSizeMake(width, 30)
    }
    
    func calculateItemsSize() {
        for index in 0..<numberOfColumns {
            itemsSize.append(sizeForItemWithColumnIndex(index))
        }
    }
}
