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
//   tree: usamos lazy porque su valor inicial no se puede recuperar hasta que finalice la iniacializacion de la instancia
   lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cellIdentifier = "dataCell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(
        
            tableView: tableView,  cellProvider: {  tableView, indexPath, restaurantName in
//                MARK: downcasting
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                    
                cell.nameLabel.text = restaurantName
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
                
                return cell
                
                }
            )
            return dataSource
        }
    
}
