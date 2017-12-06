//
//  WeatherTableViewController.swift
//  Task-Fazeel
//
//  Created by Faz on 12/5/17.
//  Copyright © 2017 Faz. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController , UISearchBarDelegate {

    let weatherService = WeatherService(Apikey: "d2e20dc7cb08594c288e60ef4bcf1bb6")
    @IBOutlet weak var searchBar: UISearchBar!
    var weatherArray = [CurrentWeather]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //setting the search delegate
        searchBar.delegate = self
        
        //initial call for dubai city
        self.updateWeather(locationString: "Dubai")

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        //validatng the search sting and if its valid calling the api fr weather
        if let locationString = searchBar.text, !locationString.isEmpty {
            self.updateWeather(locationString: locationString)
        }
    }
    
    //calling the api for weather
    func updateWeather(locationString: String)  {
        weatherService.getCurrentWeather(cityName: locationString) { (results:[CurrentWeather]?) in
            if let weatherData = results {
                self.weatherArray = weatherData
                self.tableView.reloadData()
            }
        }

    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return weatherArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMMM dd, yyyy"
        return dateformatter.string(from: date!)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell with the values
        
        let weatherData = weatherArray[indexPath.section]
        cell.textLabel?.text = weatherData.description
        
        if let temperatureC = weatherData.temperatureC {
            cell.detailTextLabel?.text = String(temperatureC) + " °C"
        } else {
            cell.detailTextLabel?.text = "No temperature available"
        }
        
        
        cell.imageView?.af_setImage(
            withURL: weatherService.getUrl(img: weatherData.iconString),
            placeholderImage: UIImage(named: "weather")!,
            filter: nil
        )

        return cell
    }
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
