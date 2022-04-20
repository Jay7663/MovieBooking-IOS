//
//  HomeScreenViewController.swift
//  MovieBooking
//
//  Created by Yagnik Bavishi on 12/04/22.
//

import UIKit
import Alamofire

class HomeScreenViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var coordinator: HomeScreenCoordinator?
    var homeScreenViewModel = HomeScreenViewModel()
    var fetchedMoiveData = [Result]()
    
    //MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    // MARK: - File Private Functions
    fileprivate func initalSetup() {
        activityIndicator.startAnimating()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        homeScreenViewModel.getMovieData()
        bindData()
    }
    
    fileprivate func bindData() {
        homeScreenViewModel.error = {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            let alert = UIAlertController(title: "Data Not Loaded", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dimiss", style: .cancel, handler: { _ in }))
            self.present(alert, animated: true, completion: nil)
        }
        
        homeScreenViewModel.movieData = { [weak self] data in
            guard let self = self else {
                return
            }
            self.fetchedMoiveData = data
        }
        
        homeScreenViewModel.dataLoaded = { [weak self] in 
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
         }
    }
    
}// End of class

//MARK: - UITableViewDataSource
extension HomeScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedMoiveData.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 20
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }

        let imgURL = "https://image.tmdb.org/t/p/w500" + fetchedMoiveData[indexPath.row].posterPath
        if let url = URL(string: imgURL) {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    cell.imgMovie.image = UIImage(data: data)
                }
            }
        }
        
        cell.lblMovieName.text = self.fetchedMoiveData[indexPath.row].originalTitle
        cell.lblMovieOverView.text = self.fetchedMoiveData[indexPath.row].overview
        cell.lblDate.text = self.fetchedMoiveData[indexPath.row].releaseDate
        cell.ratingBar.value = (self.fetchedMoiveData[indexPath.row].voteAverage) / 2
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        return cell
    }
    
}// End of Extension

//MARK: - UITableViewDelegate
extension HomeScreenViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}// End of Extension
