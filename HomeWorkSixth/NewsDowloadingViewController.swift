//
//  ViewController.swift
//  HomeWorkSixth
//
//  Created by Egor Markov on 05.12.2020.
//

import UIKit

class NewsDowloadingViewController: UIViewController {
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dowloadButton: UIButton!
    
    //MARK: - Propirties
    private var arcticles: [Arcticle] = []
    private var detail: Arcticle!
    private var urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=79590477085446f0a8daa31d88a9d777"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        dowloadButton.layer.cornerRadius = 10
        configureNavigation()
        
    }
    
    //MARK: - FUNC
    private func configureNavigation() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .blue
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    
    private func setupURLSession() {
        guard let urlString = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            
            guard let data = data,
                  let news = try? JSONDecoder().decode(News.self, from: data) else {return}
            
            self.arcticles = news.articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let vc = segue.destination as? DetailViewController {
                vc.detailNews = detail
            }
        }
    }
    
    
    
    //MARK: - IBAction
    
    @IBAction func dowloadTapButton(_ sender: UIButton) {
        setupURLSession()
    }
    
    
}


//MARK: - Extension

extension NewsDowloadingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arcticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! NewsCollectionViewCell
        
        cell.setUrlSession(photo: arcticles[indexPath.item])
        cell.nameLabel.text = arcticles[indexPath.item].title
        cell.layer.cornerRadius = 10
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detail = arcticles[indexPath.row]
        performSegue(withIdentifier: "segueDetail", sender: nil)
    }
    
    
}

extension NewsDowloadingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 25) / 3
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 5, bottom: 0, right: 5)
    }
}
