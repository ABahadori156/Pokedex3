//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Pasha Bahadori on 9/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _pokemonURL: String!
    
    //SETTING THE GETTERS - We want to protect the data and we are providing an actual value or if the value is nil, app doesn't crash. 
    //When we request the data from the class, we are getting an actual value OR if there isn't a value, instead of nil we'll get an empty string
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    //So now whenever we create a Pokemon, we also want to create the API URL
    //The API works off each individual Pokemon so at the end of the url it's something like http://pokeapi.co/api/v1/pokemon/1 and that'd be for Bulbasaur. We use the pokedexID we get from the pokemon.csv and the integers are the same for Pokemon on the pokeapi.co API
    
    //Whenever we click on one of the Pokemon, and we go to the detailVC, it's then where we want to make the network call and pull down that data. This is called LAZY LOADING - alternative to making 718 network calls for all Pokemon off the bat
    
    //Network calls are asynchronous, meaning we don't know when the network tasks will be completed
    //So in the detailVC, we can't just start setting the labels to those variables because it would crash because they aren't immediately available on viewDidLoad
    //So we want to have a way to let the ViewController know when that network call data will be available - we do that using a closure
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL, method: .get).responseJSON { response in
            
            //Here we create an object dict that contains the entire JSON we pulled for the Pokemon's details
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                //TYPE OF POKEMON
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
               
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    //IF MORE THAN 1 TYPE OF POKEMON ..
                    if types.count > 1 {
                        //Loop through the rest of the types
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                } else {
                    self._type = ""
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
            }
         completed()
        }
    }
}
