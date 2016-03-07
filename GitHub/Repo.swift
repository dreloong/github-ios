//
//  Repo.swift
//  GitHub
//
//  Created by Xiaofei Long on 3/7/16.
//  Copyright © 2016 dreloong. All rights reserved.
//

import Foundation
import AFNetworking

private let reposUrl = "https://api.github.com/search/repositories"
private let clientId = "a4fb31dec7b521b23f9b"
private let clientSecret = "95670677af25d9e44eafb08a8f7e1978f7645c00"

class Repo: CustomStringConvertible {

    var name: String?
    var ownerHandle: String?
    var ownerAvatarUrl: NSURL?
    var starsCount: Int?
    var forksCount: Int?
    var repoDescription: String?

    init(dictionary: NSDictionary) {
        if let name = dictionary["name"] as? String {
            self.name = name
        }

        if let starsCount = dictionary["stargazers_count"] as? Int? {
            self.starsCount = starsCount
        }

        if let forksCount = dictionary["forks_count"] as? Int? {
            self.forksCount = forksCount
        }

        if let repoDescription = dictionary["description"] as? String? {
            self.repoDescription = repoDescription
        }

        if let owner = dictionary["owner"] as? NSDictionary {
            if let ownerHandle = owner["login"] as? String {
                self.ownerHandle = ownerHandle
            }
            if let ownerAvatarUrlString = owner["avatar_url"] as? String {
                self.ownerAvatarUrl = NSURL(string: ownerAvatarUrlString)
            }
        }
    }

    class func fetchRepos(
        settings: RepoSearchSettings,
        successCallback: ([Repo]) -> Void,
        errorCallback: ((NSError?) -> Void)?
    ) {
        let manager = AFHTTPSessionManager()
        manager.GET(
            reposUrl,
            parameters: queryParamsWithSettings(settings),
            progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                if let dictionaries = response!["items"] as? [NSDictionary] {
                    let repos = dictionaries.map({ dictionary in Repo(dictionary: dictionary) })
                    successCallback(repos)
                }
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                if let errorCallback = errorCallback {
                    errorCallback(error)
                }
            }
        )
    }

    private class func queryParamsWithSettings(settings: RepoSearchSettings) -> [String: String] {
        var params = [
            "client_id": clientId,
            "client_secret": clientSecret,
            "sort": "stars",
            "order": "desc"
        ];

        var q = settings.searchString ?? ""
        q += " stars:>\(settings.minStars)";
        params["q"] = q;

        return params;
    }

    var description: String {
        return (
            "[Name: \(self.name!)]\n\t" +
            "[Stars: \(self.starsCount!)]\n\t" +
            "[Forks: \(self.forksCount!)]\n\t" +
            "[Owner: \(self.ownerHandle!)]\n\t" +
            "[Description: \(self.repoDescription!)]\n\t" +
            "[Avatar: \(self.ownerAvatarUrl!)]"
        )
    }
}
