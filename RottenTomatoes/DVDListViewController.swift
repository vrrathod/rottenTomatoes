//
//  SecondViewController.swift
//  RottenTomatoes
//
//  Created by vr on 9/13/14.
//  Copyright (c) 2014 vr. All rights reserved.
//

import UIKit

class DVDListViewController: UIViewController, UITableViewDataSource {
////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
////////////////////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: DVDTableViewCell? = tableView.dequeueReusableCellWithIdentifier("vr.codepath.rottentomatoes.dvds.cell" ) as? DVDTableViewCell;
        var movieName:NSString = "DVD \(indexPath.row)";
        NSLog(movieName);
        cell?.setMovieName( movieName ) ;
        return cell!;
    }

////////////////////////////////////////////////////////////////////////
}

