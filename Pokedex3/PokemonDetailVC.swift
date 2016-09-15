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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemonDetail.name.capitalized
        
        let img = UIImage(named: "\(pokemonDetail.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokedexLbl.text = "\(pokemonDetail.pokedexId)"
        
        pokemonDetail.downloadPokemonDetail {
          

            //Whatever we write will only be called after the network call is complete!
            //Whenever the data is available, we want to update the UI to have that data
            self.updateUI()
        }
    }
    
    func updateUI() {
        //We have the data now so let's update the properties
        self.attackLbl.text = self.pokemonDetail.attack
        self.defenseLbl.text = self.pokemonDetail.defense
        self.heightLbl.text = self.pokemonDetail.height
        self.weightLbl.text = self.pokemonDetail.weight
        self.pokedexLbl.text = "\(self.pokemonDetail.pokedexId)"
        self.typeLbl.text = self.pokemonDetail.type
        
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
  

}

//Network calls are asynchronous, meaning we don't know when the network tasks will be completed
//So in the detailVC, we can't just start setting the labels to those variables because it would crash because they aren't immediately available on viewDidLoad
//So we want to have a way to let the ViewController know when that network call data will be available - we do that using a closure
