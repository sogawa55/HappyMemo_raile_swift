//
//  ViewController.swift
//  memo_app
//
//  Created by shohei on 2017/05/07.
//  Copyright © 2017年 ogawa.shoei. All rights reserved.
//

import UIKit




class MemoDetailViewController: UIViewController {
    
    var memo : Memo?
    
    

    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var bodyText: UILabel!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let memo = self.memo {
         
            titleText.text = memo.title
          
            bodyText.text = memo.body
    
        }

        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    


}

