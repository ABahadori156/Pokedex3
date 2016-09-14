//
//  ViewController.swift
//  Pokedex3
//
//  Created by Pasha Bahadori on 9/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        //This turns the return key to done
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    
    //AUDIO FUNCTION
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch {
            
        }
    }
    
    //POKEMON DATA - THIS WILL PARSE THE POKEMON DATA FROM THE CSV.SWIFT JSON-LOOKING FILE
    func parsePokemonCSV() {
        //Here we create a path to the csv.swift file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            //We're going to use the parser, but it could produce an error so we'll do a do-catch
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
                // We want to pull out the data from the CSV.SWIFT, we want the PokeID and the name. We loop through each row and pull out the data and create a new Pokemon class and append that to new array Pokemon we created on this VC
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemonArray.append(poke)
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }

    //SEARCH BAR METHOD - To end the keyboard when we're finished searching for the pokemon
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    //Whenever you type in the search bar, every keystroke we make, we are filtering to see if what we are typing for exists
    //We need a method for whenever a keystroke is made
    //SEARCH BAR METHOD
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //When we aren't searching for anything, we want it to show the full list of Pokemon
        //When we search, we want it to show a different  group of pokemon
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            //Take the string in the search bar and compare it with all of the pokemon object names. If what we have in the search bar is included, then we put it in the new filtered pokemon array and siplay that one
            let lower = searchBar.text!.lowercased()
            
            //Here we say the filtered pokemon list is going to be equal to the original pokemon array which is being filtered by using a $0 which is a placeholder for any or all the objects in the original pokemon array 
            // We're saying each pokemon object, which is our placeholder for our $0, we're taking the name value of that and we're saying "is what we typed in the search bar contained inside of that name and if it is, then we're going to put that object in the filtered pokemon list
            filteredPokemonArray = pokemonArray.filter({$0.name.range(of: lower) != nil})
            
            collectionView.reloadData()
        }
    }
    
  
    //COLLECTIONVIEW REQUIRED METHODS
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            //We show the pokemon we have in our array at that indexPath.row and then pass the Poke into the configureCell function to assign it's name and thumbImg
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemonArray[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemonArray[indexPath.row]
                cell.configureCell(poke)
            }
            
            
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemonArray[indexPath.row]
        } else {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    //This returns how many objects in the Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemonArray.count
        }
        
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    
    //MUSIC BUTTON FUNCTION
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            //When it's playing, it's fully opaque. When it's paused, it's transparent
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    //SEGUEWAY
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //This happens before the segue occurs, how we pass data between VC's
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemonDetail = poke
                }
            }
        }
    }
    

    
    
}

