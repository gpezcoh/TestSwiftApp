//
//  ArtistListViewController.swift
//  testHackathon
//
//  Created by Gabriel Pezanoski-Cohen on 11/21/15.
//  Copyright © 2015 Gabriel Pezanoski-Cohen. All rights reserved.
//

import UIKit

class artist{
    var name: String?
    var id: Int?
}

var userArtistList: [Int] = [Int]()


class ArtistListViewController: UITableViewController {

//
//    @IBAction func done(segue:UIStoryboardSegue) {
//        var artistDetailVC = segue.sourceViewController as! ArtistDetailViewController
//        
//        newArtist = artistDetailVC.name
//        
//        artistList.append(newArtist)
//        
//        self.tableView.reloadData()
//        
    
//    }
//    
    
    var artistList: [String] = [String]()
    var artistListFull: [artist] = [artist]()

    @IBOutlet weak var add: UIBarButtonItem!

    @IBAction func cancel(segue:UIStoryboardSegue) {
        self.tableView.reloadData()
        userArtistList = []
        add.enabled = false
    }

    func update(){
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add.enabled = false
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 46.0/255.0, green: 14.0/255.0, blue: 74.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let url = NSURL(string: "http://dry-plateau-6342.herokuapp.com/api/v1/artists")
        var test: NSString?
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            test = (NSString(data: data!, encoding: NSUTF8StringEncoding))
            let newTest = test?.componentsSeparatedByString("{")
            for x in newTest!{
                var testArr = x.componentsSeparatedByString(",")
                if testArr.count > 1{
                    let testArtist: artist = artist()
                    testArtist.id = Int(testArr[0].componentsSeparatedByString(":")[1])
                    testArtist.name = testArr[1].componentsSeparatedByString(":")[1]
                    self.artistListFull.append(testArtist)
                    self.artistList.append(testArtist.name!)
                }
            }
            self.update()
        }
        task.resume()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artistList.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        add.enabled = true
        var testId = artistListFull[indexPath.row].id!
        if(!userArtistList.contains(testId)){
            userArtistList.append(testId)
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var testId = artistListFull[indexPath.row].id!
        if(userArtistList.contains(testId)){
            userArtistList = userArtistList.filter() {$0 != testId}
        }
        if userArtistList.count == 0{
            add.enabled = false
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("artistCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = artistList[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
