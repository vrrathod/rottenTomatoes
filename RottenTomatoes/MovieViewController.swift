//
//  MovieViewController.swift
//  RottenTomatoes
//
//  Created by vr on 9/14/14.
//  Copyright (c) 2014 vr. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieCritics: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDesc: UITextView!
    
    @IBOutlet var panActionOnDescription: UIPanGestureRecognizer!
    
    var thumbnailImage:UIImage = UIImage();
    var movie:MovieModel = MovieModel() ;
    
    var labelStartingPoint:CGPoint = CGPoint();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelStartingPoint = panActionOnDescription.view!.center;
        movieDesc.textColor = UIColor.whiteColor();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(animated: Bool) {
        
        // lets set a temp image
        self.backgroundImage.image = self.thumbnailImage;
        var movieURL = "";
        movieURL = movie.movieThumbnailURL();
        //Hack: we always get tmb => we need orig
        var newStringURL = movieURL.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: nil, range: nil);
        
        // create a request
        var req:NSURLRequest = NSURLRequest(URL: NSURL(string: newStringURL));
        
        let imageRequestSuccess = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
            self.backgroundImage.image = image;
        }
        let imageRequestFailure = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, error : NSError!) -> Void in
            NSLog("imageRequrestFailure")
        }
        
        self.backgroundImage.setImageWithURLRequest(req, placeholderImage:nil, success:imageRequestSuccess, failure:imageRequestFailure);

        movieDesc.text = movie.movieDescription();
        movieTitle.text = "\(movie.movieName()) (\(movie.movieYear()))";
        movieCritics.text = "\(movie.ratingString())";
        movieRating.text = "\(movie.movieRating())";
    }
    ////////////////////////////////////////////////////////////////////////
    @IBAction func panGestureHandler(sender:UIPanGestureRecognizer){
        // TODO: consider velocity 
        let translation = panActionOnDescription.translationInView(self.movieView)
        if( ( panActionOnDescription.view!.center.y + translation.y ) < labelStartingPoint.y ) {
            panActionOnDescription.view!.center = CGPoint(x:panActionOnDescription.view!.center.x ,
                y:panActionOnDescription.view!.center.y + translation.y)
            panActionOnDescription.setTranslation(CGPointZero, inView: self.view)
        }
    }
}
