//
//  DetailViewController.swift
//  TestPunkAPI
//
//  Created by Олег Савельев on 24.06.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var beer: Beers?
    
    //MARK: - Сreating elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold )
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.text = "Description"
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Update View
    private func updateView(){
        view.backgroundColor = .white
        [nameLabel, imageView, descriptionLabel].forEach {
            view.addSubview($0)
        }
        constraintSettings()
        
        guard let beer = beer else {
            return
        }
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
        let url = beer.imageURL ?? ""
        guard let urlImage = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: urlImage) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }.resume()
        
    }

    private func constraintSettings(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

}
