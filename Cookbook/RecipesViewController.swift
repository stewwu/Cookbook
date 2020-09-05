//
//  RecipesViewController.swift
//  Cookbook
//
//  Created by Ching on 2019/12/31.
//  Copyright © 2019 Che-Ching Wu. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {

    static let cookbook = [
        [
            "description": "Style of Views",
            "recipes": [
                [
                    "description": "UIButton insets",
                    "class": "ButtonEdgeInsetsViewController"
                ]
            ]
        ],
        [
            "description": "Layout & Constraint",
            "recipes": [
                [
                    "description": "Multi-line UILabel layout",
                    "class": "MultiLineViewController"
                ],
                [
                    "description": "Two dynamic UILabel layout",
                    "class": "TwoDynamicLabelsViewController"
                ],
                [
                    "description": "Programmatically",
                    "identifier": "BasicConstraintViewController"
                ]
            ]
        ],
        [
            "description": "Scroll View",
            "recipes": [
                [
                    "description": "Fixed content position as table section header",
                    "class": "FixedPositionViewController"
                ],
                [
                    "description": "Layout Fixed content",
                    "class": "ScrollableViewController"
                ]
            ]
        ],
        [
            "description": "Collection View",
            "recipes": [
                [
                    "description": "Variable height content",
                    "class": "CollectionViewController"
                ],
                [
                    "description": "Animated insertion",
                    "class": "AnimatedInsertionCollectionViewController"
                ],
                [
                    "description": "Paged Small Banner",
                    "class": "PagedSmallBannerViewController"
                ],
                [
                    "description": "Looped Carousel",
                    "class": "LoopedCarouselViewController"
                ]
            ]
        ],
        [
            "description": "System & Device",
            "recipes": [
                [
                    "description": "Version",
                    "class": "VersionViewController"
                ],
                [
                    "description": "Screen",
                    "class": "ScreenViewController"
                ],
                [
                    "description": "Available Fonts",
                    "class": "FontViewController"
                ]
            ]
        ],
        [
            "description": "Input",
            "recipes": [
                [
                 "description": "Keyboard type list",
                "class": "KeyboardTypeViewController"
                ]
            ]
        ],
        [
            "description": "Layer",
            "recipes": [
                [
                    "description": "Layer Animation",
                    "identifier": "LayerAnimationViewController"
                ],
                [
                    "description": "Layer Timing Functions",
                    "identifier": "LayerTimingViewController"
                ],
            ]
        ],
        [
            "description": "Map & Location",
            "recipes": [
                [
                    "description": "Map by Distance",
                    "identifier": "CLGeocoderViewController"
                ],
                [
                    "description": "Map by Annotations",
                    "identifier": "MapByAnnotationsViewController"
                ],
                [
                    "description": "Map with Carrousel",
                    "identifier": "CarrouselMapViewController"
                ],
                [
                    "description": "CLGeocoder Sample",
                    "identifier": "CLGeocoderViewController"
                ],
                [
                    "description": "Where am I",
                    "class": "WhereAmIViewController"
                ],
                [

                    "description": "Flip between UICollectionView",
                    "class": "FlipFlopViewController"
                ]
            ]
        ],
        [
            "description": "Controller Presentation",
            "recipes": [
                [
                    "description": "Status Bar",
                    "class": "ModalTableViewController"
                ],
                [
                    "description": "Customized presentation controller",
                    "class": "CustomizedPresentationViewController"
                ]
            ]
        ],
        [
            "description": "Controller Transitioning",
            "recipes": [
                [
                    "description": "Customized presentation transitioning",
                    "class": "CustomizedPresentationViewController"
                ]
            ]
        ]
    ]
    var recipes: [[String: Any]]!

    override func viewDidLoad() {
        if recipes == nil {
            recipes = RecipesViewController.cookbook
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = recipes[indexPath.row]["description"] as? String
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        if let recipes = recipe["recipes"] as? [[String : Any]] {
            let recipesViewController = RecipesViewController()
            recipesViewController.recipes = recipes
            navigationController?.pushViewController(recipesViewController, animated: true)
        } else if let className = recipe["class"] as? String {
            var type = NSClassFromString(className) as? UIViewController.Type
            if type == nil {
                let moduleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
                type = NSClassFromString(moduleName + "." + className) as? UIViewController.Type
            }
            let viewController = type!.init()
            switch className {
            case "CustomizedPresentationViewController":
                tableView.deselectRow(at: indexPath, animated: false)
                present(viewController, animated: true, completion: nil)
            default:
                navigationController?.pushViewController(viewController, animated: true)
            }
        } else if let identifier = recipe["identifier"] as? String {
            let viewController = UIStoryboard(name: "Main_iPhone", bundle: nil).instantiateViewController(withIdentifier: identifier)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
