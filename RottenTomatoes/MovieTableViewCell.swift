//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by vr on 9/13/14.
//  Copyright (c) 2014 vr. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    ////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieThumbnail: UIImageView!
    
    var stringThumbURL = "";
    var stringDescription = "";
    var movie:MovieModel = MovieModel();
    
    
    ////////////////////////////////////////////////////////////////////////
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    ////////////////////////////////////////////////////////////////////////
    func setMovieModel(details:NSDictionary) {
        movie.setMovieDetails(details);
        movieName.text = movie.movieName();
        movieDescription.text = movie.movieDescription();
        setMovieThumbnail(movie.movieThumbnailURL());
    }
    
    func setMovieName(name: NSString) {
        movieName.text = name;
    }
    
    func setMovieDescription(desc: NSString) {
        movieDescription.text = desc;
        stringDescription = desc;
    }
    
    func setMovieThumbnail(stringURL: NSString) {
        self.stringThumbURL = stringURL;
        // load thumbnail
        var req:NSURLRequest = NSURLRequest(URL: NSURL(string:stringURL));
        let imageRequestSuccess = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
            self.movieThumbnail.image = image;
        }
        let imageRequestFailure = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, error : NSError!) -> Void in
            NSLog("imageRequrestFailure")
        }
        
        self.movieThumbnail.setImageWithURLRequest(req, placeholderImage:nil, success:imageRequestSuccess, failure:imageRequestFailure);
    }
}