//
//  DetailViewController.swift
//  Desafio ITBAM
//
//  Created by william monteiro on 01/07/19.
//  Copyright © 2019 william monteiro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detail: NSDictionary?

    @IBOutlet weak var tudo: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tudo.text = ("\(String(describing: detail))")
    }
    



}
