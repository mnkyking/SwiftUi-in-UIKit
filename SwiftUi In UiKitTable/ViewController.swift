//
//  ViewController.swift
//  SwiftUi In UiKitTable
//
//  Created by Robin G on 8/13/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    var tableList: UITableView?
    var addButton: UIButton?
    var deleteButton: UIButton?
    var pageView: UIView?
    var pageButton: UIButton?
    let headerText = "Header Text"
    var itemList: [String]?
    let itemText = "Item "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableList = UITableView()
        addButton = UIButton()
        deleteButton = UIButton()
        deleteButton?.setTitle("Delete Item", for: .normal)
        deleteButton?.backgroundColor = .red
        deleteButton?.addTarget(self, action: #selector(deleteLastItem), for: .touchUpInside)
        addButton?.backgroundColor = .blue
        addButton?.setTitle("Add Item", for: .normal)
        addButton?.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        pageView = UIView()
        pageView?.backgroundColor = .cyan
        pageButton = UIButton()
        pageButton?.setTitle("Open Page", for: .normal)
        pageButton?.backgroundColor = .white
        pageButton?.tintColor = .black
        pageButton?.addTarget(self, action: #selector(openPage), for: .touchUpInside)
        tableList?.delegate = self
        tableList?.dataSource = self
        itemList = []
        for _ in 0...3 {
            addItem()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let add = addButton,
              let delete = deleteButton,
              let table = tableList,
              let page = pageView,
              let pageButton = pageButton
        else { return }
        let margins = view.layoutMarginsGuide
        //add subviews
        view.addSubview(add)
        view.addSubview(delete)
        view.addSubview(table)
        view.addSubview(page)
        page.addSubview(pageButton)

        add.translatesAutoresizingMaskIntoConstraints = false
        delete.translatesAutoresizingMaskIntoConstraints = false
        table.translatesAutoresizingMaskIntoConstraints = false
        page.translatesAutoresizingMaskIntoConstraints = false
        pageButton.translatesAutoresizingMaskIntoConstraints = false
        
        //add button
        add.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        add.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        NSLayoutConstraint(item: add, attribute: .trailing, relatedBy: .equal, toItem: delete, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: add, attribute: .bottom, relatedBy: .equal, toItem: table, attribute: .top, multiplier: 1, constant: 0).isActive = true
        add.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //delete button
        delete.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        delete.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        NSLayoutConstraint(item: delete, attribute: .bottom, relatedBy: .equal, toItem: table, attribute: .top, multiplier: 1, constant: 0).isActive = true
        //tableview
        table.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        NSLayoutConstraint(item: table, attribute: .bottom, relatedBy: .equal, toItem: page, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        //page view
        page.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        page.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        page.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        page.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //page button
        NSLayoutConstraint(item: pageButton, attribute: .centerX, relatedBy: .equal, toItem: pageButton.superview, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: pageButton, attribute: .centerY, relatedBy: .equal, toItem: pageButton.superview, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        pageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc
    func addItem() {
        guard let list = itemList, !list.isEmpty else {
            itemList = []
            let count = itemList?.count ?? 0
            itemList?.append("\(itemText)\(count)")
            return
        }
        itemList?.append("\(itemText)\(list.count)")
        tableList?.reloadData()
    }
    
    @objc
    func deleteLastItem() {
        guard let list = itemList, !list.isEmpty else { return }
        delete(item: list.count-1)
    }
    
    func delete(item: Int) {
        guard let list = itemList, !list.isEmpty else {
            return
        }
        itemList?.remove(at: item)
        tableList?.reloadData()
    }
    
    @objc
    func openPage() {
        let vc = SecondViewController()
        vc.delegate = self
        vc.view.backgroundColor = .blue
        guard let table = tableList else { return }
        let isEditing = table.isEditing
        tableList?.isEditing = !isEditing
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: DismissMeDelegate {
    func didDismiss() {
        tableList?.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let subtitle = tableView.isEditing ? "editing" : "not editing"
        let header = HeaderView(title: headerText, subtitle: subtitle) { [weak self] in
            if let self = self, let list = self.itemList {
                self.delete(item: list.count-1)
            }
        }
        let host = UIHostingController(rootView: header)
        return host.view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        guard let list = itemList else { return cell }
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
}

