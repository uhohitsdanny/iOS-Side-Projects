//
//  GameQueue+UITableView.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/6/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

extension GameQueue_VC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (room?.players.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        
        cell.nameLabel.text = room?.players[indexPath.row]
        
        return cell
    }
}
