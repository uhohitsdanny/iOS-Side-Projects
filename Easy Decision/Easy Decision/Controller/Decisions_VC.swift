//
//  ViewController.swift
//  Easy Decision
//
//  Created by Danny Navarro on 2/14/18.
//

import UIKit

class Decisions_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var decision_list: [Decision]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (decision_list?.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "decision_cell")
        cell.textLabel?.text = decision_list[indexPath.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

