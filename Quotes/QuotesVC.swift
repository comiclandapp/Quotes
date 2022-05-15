//
//  QuotesVC.swift
//  Quotes
//
//  Created by Matteo Manferdini on 18/05/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import UIKit

class QuotesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
	let ds: QuotesDS = .init(quotes: Quote.quotes)

	override func viewDidLoad() {
		super.viewDidLoad()

        tableView.dataSource = self
		tableView.reloadData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: indexPath, animated: true)
		}
	}

	override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {

        if let row = tableView.indexPathForSelectedRow?.row {

            let selectedQuote = ds.quotes[row]
			(segue.destination as? DetailVC)?.quote = selectedQuote
		}
	}
}

extension QuotesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return ds.quotes.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuoteCell.self),
                                                 for: indexPath) as! QuoteCell
        let quote = ds.quotes[indexPath.row]

        cell.author = quote.author
        cell.quoteText = quote.text

        return cell
    }
}


