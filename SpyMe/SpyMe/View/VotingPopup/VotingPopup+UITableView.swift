//
//  VotingPopup+UITableView.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/9/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

extension VotingPopup_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.spy == self.player?.name
        {
            // location array
            return Locations().locations.count
        }
        else
        {
            // player array
            return self.players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.selectionStyle = .none
        cell.point1.isHidden = true
        cell.point2.isHidden = true
        
        if self.spy == self.player?.name
        {
            // Load location lists
            cell.nameLabel.text = Locations().locations[indexPath.row]
            
            // disable user interactions
            cell.isUserInteractionEnabled = false
        }
        else
        {
            // Load player lists

            cell.nameLabel.text = self.players[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.spy == self.player?.name
        {
            // Do nothing
        }
        else
        {
            let cell = tableView.cellForRow(at: indexPath) as! PlayerCell
            cell.point1.isHidden = false
            cell.point2.isHidden = false
            
            log("Voted for \(self.players[indexPath.row])")
            self.votedplayer = self.players[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if self.spy == self.player?.name
        {
            // Do nothing
        }
        else
        {
            let cell = tableView.cellForRow(at: indexPath) as! PlayerCell
            cell.point1.isHidden = true
            cell.point2.isHidden = true
        }
    }
}
