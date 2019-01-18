//
//  fangDetailView.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/18.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class fangDetailView: UIViewController {

    
    @IBOutlet var fangtext: UITextView!
    
    var fang: SH_json?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = fang?.name
        navigationItem.largeTitleDisplayMode = .automatic
        
        setupText()

        // Do any additional setup after loading the view.
    }
    
    
    func setupText() {
        //fangname.text = fang?.name
        fangtext.text = fang?.text
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
