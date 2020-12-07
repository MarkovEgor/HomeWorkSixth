//
//  ImageCollectionViewCell.swift
//  HomeWorkSixth
//
//  Created by Egor Markov on 05.12.2020.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var imageDowload: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Propirties
    var imageCache = NSCache<NSString, UIImage>()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageDowload.image = nil
        
    }
    
    //MARK: - FUNC
    
    func setUrlSession(photo: Arcticle) {
        indicator.startAnimating()
        guard let urlToImage =  photo.urlToImage else {return}
        guard let imageUrl = URL(string: urlToImage) else {return}
        
        if let cacheImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
            
            imageDowload.image = cacheImage
            
        }else{
            
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let dataImage = data, let image = UIImage(data: dataImage) {
                    self.imageCache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self.imageDowload.image = image
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        
                    }
                }
                
            }.resume()
        }
    }
    
    
    
}
