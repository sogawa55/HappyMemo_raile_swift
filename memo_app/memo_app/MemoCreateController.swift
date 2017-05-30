//
//  MemoCreateController.swift
//  memo_app
//
//  Created by shohei on 2017/05/08.
//  Copyright © 2017年 ogawa.shoei. All rights reserved.
//

import UIKit
import Foundation

class MemoCreateController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var inputTitle: UITextField!


    @IBOutlet weak var inputBoby: UITextField!
    
 
    @IBAction func tapScreen(_ sender: Any) {
        
         self.view.endEditing(true)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputTitle.delegate = self
        inputBoby.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func clickButton(_ sender: Any) {
        

        
        if inputTitle.text != "" && inputBoby.text != "" {
            let inTitle = inputTitle.text!
            let inBody  = inputBoby.text!
            
            let memo = Memo(title: inTitle, body: inBody)
            memo.createMemo(
                success: {_ in 
                    print("success create")
            },
                failure: {(error) in
                    print("fail create")
            }

            )
            
    }
        
  }
}
