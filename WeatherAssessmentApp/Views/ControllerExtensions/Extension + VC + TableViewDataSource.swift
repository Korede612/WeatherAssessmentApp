//
//  Extension + VC + TableViewDataSource.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 06/06/2024.
//

import UIKit

extension ViewController: UITableViewDelegate {
    // UITableViewDelegate method to handle selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let location = dataSource.itemIdentifier(for: indexPath) {
            print("Selected weather: \(location)")
            searchTF.text = location
            performSearch()
            // Handle the selection event, e.g., navigate to a detail view
        }
    }
    
    // UITableViewDelegate method to handle swipe-to-delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.deleteItem(at: indexPath)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // Method to delete an item
    private func deleteItem(at indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.deleteLocation(location: item)
        viewModel.updateSavedLocation()
        hideSelectedTableView()
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([item])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
