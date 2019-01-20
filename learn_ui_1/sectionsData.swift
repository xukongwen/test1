
import Foundation
import UIKit

struct SH_book_data: Decodable {
    let ID: Int?
    let text: String?
    let height: Int?
    
}

struct SH_book: Decodable {
    let section: Int?
    let data: [SH_book_data?]
    let header: String?
}

struct Section {
    var name: String
    var items: [SH_book]
    var collapsed: Bool
    
    init(name: String, items: [SH_book], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

struct Section_jk {
    var name: String
    var items: [SH_json]
    var collapsed: Bool
    
    init(name: String, items: [SH_json], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}




//func readFileJson_book(jsonFile: String, table: yuanwenTableViewController) -> [Section] {
//
//    var bookList = [SH_book]()
//
//    let sectionsData: [Section] = [
//    Section(name: "序言", items: bookList)
//
//    ]
//
//
//    guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
//        let data = try? Data.init(contentsOf: fileURL) else{
//            fatalError("`JSON File Fetch Failed`")
//    }
//
//    URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
//        DispatchQueue.main.async {
//            guard let data = data else { return }
//
//            do {
//                let oneJson = try JSONDecoder().decode([SH_book].self, from: data)
//
//                bookList = oneJson
//                //print(self.bookList[8].data.count)
//                table.tableView.reloadData()
//            } catch let jsonErr {
//                print(jsonErr)
//            }
//        }
//
//        }.resume()
//
//    return sectionsData
//
//}

