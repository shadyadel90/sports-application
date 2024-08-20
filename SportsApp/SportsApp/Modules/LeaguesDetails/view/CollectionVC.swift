//
//  CollectionVC.swift
//  MultiSectionCompositionalLayout
//
//  Created by Shady Adel on 19/08/2024.
//

import UIKit
import Alamofire
import Kingfisher
class CollectionVC: UICollectionViewController {
    
    var upcomingEvents: [Event] = []
    var latestResults: [Event] = []
    var Teams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        
        fetchUpcomingEvents()
        fetchlatestResults()
    }
    func fetchUpcomingEvents(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var currentDay = ""
        var nextDay = ""
        
        let currentDate = Date()
        currentDay = dateFormatter.string(from: currentDate)
        let calendar = Calendar.current
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            nextDay = dateFormatter.string(from: nextDate)
        }
        let baseUrl = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=76a51d962bba98945a8f0f16a8b272400dfcea841cf0b303f9ab3c6e20aaee0f&from=\(currentDay)&to=\(nextDay)")
        AF.request(baseUrl!).responseDecodable(of: EventsResponse.self) { response in
            switch response.result {
            case .success(let eventResponse):
                for item in 0...10 {
                    self.upcomingEvents.append(eventResponse.result[item])
                    let event = eventResponse.result[item]
                    let hometeam = Team(name: event.home, logo: event.homelogo, key: event.homeKey)
                    let awayteam = Team(name: event.away, logo: event.awaylogo, key: event.awayKey)
                    self.Teams.append(hometeam)
                    self.Teams.append(awayteam)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
            
        }
    }
    
    func fetchlatestResults(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var currentDay = ""
        var dayBefore = ""
        
        let currentDate = Date()
        currentDay = dateFormatter.string(from: currentDate)
        let calendar = Calendar.current
        if let nextDate = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            dayBefore = dateFormatter.string(from: nextDate)
        }
        let baseUrl = URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=76a51d962bba98945a8f0f16a8b272400dfcea841cf0b303f9ab3c6e20aaee0f&from=\(dayBefore)&to=\(currentDay)")
        AF.request(baseUrl!).responseDecodable(of: EventsResponse.self) { response in
            switch response.result {
            case .success(let eventResponse):
                for item in 0...10 {
                    self.latestResults.append(eventResponse.result[item])
                    print(eventResponse.result[item])
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
            
        }
    }
    
    
    
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            switch sectionIndex {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(200), heightDimension: .absolute(110)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 20
                section.boundarySupplementaryItems = [header]
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.boundarySupplementaryItems = [header]
                return section
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(90), heightDimension: .absolute(90)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
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
        switch section {
        case 0:
            return upcomingEvents.count
        case 1:
            return latestResults.count
        case 2:
            return Teams.count
        default:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEvent", for: indexPath) as! UpcomingEvent
            let event = upcomingEvents[indexPath.row]
            cell.lblVS.text = "\(event.home) VS \(event.away)"
            cell.lbldate.text = "\(event.date)"
            cell.lbltime.text = "\(event.time)"
            cell.layer.cornerRadius = 20
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tribleCell", for: indexPath) as! TribleCollectionCell
            let latestResult = latestResults[indexPath.row]
            
            let url = URL(string: latestResults[indexPath.row].homelogo!)
            if url != nil {
                cell.leftimg.kf.setImage(with: url, placeholder: UIImage(named: "football"))
            } else {
                cell.leftimg.image = UIImage(named: "football")
            }
         
            
            let url2 = URL(string: latestResults[indexPath.row].awaylogo!)
            if url2 != nil {
                cell.rightimg.kf.setImage(with: url2, placeholder: UIImage(named: "football"))
            } else {
                cell.rightimg.image = UIImage(named: "football")
            }
            cell.scorelbl.text = latestResult.score
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCell", for: indexPath) as! singleImageCollectionCell
            let url = URL(string: Teams[indexPath.row].logo!)
            if url != nil {
                cell.img.kf.setImage(with: url, placeholder: UIImage(named: "football"))
            } else {
                cell.img.image = UIImage(named: "football")
            }
            cell.layer.cornerRadius = cell.frame.height / 2
            
            return cell
        default:
            fatalError("Unexpected section index: \(indexPath.section)")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            
            let teamDetailsVC = self.storyboard?.instantiateViewController(identifier: "TeamDetailVC") as! TeamDetailVC
            
            teamDetailsVC.team = Teams[indexPath.row]
            
            present(teamDetailsVC, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        header.backgroundColor = .systemGray5
        
        let label = UILabel(frame: header.bounds)
        label.text = headerTitle(for: indexPath.section)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        header.subviews.forEach { $0.removeFromSuperview() }
        header.addSubview(label)
        
        return header
    }
    
    private func headerTitle(for section: Int) -> String {
        switch section {
        case 0: return "Upcoming Events"
        case 1: return "Latest Results"
        case 2: return "Teams"
        default: return ""
        }
    }
}
