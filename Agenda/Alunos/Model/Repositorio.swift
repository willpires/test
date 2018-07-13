//
//  Repositorio.swift
//  Agenda
//
//  Created by William Jose Pires on 19/06/2018.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    func recuperaAlunos(completion:@escaping(_ listaDeAlunos:Array<Aluno>) -> Void){
        
        var alunos = AlunoDao().recuperaAlunos()
        
        if alunos.count == 0 {
            AlunoApi().recuperaAlunos(){
                alunos = AlunoDao().recuperaAlunos()
                completion(alunos)
            }
        } else{
            completion(alunos)
        }
    }
    func salvarAluno(aluno:Dictionary<String,String>){
        
        AlunoApi().salvaAlunoNoServidor(parametros:[aluno] )
        AlunoDao().salvarAluno(dicionarioDeAluno: aluno)
        

    }

}
