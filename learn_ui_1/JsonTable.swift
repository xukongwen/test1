//
//  JsonTable.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/17.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit


//根据json的对应解包结构
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
    var fliterList = [SH_json]()
    let seacherCon = UISearchController(searchResultsController: nil)
    

    
    //自定义大字体导航栏
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 35)!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏大字体
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "伤寒论汤剂"
        
        //导航栏的颜色和返回的颜色
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)

        //自定义小字体导航栏
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 25)!]
        
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
        
        //搜索栏
        seacherCon.searchResultsUpdater = self as? UISearchResultsUpdating
        seacherCon.obscuresBackgroundDuringPresentation = false
        seacherCon.searchBar.placeholder = "关键词"
        
        
        navigationItem.searchController = seacherCon
        definesPresentationContext = true

        
        //搜索栏是否一直存在
        //navigationItem.hidesSearchBarWhenScrolling = false
        
        readJson()
        
    }
    
    
    //搜索相关func
    func searchBarIsEmputy () -> Bool{
        return seacherCon.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return seacherCon.isActive && !searchBarIsEmputy()
    }
    
    func fliterContentforSearcheText(_ searchText: String, scope: String = "All"){
        fliterList = fanglist.filter({( fang : SH_json) -> Bool in
            return (fang.name?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    //读取在线jason
    func readJson(){
        //从github读
        let urlString = "https://raw.githubusercontent.com/xukongwen/swift_learn/master/my_game_1/data/SH_ty2.json"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_json].self, from: data)
            
                    self.fanglist = oneJson
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
       //搜索的行数
        if isFiltering() {
            return fliterList.count
        }
        
        
        return fanglist.count //有多少行
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let fang : SH_json
        
        //搜索过滤
        if isFiltering() {
            fang = fliterList[indexPath.row]
        } else {
            fang = fanglist[indexPath.row]
        }
        //显示每个cell的内容
        cell.textLabel?.text = fang.name
        cell.detailTextLabel?.text = fang.text
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        cell.detailTextLabel?.font = UIFont.init(name: "STSong", size: 14)
        
        return cell
      
    }
    
    //点选了这个cell之后做什么
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fang: SH_json
        
        if isFiltering() {
            fang = fliterList[indexPath.row]
        } else {
            fang = fanglist[indexPath.row]
        }
        
        //推送
        performSegue(withIdentifier: "ListToFang", sender: fang)
        
    }
    //把内容推送到下一个iview
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListToFang" {
            let destVC = segue.destination as! fangDetailView
            destVC.fang = sender as? SH_json
        }
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

//检测搜索输入
extension JsonTable: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        fliterContentforSearcheText(seacherCon.searchBar.text!)
    }
}
