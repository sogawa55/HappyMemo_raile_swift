//
//  Memo.swift
//  memo_app
//
//  Created by shohei on 2017/05/07.
//  Copyright © 2017年 ogawa.shoei. All rights reserved.
//

import UIKit


import Alamofire
import ObjectMapper
import SwiftyJSON



class Memo: Mappable, CustomStringConvertible {
    
    
    var id:Int?
    var title: String?
    var body: String?
    
    var description: String {
        return "title: \(self.title), body: \(self.body)"
    }
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        body  <- map["body"]
    }
    
    
   class func getMemos(success success: @escaping ([Memo]) -> Void, failure: @escaping (NSError?) -> Void) {
    
    let urlString = "http://rails-memo-sogawa.c9users.io:8080/memos.json"
    Alamofire.request(urlString,method: .get, encoding: JSONEncoding.default).responseJSON { response in  if let error = response.result.error {
                failure(error as NSError?)
                return
            }
        let json = JSON(response.result.value!)
        let memos: [Memo] = json.arrayValue.map{memoJson -> Memo in
            return Mapper<Memo>().map(JSON: memoJson.dictionaryObject!)!
            }
            success(memos)
            print("Did not receive json")
            return
      }
    }
    
    
    func createMemo(success success: @escaping ([Memo]) -> Void, failure: @escaping (NSError?) -> Void) {
        
        let params: Parameters = [
            "title" : self.title! as AnyObject,
            "body"  : self.body! as AnyObject
        ]
        
        let urlString = "http://rails-memo-sogawa.c9users.io:8080/memos.json"
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ response in
            if let json = response.result.value {
                print("JSON: \(json)")
                return
            }
            return
            print("Did not receive json")
        }
        
    }
    
    func deleteMemo(success success: @escaping (Void) -> Void, failure: (NSError?) -> Void) {
        
        Alamofire.request("http://rails-memo-sogawa.c9users.io:8080/memos/\(self.id!).json", method: .delete,encoding: JSONEncoding.default) .responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)")
                return
            }
            success()
            return
        }
    }
    
}
