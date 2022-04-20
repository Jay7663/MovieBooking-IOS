//
//  HomeScreenViewModel.swift
//  MovieBooking
//
//  Created by Yagnik Bavishi on 14/04/22.
//

import Foundation
import Alamofire

class HomeScreenViewModel {
    
    var fetchedMoiveData = [Result]()
    var movieData: (([Result]) -> Void)?
    var dataLoaded: (() -> Void)?
    var error: (() -> Void)?
    
    func getMovieData() {
        fetchedMoiveData = []
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2572f31f3da77472a4d8e2db674cbd71&page=1") {
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (response) in
                switch response.result {
                case .success(let responseData):
                    guard let userData = responseData else {
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let userResponse = try decoder.decode(MovieData.self, from: userData)
                        for index in userResponse.results {
                            self.fetchedMoiveData.append(Result(adult: index.adult, backdropPath: index.backdropPath, genreIDS: index.genreIDS, id: index.id, originalLanguage: index.originalLanguage, originalTitle: index.originalTitle, overview: index.overview, popularity: index.popularity, posterPath: index.posterPath, releaseDate: index.releaseDate, title: index.title, video: index.video, voteAverage: index.voteAverage, voteCount: index.voteCount))
                        }
                        self.movieData?(self.fetchedMoiveData)
                        self.dataLoaded?()
                    } catch {
                        self.error?()
                    }
                case .failure(_):
                    self.error?()
                }
            }
        }
    }
    
}// End of Class
