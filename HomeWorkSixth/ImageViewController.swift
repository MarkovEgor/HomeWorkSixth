//
//  ImageViewController.swift
//  HomeWorkSixth
//
//  Created by Egor Markov on 06.12.2020.
//

import UIKit

class ImageViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var charactarButton: UIButton!
    @IBOutlet weak var idicatorActive: UIActivityIndicatorView!
    
    //MARK: - Propirties
    private let urlString = "https://thesimpsonsquoteapi.glitch.me/quotes"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactarButton.layer.cornerRadius = 10
        charactarButton.isHidden = true
        setUrlSession()
    }
    
    
    //MARK: - IBAction
    @IBAction func tapButton(_ sender: Any) {
        setUrlSession()
    }
    
    
    //MARK: - FUNC
    
    func setUrlSession() {
        
        guard let url = URL(string: urlString) else {return}
        idicatorActive.startAnimating()
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,
                  let character = try? JSONDecoder().decode([Character].self, from: data) else {return}
            guard let image = character.first?.image, let urlImage = URL(string: image),
                  let characterImageData = try? Data(contentsOf: urlImage) else {return}
            DispatchQueue.main.async {
                self.quoteLabel.text = character.first?.quote
                self.characterLabel.text = character.first?.character
                self.imageCharacter.image = UIImage(data: characterImageData)
                self.idicatorActive.stopAnimating()
                self.idicatorActive.isHidden = true
                self.charactarButton.isHidden = false
            }
            
            
        }.resume()
        
    }
}
