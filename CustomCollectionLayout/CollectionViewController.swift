//
//  CollectionViewController.swift
//  CustomCollectionLayout
//
//  Created by JOSE MARTINEZ on 15/12/2014.
//  Copyright (c) 2014 brightec. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView .registerNib(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView .registerNib(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 50
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
                dateCell.backgroundColor = UIColor.whiteColor()
                dateCell.dateLabel.font = UIFont.systemFontOfSize(13)
                dateCell.dateLabel.textColor = UIColor.blackColor()
                dateCell.dateLabel.text = "Date"
                
                return dateCell
            } else {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                contentCell.contentLabel.textColor = UIColor.blackColor()
                contentCell.contentLabel.text = "Section"
                
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.whiteColor()
                }
                
                return contentCell
            }
        } else {
            if indexPath.row == 0 {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
                dateCell.dateLabel.font = UIFont.systemFontOfSize(13)
                dateCell.dateLabel.textColor = UIColor.blackColor()
                dateCell.dateLabel.text = String(indexPath.section)
                if indexPath.section % 2 != 0 {
                    dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    dateCell.backgroundColor = UIColor.whiteColor()
                }
                
                return dateCell
            } else {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                contentCell.contentLabel.textColor = UIColor.blackColor()
                contentCell.contentLabel.text = "Content"
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.whiteColor()
                }
                
                return contentCell
            }
        }
    }
}

