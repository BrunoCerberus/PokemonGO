//
//  PokemonAnotacao.swift
//  PokemonGO
//
//  Created by Bruno Lopes de Mello on 15/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon!
    
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
    
}
