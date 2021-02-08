//
//  NetworkService.swift
//  beautifulTasks
//
//  Created by José João Silva Nunes Alves on 08/02/21.
//

import Foundation

struct BoredRequest {
    let resourceURL: URL
    let apiKey: String = ""

    init() {
        let resouceString = "http://www.boredapi.com/api/activity?type=busywork"

        guard let resourceURL = URL(string: resouceString) else {
            fatalError("\(BoredAPIError.cantBuildURL)")
        }

        self.resourceURL = resourceURL
    }

    func getBoredTask(completion: @escaping(Result<BoredTask, BoredAPIError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: self.resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let boredResponse = try decoder.decode(BoredTask.self, from: jsonData)
                completion(.success(boredResponse))
            } catch {
                completion(.failure(.cantProcessData))
            }
        }
        dataTask.resume()
    }
}
