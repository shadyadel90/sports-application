//
//  FavouriteLeagueTableVC.swift
//  SportsApp
//
//  Created by Shady Adel on 20/08/2024.
//

import UIKit
import Kingfisher

class FavouriteLeagueTableVC: UITableViewController {

    var presenter: FavouriteLeagueManipulator?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouriteLeaguePresenter()
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Favourite Leagues"
        presenter?.loadLeagues(completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.displayLeaguesCount() ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        guard let league = presenter?.displayLeaguesElement(indexPath.row) else { return cell }
        let url = URL(string: league.leagueLogo ?? "")
        cell.img.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        cell.lbl.text = league.leagueName
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(youtubeButtonTapped(_:)), for: .touchUpInside)
        cell.btn.accessibilityLabel = league.leagueName

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeLeagueFromPersistence(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @objc func youtubeButtonTapped(_ sender: UIButton) {
        
        let videoID = sender.accessibilityLabel ?? "k4MNDLU9ejQ"
        if presenter?.openYouTubeLink(videoID) == false {
            // Show an alert if the URL cannot be opened
            let alert = UIAlertController(title: "Cannot Open Link",
                                          message: "Unable to open the video. Please check your internet connection or try again later.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

