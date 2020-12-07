//
//  Model.swift
//  HomeWorkSixth
//
//  Created by Egor Markov on 05.12.2020.
//

import UIKit

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Arcticle]
}


struct Arcticle: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}


struct Character: Codable {
    let quote: String
    let character: String
    let image: String
}
