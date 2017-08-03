import UIKit


class MemoDetailViewController: UIViewController {
    
    var memo : Memo?
    
    //タイトルテキストをOutlet接続
    @IBOutlet weak var titleText: UILabel!
    //本文テキストをOutlet接続
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

