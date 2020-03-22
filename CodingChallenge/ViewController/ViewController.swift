//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Praveen on 3/20/20.


import UIKit

class ViewController: UIViewController {

    var homeTableView =  UITableView()
    let homeVCModel = HomeVCModel()

    private struct Attributes {
        static let titleText = "Home"
        static let cellIdentifier = "CustomCell"
        static let detailsVCIdentifier = "DetailsViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }

    //MARK: - Private Functions

    private func setUpView() {
        self.view.backgroundColor = UIColor.white
        self.title = Attributes.titleText
        homeTableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        // register cell name
        homeTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Attributes.cellIdentifier)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        self.view.addSubview(homeTableView)
        self.invokeAPICall()
    }
    
    private func invokeAPICall() {
        homeVCModel.getDataFromAPI {[weak self] (success) in
            if success {
                DispatchQueue.main.async { [weak self] in
                    self?.homeTableView.reloadData()
                }
            }
        }
    }
}

//MARK: - Tableview DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVCModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Attributes.cellIdentifier, for: indexPath) as? CustomTableViewCell {
            cell.setContent(albumName: homeVCModel.dataArray[indexPath.row].name, artistName: homeVCModel.dataArray[indexPath.row].artistName, imageUrl: homeVCModel.dataArray[indexPath.row].artworkUrl100)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - Tableview Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController(nibName: nil, bundle: nil)
        detailsVC.setContentForDetails(details: homeVCModel.dataArray[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
