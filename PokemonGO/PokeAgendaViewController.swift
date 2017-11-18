//
//  PokeAgendaViewController.swift
//  PokemonGO
//
//  Created by Bruno Lopes de Mello on 17/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let coreData = CoreDataPokemon()
        self.pokemonsCapturados = coreData.recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCapturados = coreData.recuperarPokemonsCapturados(capturado: false)
        
        print(self.pokemonsNaoCapturados.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Capturados"
        } else {
            return "Nao Capturados"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.pokemonsCapturados.count
        } else {
            return self.pokemonsNaoCapturados.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon: Pokemon
        if indexPath.section == 0 {
            pokemon = self.pokemonsCapturados[indexPath.row]
        } else {
            pokemon = self.pokemonsNaoCapturados[indexPath.row]
        }
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "reuseCell")
        cell.textLabel?.text = pokemon.nome
        cell.imageView?.image = UIImage(named: pokemon.nomeimagem!)
        return cell
    }
    
    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
