//
//  MemosViewController.swift
//  memo_app
//
//  Created by shohei on 2017/05/07.
//  Copyright © 2017年 ogawa.shoei. All rights reserved.
//

import UIKit
import Foundation

class MemosViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet var memosTableView: UITableView!
    
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
    
        memosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    
 }
    
    

    

    
override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }
    
    
    func refreshData(){
    
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



    
    
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath as IndexPath)
    
    let memo = memos[indexPath.row]
    cell.textLabel?.text =  memo.title
    
    return cell

 }
    
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetail",sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let memo = self.memos[indexPath.row]
            

            memo.deleteMemo(
                success: {
                    print("success delete")
                    self.memos.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            },
                failure: {(error) in
                    print(error)
                    print("fail delete")
            }
            )

        }
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let controller = segue.destination as?MemoDetailViewController else{
            return}
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.memosTableView.indexPathForSelectedRow {
                let memo = memos[indexPath.row]
                controller.memo = memo
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    
}


    

    
