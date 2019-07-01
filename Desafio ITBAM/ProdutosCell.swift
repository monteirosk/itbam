//
//  ProdutosCell.swift
//  Desafio ITBAM
//
//  Created by william monteiro on 30/06/19.
//  Copyright © 2019 william monteiro. All rights reserved.
//

import UIKit

class ProdutosCell: UITableViewCell {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var preco: UILabel!
    
    @IBOutlet weak var tost: UIButton!
    
    func setProd (produto : NSArray) {
        titulo.text = (produto[0] as AnyObject).name
        
    }
    
    
}
