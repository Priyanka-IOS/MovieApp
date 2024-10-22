//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import UIKit
import SDWebImage

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var searchBar: UISearchBar!
    var viewModel: MovieViewModel!
    var filteredMovies: [MoviesModelData] = []
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieViewModel()
        setupUI()
    }
    func setupUI() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = Constants.searchPlaceholderImg
        navigationItem.titleView = searchBar
        //--
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.separatorStyle = .none
        moviesTableView.register(UINib(nibName: Constants.moviesCellId, bundle: nil), forCellReuseIdentifier: Constants.moviesCellId)
    }
}
//TableView Delegate & DataSource
extension MoviesViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMovies.count : (viewModel.sections[section].isExpanded ? viewModel.sections[section].items.count : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.moviesCellId, for: indexPath) as? MoviesTableViewCell
        if isSearching {
            let movie = filteredMovies[indexPath.row]
            cell?.movieNameLbl.text = movie.title
            cell?.languageLbl.text = movie.language
            cell?.movieReleaseYearLbl.text = movie.year
            cell?.moviesImgView.sd_setImage(with: URL(string: movie.poster), placeholderImage: UIImage(named: Constants.placeholderImg))
        } else {
            let section = viewModel.sections[indexPath.section]
            let item = section.items[indexPath.row]
            let movie = viewModel.getMoviesData(sectionTitle: section.title, item: item)
            cell?.movieNameLbl.text = movie?.title
            cell?.languageLbl.text = movie?.language
            cell?.movieReleaseYearLbl.text = movie?.year
            cell?.moviesImgView.sd_setImage(with: URL(string: movie?.poster ?? String()), placeholderImage: UIImage(named: Constants.placeholderImg))
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSearching { return nil }
        let headerView = UITableViewHeaderFooterView()
        headerView.textLabel?.text = viewModel.sections[section].title.rawValue
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpandCollapse)))
        headerView.tag = section
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @objc func handleExpandCollapse(gestureRecognizer: UITapGestureRecognizer) {
        guard let section = gestureRecognizer.view?.tag else { return }
        viewModel.sections[section].isExpanded.toggle()
        moviesTableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.movieDetailVC) as! MovieDetailViewController
        if isSearching {
            let movie = filteredMovies[indexPath.row]
            detailVC.movie = movie
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let section = viewModel.sections[indexPath.section]
            let item = section.items[indexPath.row]
            let movie = viewModel.getMoviesData(sectionTitle: section.title, item: item)
            detailVC.movie = movie
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
//SearchBar Delegate
extension MoviesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredMovies.removeAll()
        } else {
            isSearching = true
            filteredMovies = viewModel.filterMovies(by: searchText)
        }
        moviesTableView.reloadData()
    }
}
