//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Pasha Bahadori on 9/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name: String!  //We know it exists so we unwrap it
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
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
