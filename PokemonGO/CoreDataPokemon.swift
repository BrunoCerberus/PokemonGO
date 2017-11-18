//
//  CoreDataPokemon.swift
//  PokemonGO
//
//  Created by Bruno Lopes de Mello on 14/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    //Recuperar context
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func recuperarPokemonsCapturados(capturado: Bool) -> [Pokemon] {
        let context = self.getContext()
        
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        requisicao.predicate = NSPredicate(format: "capturado = %@", capturado as CVarArg)
        
        do {
            let pokemons = try context.fetch(requisicao) as [Pokemon]
            return pokemons
        } catch let erro {
            print("Algo errado aconteceu: \(erro.localizedDescription)")
        }
        
        return []
    }
    
    //Recuperar todos os pokemons
    func recuperarTodosPokemons() -> [Pokemon]{
        let context = self.getContext()
        
        do {
            let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.adicionarTodosPokemons()
                return self.recuperarTodosPokemons()
            }
            
            return pokemons
        } catch let erro {
            print("Erro ao tentar carregar os pokemons: \(erro.localizedDescription)")
        }
        
        return []
    }
    
    func salvarPokemon(_ pokemon: Pokemon) {
        let context = self.getContext()
        pokemon.capturado = true
        
        do {
            try context.save()
        } catch let erro {
            print("Algo de errado aconteceu: \(erro.localizedDescription)")
        }
    }
    
    //Adicionar todos os pokemons
    func adicionarTodosPokemons() {
        
        let context = self.getContext()
        
        self.criarPokemon(nome: "Mew", nomeImagem: "mew", capturado: false)
        self.criarPokemon(nome: "Meowth", nomeImagem: "meowth", capturado: false)
        self.criarPokemon(nome: "Pikachu", nomeImagem: "pikachu-2", capturado: true)
        self.criarPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false)
        self.criarPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false)
        self.criarPokemon(nome: "Caterpie", nomeImagem: "caterpie", capturado: false)
        self.criarPokemon(nome: "Bullbasaur", nomeImagem: "bullbasaur", capturado: false)
        self.criarPokemon(nome: "Bellsprout", nomeImagem: "bellsprout", capturado: false)
        self.criarPokemon(nome: "Psyduck", nomeImagem: "psyduck", capturado: false)
        self.criarPokemon(nome: "Rattata", nomeImagem: "rattata", capturado: false)
        self.criarPokemon(nome: "Snorlax", nomeImagem: "snorlax", capturado: false)
        self.criarPokemon(nome: "Zubat", nomeImagem: "zubat", capturado: false)
        
        do {
            try context.save()
        } catch let erro {
            print("Nao foi possivel salvar os dados: \(erro.localizedDescription)")
        }
    }
    
    //Criar os Pokemons
    func criarPokemon(nome: String, nomeImagem: String, capturado: Bool) {
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeimagem = nomeImagem
        pokemon.capturado = capturado
    }
}
