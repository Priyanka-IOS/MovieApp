//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import Foundation

class MovieViewModel {
    var movies: [MoviesModelData] = []
    var sections: [Section] = []
    
    init() {
        loadMovies()
        initializeSections()
    }
    
    private func loadMovies() {
        movies = LocalFetchedDataManager.shared.readJSONFromFile(fileName: "movies", type: [MoviesModelData].self) ?? []
    }
    
    private func initializeSections() {
        let years = Array(Set(movies.map { $0.year })).sorted()
        let genres = Array(Set(movies.map { $0.genre })).sorted()
        let directors = Array(Set(movies.map { $0.director })).sorted()
        let actors = Array(Set(movies.map { $0.actors })).sorted()
        
        sections = [
            Section(title: .year, isExpanded: false, items: years),
            Section(title: .genre, isExpanded: false, items: genres),
            Section(title: .directors, isExpanded: false, items: directors),
            Section(title: .actors, isExpanded: false, items: actors),
            Section(title: .allMovies, isExpanded: false, items: movies.map { $0.title })
        ]
    }
    
    func filterMovies(by searchText: String) -> [MoviesModelData] {
        return movies.filter { movie in
            movie.title.lowercased().contains(searchText.lowercased()) ||
            movie.genre.lowercased().contains(searchText.lowercased()) ||
            movie.director.lowercased().contains(searchText.lowercased()) ||
            movie.actors.lowercased().contains(searchText.lowercased())
        }
    }
    func getMoviesData(sectionTitle: SectionTitle, item: String)-> MoviesModelData? {

        let movie: MoviesModelData?

        switch sectionTitle {
        case .allMovies:
             movie = movies.first { $0.title == item }
        case .actors:
             movie = movies.first { $0.actors == item }
        case .year:
             movie = movies.first { $0.year == item }
        case .genre:
             movie = movies.first { $0.genre == item }
        case .directors:
             movie = movies.first { $0.director == item }
        }
        return movie
    }
}
