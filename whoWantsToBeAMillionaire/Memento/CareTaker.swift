//
//  CareTaker.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
//

import Foundation

class CareTaker<T: Codable> {
     private let decoder = JSONDecoder()
     private let encoder = JSONEncoder()
     private var key: String { return String(describing: T.self) }

    //As UserDefaults can only store binaries,
    //we create a binary by encoding data
    func save(data: T) throws {
         let data = try encoder.encode(data)
         UserDefaults.standard.set(data, forKey: key)
     }

    //As UserDefaults can only store binaries,
    //we retrieve a binarym an then decode it,
    //pretty much as we have decoded a remote server's JSON earlier
    func load() throws -> T? {
         guard let data = UserDefaults.standard.value(forKey: key) as? Data,
               let decodedData = try? decoder.decode(T.self,
                                                     from: data)
         else {
             return nil
         }
         return decodedData
     }
 }
