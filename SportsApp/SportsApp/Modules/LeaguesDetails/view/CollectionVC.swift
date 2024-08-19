//
//  CollectionVC.swift
//  MultiSectionCompositionalLayout
//
//  Created by Shady Adel on 19/08/2024.
//

import UIKit
class CollectionVC: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            switch sectionIndex {
            case 0, 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(90), heightDimension: .absolute(90)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                return section
            default:
                return nil
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCell", for: indexPath) as! singleImageCollectionCell
            cell.img.image = UIImage(systemName: "video")
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.backgroundColor = .cyan
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tribleCell", for: indexPath) as! TribleCollectionCell
            cell.leftimg.image = UIImage(systemName: "basketball")
            cell.leftlbl.text = "a"
            cell.rightimg.image = UIImage(systemName: "video")
            cell.rightlbl.text = "b"
            cell.backgroundColor = .green
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doubleCell", for: indexPath) as! ImageAndLabelCollectionCell
            cell.img.image = UIImage(systemName: "pencil")
            cell.lbl.text = "s"
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.backgroundColor = .magenta
            return cell
        default:
            fatalError("Unexpected section index: \(indexPath.section)")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            // Instantiate the team details view controller
           // let teamDetailsVC = TeamDetailsViewController()
            print("team Details")
            // Configure the teamDetailsVC if needed, e.g., pass data to it
            
            // Present the view controller modally
            //present(teamDetailsVC, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        header.backgroundColor = .systemGray5
        
        let label = UILabel(frame: header.bounds)
        label.text = headerTitle(for: indexPath.section)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        header.subviews.forEach { $0.removeFromSuperview() }
        header.addSubview(label)
        
        return header
    }
    
    private func headerTitle(for section: Int) -> String {
        switch section {
        case 0: return "Horizontal Section"
        case 1: return "Vertical Section"
        case 2: return "Another Horizontal Section"
        default: return ""
        }
    }
}
