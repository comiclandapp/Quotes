//
//  AuthorsVC.swift
//  Quotes
//
//  Created by Matteo Manferdini on 26/05/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import UIKit

class AuthorsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
	let ds: QuotesDS = .init(quotes: Quote.quotes)

	override func viewDidLoad() {
		super.viewDidLoad()

        tableView.dataSource = self
		tableView.sectionIndexColor = UIColor(named: "Haverlock Blue")
		tableView.reloadData()
	}
}

extension AuthorsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {

        let view = UINib(nibName: "SectionHeader", bundle: nil).instantiate(withOwner: nil,
                                                                            options: nil).first as? AuthorHeaderView
		view?.author = ds.authors[section]

        return view
	}

	func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {

        return 33.0
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {

        if let indexPath = tableView.indexPathForSelectedRow {

            let author = ds.authors[indexPath.section]
            let selectedQuote = ds.sections[author]?[indexPath.row]

            (segue.destination as? DetailVC)?.quote = selectedQuote
        }
    }
}

extension AuthorsVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return ds.sections.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        let author = ds.authors[section]
        return ds.sections[author]?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuoteCell.self)) as! QuoteCell

        let author = ds.authors[indexPath.section]
        let quote = ds.sections[author]?[indexPath.row]

        cell.quoteText = quote?.text

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {

        return ds.authors[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {

        return ds.indexes
    }

    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String, at index: Int) -> Int {

        return ds.authors.firstIndex(where: { $0.hasPrefix(title) }) ?? 0
    }
}

class AuthorHeaderView: UIView {

    @IBOutlet private weak var label: UILabel!
	
	var author: String? {
		didSet { label.text = author }
	}
}
