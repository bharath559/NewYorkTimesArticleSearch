//
//  MasterViewController.swift
//  NyTimesArticleSearch
//
//  Created by Bharath Kongara on 5/22/16.
//  Copyright © 2016 Bharath Kongara. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RealmSwift

 let kArticlesListPath = "http://api.nytimes.com/svc/search/v2/articlesearch.json"

 let kApiKey = "ee2b0d06a9f24dd0bcd053e969ac4aa4"

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var artciles = List<ArticleModel>()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func viewWillAppear(animated: Bool) {
        
        let requestModel = ArticleListRequestModel()
        
        requestModel.query="Basketball"
        requestModel.articlesFromDate = requestModel.dateFromString("20150701")
        requestModel.articlesToDate = requestModel.dateFromString("20150706")
        
        var parameters = Mapper().toJSON(requestModel)
        
        
        parameters["api-key"] = kApiKey
        
        Alamofire.Manager.sharedInstance.request(.GET,kArticlesListPath,parameters: parameters)
                .validate()
            .responseJSON { response in
                
                    switch response.result{
                        
                        case .Success:
                            
                         //print(response.result.value)
                         
                         let articlesJson = response.result.value
                         
                         //print(articles!["response"]!!["docs"])
                         
                         let articleModels = Mapper<ArticleListResponseModel>().map(articlesJson)
                         //print(articleModels)
                         
                         self.artciles = articleModels!.articles
                         
                         for eachArticle in articleModels!.articles{
                            
                            print(eachArticle)
                         }
                         
                         self.tableView.reloadData()
                        
                        break
                        
                        case .Failure(let error):
                            
                            let realm = try! Realm()
                            let articles = realm.objects(ArticleModel)
                            
                            self.artciles = List(articles)
                            
                            self.tableView.reloadData()
                            print(error)
                        
                        break
                    }
        }
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object:ArticleModel = artciles[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
               
                controller.url = object.url
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artciles.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object:ArticleModel = artciles[indexPath.row]
        cell.textLabel!.text = object.leadParagraph
        return cell
    }

 


}

