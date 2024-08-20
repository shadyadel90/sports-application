//
//  NetworkCheck.swift
//  SportsApp
//
//  Created by Shady Adel on 20/08/2024.
//

import UIKit
import Network

class InternetConnectionMonitor {
    
    static let shared = InternetConnectionMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    private init() {
        monitor.start(queue: queue)
    }
    
    func checkConnection(in viewController: UIViewController) {
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "No Internet Connection",
                                                  message: "Please check your internet connection and try again.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
