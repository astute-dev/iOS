//
//  MainTableViewController.swift
//
// Copyright (c) 21/12/15. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class MainTableViewController: UITableViewController {
    var content: Event!
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    
    let kRowsCount = 10
    
    var cellHeights = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        createCellHeightsArray()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            print("Swipe Left")
            self.performSegueWithIdentifier("create", sender: self)
            
        }
        
        if (sender.direction == .Right) {
            print("Swipe Right")
            
            
        }
    }
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (content.department.count)
    }


    @IBAction func attendBtn(sender: AnyObject) {
        
        var position: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        if let indexPath = self.tableView.indexPathForRowAtPoint(position) {
            let section = indexPath.section
            let row = indexPath.row
            let indexPath = NSIndexPath(forRow: row, inSection: section)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
            cell.ex_attendees.text = "3"
            cell.attendBtnOutlet.backgroundColor = UIColor(hue: 0.4444, saturation: 0.8, brightness: 0.34, alpha: 1.0) /* #115740 */
            cell.attendBtnOutlet.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            cell.attendBtnOutlet.setTitle("Joined!", forState: UIControlState.Normal)
            
            
            
        }
        
        
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
                
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! FoldingCell
        let date = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-80, height: 62))
        date.font = UIFont(name: "UbuntuTitling-Bold", size: 16)
        date.textColor = UIColor.redColor()
        //date.textAlignment = da
        date.frame.origin.x += 150
        date.frame.origin.y += 10
        cell.courses.text = content.department[indexPath.item]
        cell.className.text = content.name[indexPath.item]
        cell.attendees.text = content.numStudents[indexPath.item]
        
        //parse time
        let str = content.start_t[indexPath.item]
        var sts = str.componentsSeparatedByString("T")
        let time = sts[1]
        let dtr = sts[0].componentsSeparatedByString("-")
        let dtrs = "Date: \(dtr[1])-\(dtr[2])"
        var timeparse = time.componentsSeparatedByString(":")
        
        //parse date
        
        cell.start_time.text = "\(timeparse[0]):\(timeparse[1])"
        cell.LLocation.text = content.location[indexPath.item]
//        cell.sponsored.text = content.faculty[indexPath.item]
        cell.imageR = UIImageView(image: UIImage(named: content.image_name[indexPath.item]))
        cell.ex_full_course.text = "\(content.department[indexPath.item]) \(content.course[indexPath.item])"
        cell.username.text = content.organizer[indexPath.item]
        cell.eeDescrip.text = content.edescription[indexPath.item]
        cell.coursnumero.text = content.course[indexPath.item]
        cell.ex_location.text = content.location[indexPath.item]
        cell.ex_time.text = "\(timeparse[0]):\(timeparse[1])"
        cell.ex_date.text = "\(dtrs)"
        cell.ex_attendees.text = content.numStudents[indexPath.item]

        
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("fk")
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table vie delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)

    }
    
    
    
}
