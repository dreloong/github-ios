//
//  ReposViewController.swift
//  GitHub
//
//  Created by Xiaofei Long on 3/7/16.
//  Copyright © 2016 dreloong. All rights reserved.
//

import UIKit
import MBProgressHUD

class ReposViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var searchBar: UISearchBar!
    var searchSettings = RepoSearchSettings()

    var repos = [Repo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        fetchRepos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingsNavigationController = segue.destinationViewController
            as! UINavigationController
        let settingsViewController = settingsNavigationController.topViewController
            as! SettingsViewController
        settingsViewController.searchSettings = searchSettings
    }

    // MARK: - Helpers

    private func fetchRepos() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        Repo.fetchRepos(
            searchSettings,
            successCallback: { (repos) -> Void in
                self.repos = repos
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            },
            errorCallback: { (error) -> Void in
                print(error)
            }
        )
    }
}

extension ReposViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Repo Cell",
            forIndexPath: indexPath
        ) as! RepoTableViewCell

        cell.repo = repos[indexPath.row]

        return cell
    }
}

extension ReposViewController: UITableViewDelegate {

}

extension ReposViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        fetchRepos()
    }
}
