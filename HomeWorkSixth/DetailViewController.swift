//
//  DetailViewController.swift
//  HomeWorkSixth
//
//  Created by Egor Markov on 07.12.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textContent: UITextView!
    
    //MARK: - Propirties
    var detailNews: Arcticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = detailNews.title
        descriptionLabel.text = detailNews.description
        textContent.text = detailNews.content
        guard let image = detailNews.urlToImage, let urlImage = URL(string: image),
              let imageData = try? Data(contentsOf: urlImage) else {return}
        imageNews.image = UIImage(data: imageData)
    }
    
    
    
}
