//
//  SlikeRecommendationModel.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 17/01/23.
//

import Foundation

struct ErrorResponce: Codable {
    let status: Int
    let result: String
}


// MARK: - SlikeRecommendationModel
public struct SlikeRecommendationModel: Codable {
    let channel, description, duration: String?
    let image: String?
    let inputWordCount: Int?
    let k: String?
    let msid, product: Int?
    let ralgo: String?
    let recency: Int?
    let rm, rmn, rtype, score: String?
    let seopath: String?
    let thumb: String?
    let title: String
    let url: String?
    let vidAgency, vidDate: String?
    let wordCount: Int?

    enum CodingKeys: String, CodingKey {
        case channel, description, duration, image
        case inputWordCount = "input_word_count"
        case k, msid, product, ralgo, recency, rm, rmn, rtype, score, seopath, thumb, title, url, vidAgency, vidDate
        case wordCount = "word_count"
    }
}
