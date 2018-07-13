//
//  AlunoApi.swift
//  Agenda
//
//  Created by William Jose Pires on 19/06/2018.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
class AlunoApi: NSObject {
    //MARK: - GET
    
    func recuperaAlunos(completion:@escaping() -> Void){
        
        
        Alamofire.request("http://localhost:8080/api/aluno").responseJSON { (resposta) in
            print(resposta)
            switch  resposta.result {
                
            case .success:
                if let respostaConvert = resposta.result.value as? Dictionary<String,Any>{
                    guard let listaAlunos = respostaConvert["aluno"] as? Array<Dictionary<String,Any>>else{return}
                    for dicionarioDeAluno in listaAlunos{
                        AlunoDao().salvarAluno(dicionarioDeAluno: dicionarioDeAluno)
                    }
                    completion()
                  
                }
                
                print(resposta.result.value!)
                break
                
            case .failure:
                
                print(resposta.error!)
                completion()
                break
                
            }
        }
    }
    
    func salvaAlunoNoServidor(parametros:Array<Dictionary<String,String>>){
        guard let url = URL(string: "http://localhost:8080/api/aluno/lista")else{return}
        
        
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        
        let json = try! JSONSerialization.data(withJSONObject: parametros, options:[])
        print("test2\(parametros)")
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao).responseJSON { (resposta) in
            print("test\(resposta)")
        }
      //  Alamofire.request(url, method: .put, parameters: parametros,encoding:JSONSerialization.default)
        //Alamofire.request(url, method: .put, parameters: parametros,enco)
            
            
            
        }
        
    
        
        
        
    
}
