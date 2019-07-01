//
//  ViewController.swift
//  Desafio ITBAM
//
//  Created by william monteiro on 28/06/19.
//  Copyright © 2019 william monteiro. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SDWebImage
import Toast_Swift
import NGSBadgeBarButton


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var pdd : NSArray?
    
    var detalhe: String?

    @IBOutlet weak var carro: UIBarButtonItem!
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var textButton:NGSBadgeBarButton!
    var imageButton:NGSBadgeBarButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Text Bar Button
        
        //info.png
        

        self.imageButton = NGSBadgeBarButton(badgeButtonWithTitle: "CR", target: self, selector: #selector(self.onClick(_:)))
        self.imageButton.badgeLabel.text = "6"
        
        self.navigationItem.rightBarButtonItems = [self.imageButton]
        
        self.textButton = NGSBadgeBarButton(badgeButtonWithTitle: "Menu", target: self, selector: #selector(self.menuonClick(_:)))
        
        self.navigationItem.leftBarButtonItems = [self.textButton]

        
        SVProgressHUD.show() // poe na tela o loader

        Alamofire.request("https://www.mocky.io/v2/59b6a65a0f0000e90471257d").responseJSON { response in

            
            if let JSON = response.result.value as? [String: Any] {
                self.pdd = (JSON["products"] as! NSArray)
                
                self.tableView.reloadData()
                
            }
            
        
            SVProgressHUD.dismiss()
        }

        }

    @objc func menuonClick(_ sender: Any?) {
        ToastManager.shared.isQueueEnabled = true
        self.navigationController?.view.makeToast("Clicou no menu")
    }
    
    
    @objc func onClick(_ sender: Any?) {
        ToastManager.shared.isQueueEnabled = true
        self.navigationController?.view.makeToast("Clicou no carrinho")
    }

}

let blogSegueIdentifier = "ShowBlogSegue"

// MARK: - Navigation





extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pdd?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pd : NSDictionary = self.pdd![indexPath.row] as! NSDictionary
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prodcell") as! ProdutosCell
        
        let imgURL : String = (pd["image"] as? String)!

        
        [cell.imagem.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))]        
        cell.titulo.text = pd["name"] as? String
        cell.preco.text = pd["actual_price"] as? String
        

        cell.tost.addTarget(self, action: #selector(ViewController.oneTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       self.detalhe = String(indexPath.row)
        
        print(self.detalhe)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "destination", sender: nil)
        
    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let vc = segue.destination as? DetailViewController {
            
            let someNumb: Int = Int(self.detalhe!)!
            
            let pd : NSDictionary = self.pdd![someNumb] as! NSDictionary
            
            print (pd)
            
            
            vc.detail = pd
        }
    }
    
    
    
    @objc func oneTapped(_ sender: Any?) {
        ToastManager.shared.isQueueEnabled = true
     self.navigationController?.view.makeToast("This is a piece of toast")
    }

    
    
}


