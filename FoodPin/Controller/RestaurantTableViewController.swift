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
    
    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:"homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong"
        , image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong"
    , image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:
    "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney"
    , image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York"
    , image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
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
        var snapshot = NSDiffableDataSourceSnapshot<Section,Restaurant>()
//        six: agremamos la seccion
        snapshot.appendSections([.all])
//      seven: agremos los elementos a la matriz
        snapshot.appendItems(restaurants, toSection: .all)
//        apliacamos la instantanea a la fuente de datos
        dataSource.apply(snapshot, animatingDifferences: false)
    
    }
    
//    MARK: UITableViewDiffableDataSource
//    Frist declare number to section
    enum Section {
        case all
    }

//   second: Crear una instancia de UitableViewDataSource
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        
//        identificamos la celda
        let cellIdentifier = "favoriteCell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(
        
            tableView: tableView,  cellProvider: {  tableView, indexPath, restaurant in
//                MARK: downcasting
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                    
                cell.nameLabel.text = restaurant.name
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.thumbnailImageView.image = UIImage(named: restaurant.image)
//               Every time when the cell is rendered, we check if the restaurant to be displayed is marked as favorite. If the condition is true , we display a checkmark in the cell. Otherwise, just display nothing.
//                cell.accessoryType = self.restaurantsIsFavorites[indexPath.row] ? .checkmark: .none
                
                cell.heartImageView.isHidden = restaurant.isFavorite ? false : true
                
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
        let favoriteActionTitle =  self.restaurants[indexPath.row].isFavorite ? "Remove from favorites" : "Mark as favorite"
        let styleFavorite = self.restaurants[indexPath.row].isFavorite ? 2 : 0

        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: UIAlertAction.Style(rawValue: styleFavorite) ?? .default, handler: {(action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
//            MARK: SOLUTION EXERCISE #2
            cell.heartImageView.isHidden = self.restaurants[indexPath.row].isFavorite
            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
        })
        optionMenu.addAction(favoriteAction)
        
        
//        Display the menu
        present(optionMenu, animated: true, completion: nil)
        
//        methond to deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
