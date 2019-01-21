//
//  shoucangTableViewController.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/21.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class shoucangTableViewController: UITableViewController{
    
    var shoucang = [SH_json]()
    var isShow = false
    //var heihei = JsonTable()
    
//    func didImportantFlag(fang: SH_json) {
//        shoucang.append(fang)
//        if isShow == true{
//            tableView.reloadData()
//        }
//        print(shoucang.count)
//    }

    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 35)!]

    override func viewDidLoad() {
        super.viewDidLoad()
//        heihei.delegate = self

    
        //self.tableView.reloadData()
        //设置导航栏大字体
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "收藏"
        
        //导航栏的颜色和返回的颜色
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        //自定义小字体导航栏
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 25)!]
        
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
        tableView.reloadData()
        //print(shoucang)
        self.isShow = true
        //print("show:",isShow)
       
    }
    
    
    
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        print("now:",shoucang.count)
        return shoucang.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let fang: SH_json
        
        
        fang = shoucang[indexPath.row]
        cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        //print(fang.name!)


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension shoucangTableViewController: ImportantFlag {
    func didImportantFlag(fang: SH_json) {
        self.shoucang.append(fang)
        //print(isShow)
        if isShow == true{
            self.tableView.reloadData()
            print("update")
        }
        print("adding this:",fang.name!)
    }
}


