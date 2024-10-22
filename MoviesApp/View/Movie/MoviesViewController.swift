//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import UIKit
import SDWebImage

// ViewController for displaying a list of movies
class MoviesViewController: UIViewController {
    
    // Outlets for UI components
    @IBOutlet weak var moviesTableView: UITableView!
    
    // Search bar for filtering movies
    var searchBar: UISearchBar!
    var viewModel: MovieViewModel!
    var filteredMovies: [MoviesModelData] = []
    var isSearching = false
    
    // Lifecycle method called when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieViewModel() // Initialize the ViewModel
        setupUI() // Set up the user interface
    }
    
    // Function to configure the user interface
    func setupUI() {
        // Initialize and configure the search bar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = Constants.searchPlaceholderImg
        navigationItem.titleView = searchBar
        
        // Configure the table view
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.separatorStyle = .none
        moviesTableView.register(UINib(nibName: Constants.moviesCellId, bundle: nil), forCellReuseIdentifier: Constants.moviesCellId)
    }
}

// MARK: - TableView Delegate & DataSource
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    // Return number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : viewModel.sections.count
    }
    
    // Return number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMovies.count : (viewModel.sections[section].isExpanded ? viewModel.sections[section].items.count : 0)
    }
    
    // Configure and return the cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.moviesCellId, for: indexPath) as? MoviesTableViewCell
        
        if isSearching {
            // Populate cell with filtered movie data
            let movie = filteredMovies[indexPath.row]
            cell?.movieNameLbl.text = movie.title
            cell?.languageLbl.text = movie.language
            cell?.movieReleaseYearLbl.text = movie.year
            cell?.moviesImgView.sd_setImage(with: URL(string: movie.poster), placeholderImage: UIImage(named: Constants.placeholderImg))
        } else {
            // Populate cell with movie data from the section
            let section = viewModel.sections[indexPath.section]
            let item = section.items[indexPath.row]
            let movie = viewModel.getMoviesData(sectionTitle: section.title, item: item)
            cell?.movieNameLbl.text = movie?.title
            cell?.languageLbl.text = movie?.language
            cell?.movieReleaseYearLbl.text = movie?.year
            cell?.moviesImgView.sd_setImage(with: URL(string: movie?.poster ?? String()), placeholderImage: UIImage(named: Constants.placeholderImg))
        }
        return cell ?? UITableViewCell() // Return a default cell if nil
    }
    
    // Configure the header for each section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSearching { return nil } // No header when searching
        
        let headerView = UITableViewHeaderFooterView()
        headerView.textLabel?.text = viewModel.sections[section].title.rawValue
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpandCollapse)))
        headerView.tag = section
        return headerView
    }
    
    // Return height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Fixed height for movie cells
    }
    
    // Handle expanding and collapsing of sections
    @objc func handleExpandCollapse(gestureRecognizer: UITapGestureRecognizer) {
        guard let section = gestureRecognizer.view?.tag else { return }
        viewModel.sections[section].isExpanded.toggle() // Toggle expansion state
        moviesTableView.reloadSections(IndexSet(integer: section), with: .automatic) // Reload section
    }
    
    // Handle selection of a movie cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.movieDetailVC) as! MovieDetailViewController
        
        if isSearching {
            // Pass selected movie to detail view controller when searching
            let movie = filteredMovies[indexPath.row]
            detailVC.movie = movie
        } else {
            // Pass selected movie to detail view controller from sections
            let section = viewModel.sections[indexPath.section]
            let item = section.items[indexPath.row]
            let movie = viewModel.getMoviesData(sectionTitle: section.title, item: item)
            detailVC.movie = movie
        }
        
        navigationController?.pushViewController(detailVC, animated: true) // Navigate to detail view
    }
}

// MARK: - SearchBar Delegate
extension MoviesViewController: UISearchBarDelegate {
    // Handle text changes in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false // Reset search state
            filteredMovies.removeAll() // Clear filtered movies
        } else {
            isSearching = true // Set searching state
            filteredMovies = viewModel.filterMovies(by: searchText) // Filter movies based on search text
        }
        moviesTableView.reloadData() // Reload table view data
    }
}
