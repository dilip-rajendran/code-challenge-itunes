//
//  ViewController.swift
//  code-challenge
//
//  Created by Dilip on 3/24/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import UIKit

class LandingScreen: UITableViewController {
    var dataSource: [resultsModel]?
    var feed: FeedModel?
    fileprivate func tableViewSetup() {
        // Do any additional setup after loading the view.
        tableView.register(AlbumResuableCell.self, forCellReuseIdentifier: ConstantIdentifiers.albumCellIdentifier.rawValue)
        tableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewModel = LandingScreenViewModel()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        viewModel.getFeed { [weak self] (serverResponse) in
            switch serverResponse {
            case .success(let response):
                self?.dataSource = response.feed?.results
                self?.feed = response.feed
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.separatorStyle = .singleLine
                    self?.tableView.separatorInset = .zero
                    activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                default: break
            }        }
    }

}

extension LandingScreen {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: ConstantIdentifiers.albumCellIdentifier.rawValue, for: indexPath) as? AlbumResuableCell, let instanceModel = dataSource?[indexPath.row] {
            cell.bindViewModel(viewModel: AlbumResuableCellViewModel(model: instanceModel))
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = AlbumDetailScreen(model: dataSource?[indexPath.row])
        navigationController?.pushViewController(detailScreen, animated: true)
    }
    
}

extension LandingScreen {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let title = feed?.title {
            return HeaderView().getHeaderView(titleString: title)
        }
        return UIView()
    }
}
