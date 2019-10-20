//
//  TheMoviedbClient.swift
//  Flixster
//
//  Created by Julio Cesar Whatley on 10/17/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

class TheMoviedbClient {
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
//                do {
//                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data) as Error
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
//                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func getMovies(completion: @escaping ([MovieResult], Error?) -> Void) -> Void {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let _ = taskForGETRequest(url: url, responseType: MoviedbResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func getImgUrl(imgSize: String, imgPath: String) -> URL {
        let imgPathUrl = "https://image.tmdb.org/t/p/" + imgSize + imgPath
        let imgUrl = URL(string: imgPathUrl)
        return imgUrl!
    }
    
    class func getSuperheroeMovies(completion: @escaping ([MovieResult], Error?) -> Void) -> Void {
       let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
       
       let _ = taskForGETRequest(url: url, responseType: MoviedbResponse.self) { response, error in
           if let response = response {
               completion(response.results, nil)
           } else {
               completion([], error)
           }
       }
   }

    class func getMovieVideo(videoId: Int, completion: @escaping ([VideoResult], Error?) -> Void) -> Void {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(videoId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
        let _ = taskForGETRequest(url: url, responseType: VideoResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }

    
}
