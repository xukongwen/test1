//
//  JsonTable.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/17.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

struct JsonTest: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    //let number_of_lessons: Int
}

struct Yao: Decodable {
    let amount: String?
    let yaoID: Int?
    let weight: Int?
    let showName: String?
    let extraProcess: String?
}

struct SH_json: Decodable {
    let yaoCount: Int?
    let drinkNum: Int?
    let height: Int?
    let standardYaoList: [Yao?]
    let text: String?
    let fangList: [String?]
    let yaoList: [String?]
    let ID: Int?
    let name: String?
}


class JsonTable: UITableViewController {

    var fanglist = [SH_json]()
    
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.red,
                 NSAttributedString.Key.font: UIFont(name: "STSong", size: 21)!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "伤寒论"
        
        //self.navigationController!.navigationBar.barStyle = .black
        //self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)

        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "STSong", size: 25)!]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                        NSAttributedString.Key.font: UIFont(name: "STSong", size: 35)!]

        
        readJson()
        
    }
    
    func readJson(){
        let urlString = "https://raw.githubusercontent.com/hh-in-zhuzhou/ShangHanLunIOS/master/shangHanLun_iOS/data/shangHanFang.json"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_json].self, from: data)
            
                    self.fanglist = oneJson
                    //print(self.fanglist[1].standardYaoList[0]?.showName!)
                    self.tableView.reloadData()
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
    }

    // MARK: - Table view data source
    
   

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fanglist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let fang = fanglist[indexPath.row]
        cell.textLabel?.text = fang.name
        cell.detailTextLabel?.text = fang.text
        cell.textLabel?.font = UIFont.init(name: "STSong", size: 18)
        cell.detailTextLabel?.font = UIFont.init(name: "STSong", size: 14)
        
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
