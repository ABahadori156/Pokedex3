//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Pasha Bahadori on 9/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!  //We know it exists so we unwrap it
    private var _pokedexId: Int!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
    
    
}
