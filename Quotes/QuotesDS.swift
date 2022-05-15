//
//  QuotesDS.swift
//  Quotes
//
//  Created by Matteo Manferdini on 26/05/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import UIKit

class QuotesDS: NSObject {

    let quotes: [Quote]

    var sections: [String: [Quote]] = [:]

	var authors: [String] {

        let sortedAuthors = sections.keys.sorted(by: { str1, str2 in
            lastName(str1) < lastName(str2)
        })
        return sortedAuthors
	}

	var indexes: [String] {

        let lastnames = sections.keys.map { String(lastName($0)) }
        let indexes_ = lastnames
			.map { String($0.first!) }
			.reduce(into: Set<String>(), { $0.insert($1) })
			.sorted()
        return indexes_ // ["B","D","E","F","H","J","O","P","R","S","T","W"]
	}

    // text: "Jordan B. Peterson"
    // returns: "Peterson"
    func lastName(_ text: String) -> String {

        return Array(text.components(separatedBy: " ").suffix(1)).first!
    }

    init(quotes: [Quote]) {

        let sortedQuotes = quotes.sorted { q1, q2 in
            
            Array(q1.author.components(separatedBy: " ").suffix(1)).first! < Array(q2.author.components(separatedBy: " ").suffix(1)).first!
        }
        
        self.quotes = sortedQuotes

        for quote in self.quotes {

            let author = quote.author
			if var quotes = sections[author] {
				quotes.append(quote)
				sections[author] = quotes
			}
            else {
				sections[author] = [quote]
			}
		}
	}
}
