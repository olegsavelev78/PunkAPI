//
//  ViewController.swift
//  TestPunkAPI
//
//  Created by Олег Савельев on 23.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let detailVC = DetailViewController()
    
    var beersArray: [Beers] = []
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(BeersTableViewCell.self, forCellReuseIdentifier: "Beer")
        tv.tableFooterView = UIView()
        tv.separatorStyle = .singleLine
        tv.frame = .zero
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        updateView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getData()
    }
    
    //MARK: - Update View
    func updateView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - Get Data
    private func getData() {
        Network.shared.getData(pagination: false) { [weak self] beers in
            self?.beersArray = beers
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Activity Indicator
    private func createDownload() -> UIView {
        let downloadView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = downloadView.center
        downloadView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return downloadView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height){
            guard !Network.shared.isPagination else {
                return
            }
            self.tableView.tableFooterView = createDownload()
            
            Network.shared.getData(pagination: true) { [weak self] beers in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                for beer in beers {
                    self?.beersArray.append(beer)
                }
                sleep(2)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Beer") as? BeersTableViewCell else { return UITableViewCell() }
        let beer = beersArray[indexPath.row]
        cell.initCell(beer: beer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.beer = beersArray[indexPath.row]
        present(detailVC, animated: true, completion: nil)
        
    }
    
    
    
    
}

