//
//  SuggestedTableViewController.swift
//  testHackathon
//
//  Created by Gabriel Pezanoski-Cohen on 11/21/15.
//  Copyright © 2015 Gabriel Pezanoski-Cohen. All rights reserved.
//

import UIKit

class SuggestedTableViewController: UITableViewController {
    
    func update(){
        self.tableView.reloadData()
    }
    
    var testList = NSString?()

    var artistList: [String?] = [String?]()
    var artistListFull: [artist?] = [artist?]()
    var newArtist: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataString: String = ""
        var first = 1
        for x in userArtistList{
            if first == 0{
                dataString+=","
                dataString+=String(x)
            }
            else{
                dataString+="artists="
                dataString+=String(x)
                first = 0
            }
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://dry-plateau-6342.herokuapp.com/find_suggestions")!)
        request.HTTPMethod = "POST"
        let postString = dataString
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            self.testList = NSString(data: data!, encoding: NSUTF8StringEncoding)!;
            //
            //            print("response = \(response)")
            //
            //            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            print("responseString = \(responseString)")
            let newTest = self.testList?.componentsSeparatedByString("{")
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
