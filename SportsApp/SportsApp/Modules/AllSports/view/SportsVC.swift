//
//  MainSportsCollectionVC.swift
//  SportsApp
//
//  Created by Shady Adel on 14/08/2024.
//

import UIKit



class SportsVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    
    var presenter: SportsArrayManipulator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter  = SportsPresenter()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Sports"
        collectionView.layoutSubviews()
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return presenter?.sportsArrayCount() ?? 1

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let leagueVC = self.storyboard?.instantiateViewController(withIdentifier: "leagueVc") as? LeaguesTableVC {
            leagueVC.sport = presenter?.sportsElement(indexPath.row)
            self.navigationController?.pushViewController(leagueVC, animated: true)
        }
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCell
        
        cell.imgMainSportImage.layer.cornerRadius = 20
        cell.imgMainSportImage.layer.masksToBounds = true
        
        cell.imgMainSportImage.image = UIImage(named: presenter?.sportsElement(indexPath.row) ?? "football")
        cell.lblMainSportLabel.text = presenter?.sportsElement(indexPath.row).capitalized ?? ""
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width) / 2, height: (self.view.bounds.width + 20) / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   

}


