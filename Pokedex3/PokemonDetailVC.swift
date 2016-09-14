//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Pasha Bahadori on 9/13/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemonDetail: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemonDetail.name.capitalized
        
    }

  

}
