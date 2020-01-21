//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Begüm Üner on 21.01.2020.
//  Copyright © 2020 Begüm Üner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getButton(_ sender: Any) {
        
        // 1) request & session  (web adresine gitmek,istek yollamak)
        // 2) response & data  (o istegi veya datayi almak)
        // 3) parsing & JSON serialization (o datayi islemek)
        
        
        //1.adim
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=37381f6be5bc25559393ce9dbb6b6159")
        
        //closure
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true, completion: nil)
                }else
            { // 2. adim
                if data != nil {
                    
                    do {
                         let jsonresponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            
                            if let dic = jsonresponse["rates"] as? [String : Any] {
                                if let usd = dic["USD"] as? Double
                                {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let cad = dic["CAD"] as? Double
                                {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let gbp = dic["GBP"] as? Double
                                {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let tl  = dic["TRY"] as? Double
                                {
                                    self.tryLabel.text = "TRY: \(tl)"
                                }
                            
                            }
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        task.resume()
    }
    
}

