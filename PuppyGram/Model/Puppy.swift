//
//  Puppy.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/11/21.
//

import Foundation

// MARK: - Puppy
struct Puppy: Codable {
    let title: String
    let link: String
    let puppyDescription: String
    let modified: String
    let generator: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case title, link
        case puppyDescription = "description"
        case modified, generator, items
    }
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let itemDescription: String
    let published: String
    let author: String
    let authorID: String?
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case itemDescription = "description"
        case published, author
        case authorID = "author_id"
        case tags
    }
}


// MARK: - Media
struct Media: Codable {
    let m: String
}


