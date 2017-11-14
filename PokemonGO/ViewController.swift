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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
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

