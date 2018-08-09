//
//  GameRoom+UITableView.swift
//  SpyMe
//
//  Created by Danny Navarro on 8/7/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation

extension GameRoom_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = (self.gameroom_VM?.locs.count)!
        
        // returning half the amount because 2 items will go into each cell
        if count % 2 == 0
        {
            // even number of items
            return (count/2)
        }
        else
        {
            // odd number of items, so return 1 more extra cell to even it out
            return (count + 1)/2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let count = (self.gameroom_VM?.locs.count)!
        // adjusted index to traverse array
        let index = indexPath.row * 2

        if count % 2 == 0
        {
            // even number of items
            cell.locationLabel.text = self.gameroom_VM?.locs[index]
            cell.locationLabel2.text = self.gameroom_VM?.locs[index + 1]
        }
        else
        {
            // odd number of items
            if indexPath.row == (count-1)/2
            {
                // means the last item is the odd number, so we don't add the next location and let it be blank
                cell.locationLabel.text = self.gameroom_VM?.locs[index]
                cell.locationLabel2.text = ""
            }
            else
            {
                cell.locationLabel.text = self.gameroom_VM?.locs[index]
                cell.locationLabel2.text = self.gameroom_VM?.locs[index + 1]
            }
        }
        
        return cell
    }
}
