import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON


class Memo: Mappable {
    
    
    var id:Int?
    var title: String?
    var body: String?
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    required init?(map: Map) {
        
    }
    
    //rails側のデータモデルとマッピング
    func mapping(map: Map) {
        id    <- map["id"]
        title <- map["title"]
        body  <- map["body"]
    }
    
    //メモ一覧の取得
   class func getMemos(success success: @escaping ([Memo]) -> Void, failure: @escaping (NSError?) -> Void) {
    
    let urlString = "http://rails-memo-sogawa.c9users.io:8080/memos.json"
      
    //getリクエストでrailsのデータベースからJson形式のメモデータ一覧を取得
    Alamofire.request(urlString,method: .get, encoding: JSONEncoding.default).responseJSON { response in  if let error = response.result.error {
                failure(error as NSError?)
                return
            }
         //SwiftyJsonで取得したJson形式のデータを読み込む                                                                               
        let json = JSON(response.result.value!)
         //mapメソッドでJsonオブジェクト形式のmemoをMemoモデルに変換してmemosに格納                                                                                  
        let memos: [Memo] = json.arrayValue.map{memoJson -> Memo in
            return Mapper<Memo>().map(JSON: memoJson.dictionaryObject!)!
            }
            success(memos)
            print("Did not receive json")
            return
      }
    }
    
    //メモを新規作成　(返り値は利用しない)
    func createMemo(success success: @escaping ([Memo]) -> Void, failure: @escaping (NSError?) -> Void) {
        　
        //入力された値を格納
        let params: Parameters = [
            "title" : self.title! as AnyObject,
            "body"  : self.body! as AnyObject
        ]
        
        let urlString = "http://rails-memo-sogawa.c9users.io:8080/memos.json"
        //postメソッドでparamsを引数にしてrailsデータベースに格納
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{ response in
            if let json = response.result.value {
                print("JSON: \(json)")
                return
            }
            return
            print("Did not receive json")
        }
        
    }
    
    //メモを削除(返り値は利用しない)
    func deleteMemo(success success: @escaping (Void) -> Void, failure: (NSError?) -> Void) {
        
        //deleteメソッドで、メモのIDを含んだAPIにアクセス
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
