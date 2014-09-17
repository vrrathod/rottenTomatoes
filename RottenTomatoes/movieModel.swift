//
//  movieModel.swift
//  RottenTomatoes
//
//  Created by vr on 9/15/14.
//  Copyright (c) 2014 vr. All rights reserved.
//

import Foundation

class MovieModel{
    var dictMovieDetails = NSDictionary();
    
    // SETTER FOR DICT
    func setMovieDetails( details:NSDictionary ) {
        dictMovieDetails = details;
    }
    
    // BASE GETTER : String
    func movieStringInfo(attribute:NSString) -> NSString {
        var movie:NSString = dictMovieDetails[attribute] as NSString;
        if( movie.length > 0 ) {
            return movie;
        } else {
            return "Who knows!";
        }
    }
    
    // BASE GETTER : Number
    func movieNumberInfo(attribute:NSString) -> NSNumber {
        var movie:NSNumber = dictMovieDetails[attribute] as NSNumber;
        return movie;
    }
    
    // MOVIE NAME
    func movieName() -> NSString {
        return movieStringInfo("title");
    }
    
    // MOVIE DESCRIPTION
    func movieDescription() -> NSString {
        return movieStringInfo("synopsis");
    }
    
    // MOVIE THUMBNAIL URL
    func movieThumbnailURL() -> NSString {
        var urls:NSDictionary = dictMovieDetails["posters"] as NSDictionary;
        return urls["thumbnail"] as NSString;
    }
    
    // MOVIE YEAR
    func movieYear() -> NSNumber {
//        return movieSpecifics("year");
        return movieNumberInfo("year") ;
    }
    
    // MOVIE RATING
    func movieRating() -> NSString {
        return movieStringInfo("mpaa_rating");
    }
    
    // RUNTIME
    func movieRuntime() -> NSNumber {
        return movieNumberInfo("runtime");
    }
    
    // CRITIC SCORE
    func criticScore() -> NSNumber {
        var scores:NSDictionary = dictMovieDetails["ratings"] as NSDictionary;
        return scores["critics_score"] as NSNumber;
    }
    
    func audienceScore() -> NSNumber {
        var scores:NSDictionary = dictMovieDetails["ratings"] as NSDictionary;
        return scores["audience_score"] as NSNumber;
    }
    
    // RATING
    func ratingString() -> NSString {
        return "Critic Score: \(criticScore()), Audience Score: \(audienceScore())";
    }
}
