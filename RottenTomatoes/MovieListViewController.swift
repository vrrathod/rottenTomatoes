//
//  FirstViewController.swift
//  RottenTomatoes
//
//  Created by vr on 9/13/14.
//  Copyright (c) 2014 vr. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource {
    ////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var errorText: UILabel!
    
    // our designated http request manager
    let manager = AFHTTPRequestOperationManager();
    
    // control the url requests
    var pullHandler:UIRefreshControl = UIRefreshControl();
    
    // our array for result set
    var listOfMovies: NSArray? ;

    // spinner
    var spinner:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge);
    
    /// TODO: move to constants, also APIKEY is embedded, not good
    /// store the url where we could fetch the movies in theater
    /// Note: Currently we will show movies that are already in theaters
    let stringURL = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=s6an6gt3278cpj3q7re7rnk3";
    
    ////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set the background color of the navigation item
        errorText.hidden = true;
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black;
        pullHandler.attributedTitle = NSAttributedString(string: "Pull to refersh");
        pullHandler.tintColor = UIColor.redColor();
        pullHandler.addTarget(self, action: "updateTable:", forControlEvents: UIControlEvents.ValueChanged);
        self.moviesTable.addSubview(pullHandler);
        
        spinner.center = self.view.center;
        self.view.addSubview(spinner);
        spinner.startAnimating();
    }
    
    override func viewWillAppear(animated: Bool) {
        if( nil == self.listOfMovies ) {
            // lets set the serialization
            manager.responseSerializer = AFJSONResponseSerializer();
            // we dont have list of movies set yet, lets fetch 'em
            manager.GET(stringURL, parameters: nil, success: successHandler, failure: failureHandler);
            spinner.startAnimating();
        }
    }
    
    
    // when we segue, do something
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "movieDetails" == segue.identifier {
            var movieCell:MovieTableViewCell = sender? as MovieTableViewCell;
            var movieDetailsVC:MovieViewController = segue.destinationViewController as MovieViewController;
            movieDetailsVC.thumbnailImage = movieCell.movieThumbnail.image!;
            movieDetailsVC.movie = movieCell.movie;
        }
    }
    
    ////////////////////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listOfMovies != nil {
            return listOfMovies!.count;
        } else {
            return 0;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: MovieTableViewCell? = tableView.dequeueReusableCellWithIdentifier("vr.codepath.rottentomatoes.movies.cell" ) as? MovieTableViewCell;
        var dict:NSDictionary = self.listOfMovies![indexPath.row] as NSDictionary;
        cell?.setMovieModel(dict);
        return cell!;
    }
    
    func updateTable(sender:AnyObject?) {
        var upcominglist = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=s6an6gt3278cpj3q7re7rnk3";
        manager.GET(upcominglist, parameters: nil,
            success: successHandler,
            failure: failureHandler)
    }
    
    func successHandler(request:AFHTTPRequestOperation!, inResult:AnyObject!) -> Void {
        self.animatedError(false);
        self.listOfMovies = inResult["movies"] as? NSArray;
        self.moviesTable.reloadData();
        self.pullHandler.endRefreshing();
        self.spinner.stopAnimating();
    }
    
    func failureHandler(request:AFHTTPRequestOperation!, error:NSError!) -> Void {
        NSLog("error \(error.localizedDescription)");
        if -1001 == error.code || -1009 == error.code {
            self.animatedError(true);
        }
        self.pullHandler.endRefreshing();
        self.spinner.stopAnimating();
    }
    
    func animatedError(show:Bool) {
        var startAlpha:CGFloat = 1.0;
        var endAlpha:CGFloat = 0.0;
        
        if( show ) { startAlpha = 0; endAlpha = 1; }
        
        self.errorText.alpha = startAlpha ;
        self.errorText.hidden = !show;
        
        UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.errorText.alpha = endAlpha;
            }, completion: nil);
    }
}

