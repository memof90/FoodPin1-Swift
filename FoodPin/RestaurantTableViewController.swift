//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Memo Figueredo on 28/7/21.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
//    Cree una enumeración que indique las secciones de la tabla.
//    2. Cree un objeto UITableViewDiffableDataSource para conectarse con su tabla y
//    proporcionar la configuración de las celdas de la vista de tabla.
//    3. Asigne la fuente de datos si es posible a su vista de tabla.
//    4. Genere el estado actual de los datos de la tabla creando una instantánea
//    5. Llame a la función apply () de la fuente de datos para completar los datos.
    
    var restaurantNames = ["Cafe Deadend","Homei", "Teakha", "Cafe Loisl","Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery","Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif","Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional","Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
    "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee &Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
//    BUG create 10 cells and reuses
    var restaurantsIsFavorites = Array(repeating: false, count: 21)
    
//   tree: usamos lazy porque su valor inicial no se puede recuperar hasta que finalice la iniacializacion de la instancia
   lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ajustar el ancho de la celda
        tableView.cellLayoutMarginsFollowReadableWidth = true
//        hide separator table 
        tableView.separatorStyle = .none
// four: asignar fuente de datos personalizadas
        tableView.dataSource = dataSource
//        five: crear una instancia de los datos para mostrar la vista de la tabla
        var snapshot = NSDiffableDataSourceSnapshot<Section,String>()
//        six: agremamos la seccion
        snapshot.appendSections([.all])
//      seven: agremos los elementos a la matriz
        snapshot.appendItems(restaurantNames, toSection: .all)
//        apliacamos la instantanea a la fuente de datos
        dataSource.apply(snapshot, animatingDifferences: false)
    
    }
    
//    MARK: UITableViewDiffableDataSource
//    Frist declare number to section
    enum Section {
        case all
    }

//   second: Crear una instancia de UitableViewDataSource
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String > {
        
//        identificamos la celda
        let cellIdentifier = "favoriteCell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(
        
            tableView: tableView,  cellProvider: {  tableView, indexPath, restaurantName in
//                MARK: downcasting
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                    
                cell.nameLabel.text = restaurantName
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
//               Every time when the cell is rendered, we check if the restaurant to be displayed is marked as favorite. If the condition is true , we display a checkmark in the cell. Otherwise, just display nothing.
//                cell.accessoryType = self.restaurantsIsFavorites[indexPath.row] ? .checkmark: .none
                
                cell.heartImageView.isHidden = self.restaurantsIsFavorites[indexPath.row] ? false : true
                
                return cell
                
                }
            )
            return dataSource
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        //        BUG IPAD NOT SUPPORT ALLERT ACTIONSHEET IS NECESARY POPOVER
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
//        Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add "Reserve a table" action
        let reserveActionHandler = {(action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not Avalable yet", message: "Sorry, this freature is not available yet. Please retry later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let reservationAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reservationAction)
        
//        MARK: EXCERCISES #ONE AND TWO MY SOLUTION
//        Mark as favorite action
//        let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default, handler: {(action: UIAlertAction!) -> Void in
//            let cell = tableView.cellForRow(at: indexPath) as!  RestaurantTableViewCell
//            cell.heartImageView.isHidden = self.restaurantsIsFavorites[indexPath.row]
////            cell?.accessoryType = .checkmark
////            cell?.tintColor = .systemYellow
////           Check to true
//            self.restaurantsIsFavorites[indexPath.row] = true
//        })
//        optionMenu.addAction(favoriteAction)
        
//        REMOVE FAVORITE
//        let removeFavorite = UIAlertAction(title: "remove from favorites", style: .destructive, handler: {(action: UIAlertAction!) -> Void in
//            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
////            cell?.accessoryType = .none
//            cell.heartImageView.isHidden = self.restaurantsIsFavorites[indexPath.row]
//            self.restaurantsIsFavorites[indexPath.row] = false
//        })
//
//        optionMenu.addAction(removeFavorite)
        
//        MARK: Action as favorite action
        let favoriteActionTitle = self.restaurantsIsFavorites[indexPath.row] ? "Remove from favorites" : "Mark as favorite"
        let styleFavorite = self.restaurantsIsFavorites[indexPath.row] ? 2 : 0

        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: UIAlertAction.Style(rawValue: styleFavorite) ?? .default, handler: {(action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
//            MARK: SOLUTION EXERCISE #2
            cell.heartImageView.isHidden = self.restaurantsIsFavorites[indexPath.row]
            self.restaurantsIsFavorites[indexPath.row] = self.restaurantsIsFavorites[indexPath.row] ? false : true
        })
        optionMenu.addAction(favoriteAction)
        
        
//        Display the menu
        present(optionMenu, animated: true, completion: nil)
        
//        methond to deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
