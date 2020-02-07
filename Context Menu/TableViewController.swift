//
//  TableViewController.swift
//  Context Menu
//
//  Created by Billow on 2020/2/7.
//  Copyright © 2020 Billow Wang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var list = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Context Menu"
        self.tableView.allowsMultipleSelection = true
//        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "bag")
        return cell
    }


    // MARK: - Table view delegate
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }



    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveList = list[fromIndexPath.row]
        list.remove(at: fromIndexPath.row)
        list.insert(moveList, at: to.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    // MARK: - Context Menus Delegate
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let identifier = "\(indexPath.row)" as NSString
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil, actionProvider: { _ in
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil)  { _ in
                self.list.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            let starAction = UIAction(title: "Star", image: UIImage(systemName: "star"), identifier: nil)  { _ in
//                self.list.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .fade)
                let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0))
                cell?.accessoryView = UIImageView(image: UIImage(systemName: "star"))
            }
            return UIMenu(title: "", children: [starAction,deleteAction])
        })
    }
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//        guard let identifier = configuration.identifier as? String, let index = Int(identifier) else {
//                return
//        }
//        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
        animator.addCompletion {
            print("pressed")
            self.performSegue(withIdentifier: "showDetailViewController", sender: nil)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "showDetailViewController":
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.navigationItem.title = "segue"
        default:
            break
        }
    }


}
