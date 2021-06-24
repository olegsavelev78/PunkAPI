//
//  TableViewCell.swift
//  TestPunkAPI
//
//  Created by Олег Савельев on 23.06.2021.
//

import UIKit

class BeersTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            if let view = beerImageView.subviews.first {
                view.removeFromSuperview()
            }
        }
    
    //MARK: - Update View
    func layoutCell(){
        [nameLabel,beerImageView].forEach {
            contentView.addSubview($0)
        }
        addConstraint()
    }
    
    private func addConstraint(){
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            
            beerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            beerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            beerImageView.widthAnchor.constraint(equalToConstant: 50),
            beerImageView.heightAnchor.constraint(equalToConstant: 140),
            beerImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - Init Cell
    func initCell(beer: Beers){
        layoutCell()
        nameLabel.text = beer.name
        let url = beer.imageURL ?? ""
        guard let urlImage = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: urlImage) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.beerImageView.image = image
            }
        }.resume()
    }

}
