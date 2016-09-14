//
//  ViewController.swift
//  Pokedex3
//
//  Created by Pasha Bahadori on 9/12/16.
//  Copyright © 2016 Pelican. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemonArray = [Pokemon]()
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
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


  
    //COLLECTIONVIEW REQUIRED METHODS
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            //We show the pokemon we have in our array at that indexPath.row and then pass the Poke into the configureCell function to assign it's name and thumbImg
            let poke = pokemonArray[indexPath.row]
            cell.configureCell(poke)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //This returns how many objects in the Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

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
    
    

    
    
}

