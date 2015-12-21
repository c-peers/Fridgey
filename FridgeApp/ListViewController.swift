//
//  ThirdViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/5/15.
//  Copyright (c) 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        list = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9"]
    
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("vwa")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(list.count)
        return list.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ListCollectionViewCell", forIndexPath: indexPath) as! ListCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 2.0
        
        cell.listName.setTitle(list[indexPath.row], forState: .Normal)
        print(list[indexPath.row])
        
        return cell
        
    }
    
    
}
