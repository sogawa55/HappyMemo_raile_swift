

import UIKit
import Foundation

class MemosViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet var memosTableView: UITableView!
    //ダミー
    var memos:[Memo] =  [Memo(title: "hoge", body: "hogehoge"),
                         Memo(title: "foo", body: "fooooo"),
                         Memo(title: "bar", body: "barbar")]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func click(_ sender: Any) {
        
    }

       
 override func viewDidLoad() {
    　　//registerメソッドでテーブルビューのセルを生成、再利用設定
        memosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    
 }
    

 //画面の表示直前に実行   
override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }
    
    
    func refreshData(){
    //クラスメソッドを実行
    Memo.getMemos(
    success: {(memos) -> Void in
    self.memos = memos.reversed()
    self.memosTableView.reloadData()
    print("起動")
    
    },
    failure: {(error) -> Void in
    // エラー処理
    print("起動")
    let alertController = UIAlertController(
    title: "エラー",
    message: "エラーメッセージ",
    preferredStyle: .alert)
    alertController.addAction(UIAlertAction(
    title: "OK",
    style: .default,
    handler: nil))
    self.present(alertController, animated: true, completion: nil)
    })
    
 }


//メモの数だけデーブルの行数を返す
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }

//デーブルの行ごとセルのセルを返す
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //識別子を利用して再利用可能なセルを取得する
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath as IndexPath)
    //行番号にあったメモのタイトルを取得
    let memo = memos[indexPath.row]
    //セルにタイトルを設定
    cell.textLabel?.text =  memo.title
    return cell

 }
    
    //セルを選択したら詳細画面に遷移
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetail",sender: nil)
    }
    
    
    //削除ボタンの表示
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let memo = self.memos[indexPath.row]
            
            //クラスメソッドの実行
            memo.deleteMemo(
                success: {
                    print("success delete")
                    //選択されたデータを削除
                    self.memos.remove(at: indexPath.row)
                    //選択された行を削除
                    tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            },
                failure: {(error) in
                    print(error)
                    print("fail delete")
            }
            )

        }
    }
    

    
    //画面遷移前に実行
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //遷移先の詳細画面をcontroller変数に格納
        guard let controller = segue.destination as?MemoDetailViewController else{
            return}
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.memosTableView.indexPathForSelectedRow {
                //選択されたセルの行番号を格納
                let memo = memos[indexPath.row]
                //MemoDetailViewContorollerのmemoプロパティに、選択されたセルのデータを格納
                controller.memo = memo
                //ナビゲーションボタンの変更
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    
}


    

    
