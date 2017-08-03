

import UIKit
import Foundation

class MemoCreateController: UIViewController, UITextFieldDelegate{
     
    //タイトル入力欄をOutlet接続
    @IBOutlet weak var inputTitle: UITextField!

　　//本文入力欄をOutlet接続
    @IBOutlet weak var inputBoby: UITextField!
    
 　　//画面をタップして入力画面を終了
    @IBAction func tapScreen(_ sender: Any) {
        
         self.view.endEditing(true)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //textFiel の情報を受け取るための delegate を設定
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
            
            //入力された値を引数にMemoクラスをインスタンス化
            let memo = Memo(title: inTitle, body: inBody)
            //Memoクラスメソッドを実行
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
