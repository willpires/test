//
//  AlunoDao.swift
//  Agenda
//
//  Created by William Jose Pires on 19/06/2018.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import CoreData

class AlunoDao: NSObject {
    
    var gerenciadorDeResultados:NSFetchedResultsController<Aluno>?

    
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    func recuperaAlunos() ->Array<Aluno> {

        
        let pesquisaAluno:NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
        
       
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        guard let listaDeAlunos = gerenciadorDeResultados?.fetchedObjects else {return[]}
        return listaDeAlunos
    }
    
    func salvarAluno(dicionarioDeAluno:Dictionary<String,Any>){
        
        
        
        let aluno = Aluno(context:contexto )
    
     aluno.nome = dicionarioDeAluno["nome"] as? String
     aluno.endereco = dicionarioDeAluno["endereco"] as? String
     aluno.telefone = dicionarioDeAluno["telefone"]as? String
     aluno.site = dicionarioDeAluno["site"] as? String
        
        guard let nota = dicionarioDeAluno["nota"]else{return}
        
        if (nota is String){
            aluno.nota = (dicionarioDeAluno["nota"] as! NSString).doubleValue

        }else{
            let convertNota = String(describing: nota)
            aluno.nota = (convertNota as NSString).doubleValue
        }
 
        atualizaContexto()
    }
    func atualizaContexto(){
        
        do {
            try contexto.save()
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
