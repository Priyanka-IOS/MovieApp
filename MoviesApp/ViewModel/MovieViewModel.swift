//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import Foundation

// ViewModel for managing movie data
class MovieViewModel {
    // Array to hold movie data
    var movies: [MoviesModelData] = []
    // Sections for categorizing movies
    var sections: [Section] = []
    
    // Initializer
    init() {
        loadMovies() // Load movies from data source
        initializeSections() // Set up sections for display
    }
    
    // Function to load movies from local JSON file
    private func loadMovies() {
        // Reads JSON file and populates movies array
        movies = LocalFetchedDataManager.shared.readJSONFromFile(fileName: "movies", type: [MoviesModelData].self) ?? []
    }
    
    // Function to initialize sections based on movie data
    private func initializeSections() {
        // Extract unique years, genres, directors, and actors
        let years = (Set(movies.map { $0.year })).sorted()
        let genres = (Set(movies.map { $0.genre })).sorted()
        let directors = (Set(movies.map { $0.director })).sorted()
        let actors = (Set(movies.map { $0.actors })).sorted() // Use flatMap to handle multiple actors
        
        // Create sections with the extracted data
        sections = [
            Section(title: .year, isExpanded: false, items: years),
            Section(title: .genre, isExpanded: false, items: genres),
            Section(title: .directors, isExpanded: false, items: directors),
            Section(title: .actors, isExpanded: false, items: actors),
            Section(title: .allMovies, isExpanded: false, items: movies.map { $0.title })
        ]
    }
    
    // Function to filter movies based on search text
    func filterMovies(by searchText: String) -> [MoviesModelData] {
        // Filter movies based on title, genre, director, or actors containing the search text
        return movies.filter { movie in
            movie.title.lowercased().contains(searchText.lowercased()) ||
            movie.genre.lowercased().contains(searchText.lowercased()) ||
            movie.director.lowercased().contains(searchText.lowercased()) ||
            movie.actors.lowercased().contains(searchText.lowercased())
        }
    }
    
    // Function to retrieve movie data based on section title and item
    func getMoviesData(sectionTitle: SectionTitle, item: String) -> MoviesModelData? {
        let movie: MoviesModelData?

        // Match the movie based on the section title
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
