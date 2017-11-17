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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
