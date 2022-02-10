//
//  ViewController.swift
//  HelloCustomCollectionView
//
//  Created by Doyoung on 2022/02/07.
//

import UIKit

class MosaicCollectionViewController: UIViewController {

    let colors: [UIColor] = [.systemRed, .systemBrown, .systemPink, .systemGreen, .systemPurple, .systemYellow]
    @IBOutlet weak var mosaicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mosaicCollectionView.dataSource = self
        mosaicCollectionView.delegate = self
    }


}

extension MosaicCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MosaicCollectionViewCell.reuseIdentifier, for: indexPath) as? MosaicCollectionViewCell else {
           preconditionFailure("Failed to load collection view cell")
        }
        cell.contentView.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    
}

extension MosaicCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueID.showCLVC.id, sender: self)
    }
}

class MosaicCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MosaicCollectionViewCellReuseIdentifier"
   
}
