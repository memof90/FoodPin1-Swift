# FoodPin1-Swift-UIAlertController
Implementation new features to creates UITableview UITableViewDiffableDataSource

## new Implementation UITableViewDiffableDataSource to create tableView

```
dataSource = UITableViewDiffableDataSource<Int, UUID>(tableView: tableView) {
    (tableView: UITableView, indexPath: IndexPath, itemIdentifier: UUID) -> UITableViewCell? in
    // configure and return cell
}
```

## Video example Check Your Favorite Food

![](https://github.com/memof90/FoodPin1-Swift/blob/alertsTableView/FoodPin/images/Simulator%20Screen%20Recording%20-%20iPhone%2012%20Pro%20-%202021-08-11%20at%2016.18.54.gif?raw=true)

## Image example Light Mode

<img src="https://github.com/memof90/FoodPin1-Swift/blob/master/FoodPin/images/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202021-07-29%20at%2011.54.38.png?raw=true" width="200" height="400">

## Image Dark Mode 

<img src="https://github.com/memof90/FoodPin1-Swift/blob/master/FoodPin/images/Simulator%20Screen%20Shot%20-%20iPhone%2012%20Pro%20-%202021-07-29%20at%2011.54.57.png?raw=true" width="200" height="400">
