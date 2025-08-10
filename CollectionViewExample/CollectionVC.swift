//
//  CollectionVC.swift
//  CollectionViewExample
//
//  Created by Krishna Ramesh on 8/8/25.
//

import UIKit

class CollectionVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = self.createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = false;
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .gray
        collectionView.translatesAutoresizingMaskIntoConstraints = false  // Add this line
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        ])
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsetsReference = .layoutMargins
        section.visibleItemsInvalidationHandler = { [weak self] items, offset, environment in
            guard let self = self else { return }
            
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let normalized = distanceFromCenter / environment.container.contentSize.width
                let alpha = normalized
                let cell = self.collectionView.cellForItem(at: item.indexPath) as? Cell
                cell?.slideView.alpha = alpha
            }
        }

        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension CollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        return cell
    }
}

