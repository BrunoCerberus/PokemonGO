//
//  ViewController.swift
//  PokemonGO
//
//  Created by Bruno Lopes de Mello on 13/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = coreDataPokemon.recuperarTodosPokemons()
        
        //Exibir Pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                
                let totalPokemons = self.pokemons.count
                let indicePokemonAleatorio = arc4random_uniform(UInt32(totalPokemons))
                
                let pokemon = self.pokemons[Int(indicePokemonAleatorio)]
                
                let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += (Double(arc4random_uniform(400)) - 200 ) / 100000.0
                anotacao.coordinate.longitude += (Double(arc4random_uniform(400)) - 200 ) / 100000.0
                
                self.mapa.addAnnotation(anotacao)
            }
        }
    }
    
    //Esse metodo executa toda vez que um marcador e posto no mapa
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            anotacaoView.image = #imageLiteral(resourceName: "player")
        } else {
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            anotacaoView.image = UIImage(named: (pokemon?.nomeimagem)!)
        }
        
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        anotacaoView.frame = frame
        
        return anotacaoView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            let Alerta = UIAlertController(title: "Permissao de localizacao", message: "Necessario permissao para acesso a" +
                " sua localizacao!! por favor habilite", preferredStyle: UIAlertControllerStyle.alert)
            
            let acoesConfiguracoes = UIAlertAction(title: "Abrir configuracoes", style: UIAlertActionStyle.default,
                                                   handler: { (alertaConfiguracoes) in
                                                    
                                                    if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
                                                        UIApplication.shared.open(configuracoes as URL)
                                                    }
            })
            
            let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.destructive, handler: nil)
            
            Alerta.addAction(acoesConfiguracoes)
            Alerta.addAction(cancelar)
            
            present(Alerta, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        let localizacao = locations.last!
//
//        exibirLocal(localizacao.coordinate.latitude, localizacao.coordinate.longitude)
        
        self.centralizar()
        gerenciadorLocalizacao.stopUpdatingLocation()
        
    }
    
//    private func exibirLocal(_ latitude: Double,_ longitude: Double) {
//        let latitudeDelta : CLLocationDegrees = 0.05
//        let longitudeDelta : CLLocationDegrees = 0.05
//
//        let aproximacao : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
//        let coordenadas : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//        let regiao : MKCoordinateRegion = MKCoordinateRegion(center: coordenadas, span: aproximacao)
//
//        self.mapa.setRegion(regiao, animated: true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func centralizar() {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
            let regiao = MKCoordinateRegionMakeWithDistance(coordenadas, 200, 200)
            mapa.setRegion(regiao, animated: true)
        }
    }
    
    @IBAction func centralizarJogador(_ sender: Any) {
        self.centralizar()
    }
    
    @IBAction func abrirPokedex(_ sender: Any) {
    }
    
    
}

