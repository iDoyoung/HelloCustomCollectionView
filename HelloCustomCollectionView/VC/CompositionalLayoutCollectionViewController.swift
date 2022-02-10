//
//  AnimationCompositionalLayoutCVController.swift
//  HelloCustomCollectionView
//
//  Created by Doyoung on 2022/02/09.
//

import UIKit

//MARK: Availability - iOS 13.0+
//MARK: Reference: https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout

class CompositionalLayoutCollectionViewController: UIViewController {

    @IBOutlet weak var compositionalLayoutCollectionView: UICollectionView!
    
    enum Section: Int {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compositionalLayoutCollectionView.backgroundColor = .systemBlue
        compositionalLayoutCollectionView.collectionViewLayout = createLayout()
        configureDataSource()
        // Do any additional setup after loading the view.
    }


}

extension CompositionalLayoutCollectionViewController {
    
    /// - Tag: Collection View Layout
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1)))
            //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                   heightDimension: .fractionalHeight(0.7)),
                subitems: [item])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            let itemWidth = self.compositionalLayoutCollectionView.bounds.width * 0.7
            let horizontalSectionInset = (self.compositionalLayoutCollectionView.bounds.width - itemWidth) / 2
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 20,
                                                            leading: horizontalSectionInset,
                                                            bottom: 0,
                                                            trailing: horizontalSectionInset)
            section.visibleItemsInvalidationHandler = {
                (items, offset, environment) in
                items.forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
            return section
            
        }
        
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: compositionalLayoutCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalLayoutCollectionViewCell.reuseIdentifier, for: indexPath) as? CompositionalLayoutCollectionViewCell else {
                preconditionFailure("Failed to load collection view cell")
            }
            cell.contentView.backgroundColor = .systemYellow
            cell.indexLabel.text = "\(indexPath.item)"
            return cell
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([Section.main.rawValue])
        snapshot.appendItems(Array(0..<10))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
}

class CompositionalLayoutCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CompositionalLayoutCVCellReuseIdentifier"
    
    @IBOutlet weak var indexLabel: UILabel!
    
    
}
