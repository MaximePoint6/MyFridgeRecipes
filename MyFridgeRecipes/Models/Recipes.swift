//
//  Recipes.swift
//  MyFridgeRecipes
//
//  Created by Maxime Point on 21/01/2023.
//

import Foundation

struct Recipes: Codable {
    
    let from: Int? // Recette n° ... à ...
    let to: Int? // Recette n° ... à ...
    let count: Int? // bombre de recette
//    let _links: Links?
    let hits: [Hit]?
    
    struct Links: Codable {
//        let `self`: Link?
        let next: Link? // page suivante
    }
    
    struct Hit: Codable, Identifiable {
        let id = UUID()
        let recipe: Recipe?
//        let _links: Links?
    }
    
    struct Link: Codable {
        let href: String?
        let title: String?
    }
    
    struct Recipe: Codable {
        //        let uri: String?
        let label: String? // nom de la recette
        let image: String? // lien image
        let images: InlineModel1? // Lien de 3 tailles d'images différentes
        //        let source: String?
        //        let url: String?
        let shareAs: String? // lien pour partager la recette
        //        let yield: Double?
        //        let dietLabels: [String]?
        //        let healthLabels: [String]?
        //        let cautions: [String]?
        let ingredientLines: [String]? // Ingrédient dans la recette
        let ingredients: [Ingredient]? // détails des aliments
        let calories: Double? // calories du plat
        let glycemicIndex: Double?
        let totalCO2Emissions: Double?
        let co2EmissionsClass: String?
        //        let totalWeight: Double?
        let totalTime: Double?
        let cuisineType: [String]? // type de cuisine
        let mealType: [String]? // diner, lunch etc
        //        let dishType: [String]?
        let instructions: [String]?
        let tags: [String]?
        let externalId: String?
        let totalNutrients: NutrientsInfo?
        //        let totalDaily: NutrientsInfo?
        let digest: [DigestEntry]
    }
    
    struct InlineModel1: Codable {
        let thumbnail: ImageInfo?
        let small: ImageInfo?
        let regular: ImageInfo?
        let large: ImageInfo?
    }

    struct Ingredient: Codable {
        let text: String? // ligne des ingrédient (donc quantité + intitulé de l'ingrédient)
        let quantity: Double?
        let measure: String?
        let food: String?
        let weight: Double?
        //        let foodId: String?
    }

    struct NutrientsInfo: Codable {
        let enercKcal: NutrientsDetails // kcal
        let FAT: NutrientsDetails // lipide
        let PROCNT: NutrientsDetails // proteine
        let CHOCDF: NutrientsDetails // glucide
    }

    struct NutrientsDetails: Codable {
        let label: String
        let quantity: Double
        let unit: String
    }

    struct ImageInfo: Codable {
        let url: String?
        let width: Int?
        let height: Int?
    }

    struct DigestEntry: Codable {
        let label: String?
        let tag: String?
        //        let schemaOrgTag: String?
        let total: Double?
        //        let hasRDI: Bool?
        //        let daily: Double?
        let unit: String?
        let sub: [DigestEntry]?
    }
    
}

//
//
//{
//    "from": 21,
//    "to": 40,
//    "count": 10000,
//    "_links": {
//        "next": {
//            "href": "https://api.edamam.com/api/recipes/v2?q=chicken%20potatoes&app_key=5011b9cdc956e6a8d961299d6f07eeac&_cont=CHcVQBtNNQphDmgVQntAEX4BYVdtBgEGQ2VFC2MQZlx7AgADUXlSA2NBZQMiUFADSm0RADZBa1RxDQYOS2VJVmsTa1NwA1cVLnlSVSBMPkd5AAMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=any&app_id=2a959ba0",
//            "title": "Next page"
//        }
//    },
//
//
//    "hits": [
//        {
//            "recipe": {
//                "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_69188a0ed72922a8aa82f825d01d2eae",
//                "label": "Boulangere Potatoes",
//                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/404/404b794b6145f7d38324e6387afb6ae6.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCXVzLWVhc3QtMSJHMEUCIBsquVV2PObWXDdKui5wDbY58Uf2lE%2FgFkxEGvcJD1WSAiEAzUGadqPJIE%2FuBlhwswZ5c9SA1%2BbVJ0aiLgygfWzTTqcq1QQIv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDLTI%2BgK2k%2BcShcIQzSqpBII20P6PCxk%2BssIk%2FVOWPRRKnhrxfqdzWSP40MKDYVEWJw9SRNCh9TLZ03ZVeB27ImPRJ%2FE9InHpjPbTsn4rRkoCuKl7%2Fgvw6MpHQqKZyFKflZytGtr7iN97zJF35FezML7igy%2FmVue8pVQhNLsE1hVfcs58F05BzCiSeba9CsEkTbr3H%2FJvPULSNXcLZJeZq8MDIceFCgF5CsfzvGQzu8f0MwWYhCF%2FsiSrorVrLRdR%2FdjkQf1HAVkcnbLvn7GaBUwk2Sw6OP3gSiBMgUB1IbizOZ6zz25lX91sPJpkhInK4SDWz5sLkCjJUTnEZdPufrI367RxGzOCbxRUdmzNwav3EQcDb9uZT4O5tRTNpA9VKCr8yIM6CFIv96uuh3Fe4juRdcjMtyYvstT921sR097H4CvATIrE3C0ycFxfCzn7RDlu%2BKyrKg%2FDM3pZeHhVmhgpLZxbEW4qn5PTHqSAVYa8kPEfVAxUd2wB5gxBw3iOsOnqdvj3Ll8vNKVD7kMzh17%2BSrcfZnVPLsgOCiRSg0JiBbiYUd0%2Fukr7kNTvduIw08snylu2nhP4hxWbmDgoun9fRlNGtaNgwn6cuoNQ7dYwV8dJNDLlnZsnCtL5g7Z%2FhsELVmXmUPtT4zuQ6M%2BGzVLCSgSuW93KakHKE8W77Rx8vAfP11zY3hOEL%2F7lqsd64vebkgTc65sy98fwXUcdsrMXhnQYNC0Hyn3XA67nkO78gG%2ByDI1LLcAwn%2Fm0ngY6qQGishWA8MQYA1tDPAcT8qBmerrn6TDoTSgpvNxLQhzN5X6EhEfTFXPNpj4b3eEborYtaVUCOzZYbFCtvUN7p11NHn2ezy9oqbr5YTARYDIM4bA3bEnJNs0YU3%2B45XR8d%2FJhP6CPr847hNjbBiN%2BieV9%2BM9F54PF%2BRMqXSm6jRgyO5shmzvJWI4jyNIU2iuQEPLZ4erw9kAkzTvdZyc%2BCVkSxKA618HR2DcV&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230122T134518Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIHHWDTDC%2F20230122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=6f707078186da4b0f401c69aae88581d4b401705cb19b2b540c1803b9b6cb8d7",
//                "images": {
//                    "THUMBNAIL": {
//                        "url": "https://edamam-product-images.s3.amazonaws.com/web-img/404/404b794b6145f7d38324e6387afb6ae6-s.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCXVzLWVhc3QtMSJHMEUCIBsquVV2PObWXDdKui5wDbY58Uf2lE%2FgFkxEGvcJD1WSAiEAzUGadqPJIE%2FuBlhwswZ5c9SA1%2BbVJ0aiLgygfWzTTqcq1QQIv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDLTI%2BgK2k%2BcShcIQzSqpBII20P6PCxk%2BssIk%2FVOWPRRKnhrxfqdzWSP40MKDYVEWJw9SRNCh9TLZ03ZVeB27ImPRJ%2FE9InHpjPbTsn4rRkoCuKl7%2Fgvw6MpHQqKZyFKflZytGtr7iN97zJF35FezML7igy%2FmVue8pVQhNLsE1hVfcs58F05BzCiSeba9CsEkTbr3H%2FJvPULSNXcLZJeZq8MDIceFCgF5CsfzvGQzu8f0MwWYhCF%2FsiSrorVrLRdR%2FdjkQf1HAVkcnbLvn7GaBUwk2Sw6OP3gSiBMgUB1IbizOZ6zz25lX91sPJpkhInK4SDWz5sLkCjJUTnEZdPufrI367RxGzOCbxRUdmzNwav3EQcDb9uZT4O5tRTNpA9VKCr8yIM6CFIv96uuh3Fe4juRdcjMtyYvstT921sR097H4CvATIrE3C0ycFxfCzn7RDlu%2BKyrKg%2FDM3pZeHhVmhgpLZxbEW4qn5PTHqSAVYa8kPEfVAxUd2wB5gxBw3iOsOnqdvj3Ll8vNKVD7kMzh17%2BSrcfZnVPLsgOCiRSg0JiBbiYUd0%2Fukr7kNTvduIw08snylu2nhP4hxWbmDgoun9fRlNGtaNgwn6cuoNQ7dYwV8dJNDLlnZsnCtL5g7Z%2FhsELVmXmUPtT4zuQ6M%2BGzVLCSgSuW93KakHKE8W77Rx8vAfP11zY3hOEL%2F7lqsd64vebkgTc65sy98fwXUcdsrMXhnQYNC0Hyn3XA67nkO78gG%2ByDI1LLcAwn%2Fm0ngY6qQGishWA8MQYA1tDPAcT8qBmerrn6TDoTSgpvNxLQhzN5X6EhEfTFXPNpj4b3eEborYtaVUCOzZYbFCtvUN7p11NHn2ezy9oqbr5YTARYDIM4bA3bEnJNs0YU3%2B45XR8d%2FJhP6CPr847hNjbBiN%2BieV9%2BM9F54PF%2BRMqXSm6jRgyO5shmzvJWI4jyNIU2iuQEPLZ4erw9kAkzTvdZyc%2BCVkSxKA618HR2DcV&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230122T134518Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIHHWDTDC%2F20230122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=788c631d5219e468ce45cd210678a9fbb86a3d2b82b119f7aa4ca52a6be56924",
//                        "width": 100,
//                        "height": 100
//                    },
//                    "SMALL": {
//                        "url": "https://edamam-product-images.s3.amazonaws.com/web-img/404/404b794b6145f7d38324e6387afb6ae6-m.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCXVzLWVhc3QtMSJHMEUCIBsquVV2PObWXDdKui5wDbY58Uf2lE%2FgFkxEGvcJD1WSAiEAzUGadqPJIE%2FuBlhwswZ5c9SA1%2BbVJ0aiLgygfWzTTqcq1QQIv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDLTI%2BgK2k%2BcShcIQzSqpBII20P6PCxk%2BssIk%2FVOWPRRKnhrxfqdzWSP40MKDYVEWJw9SRNCh9TLZ03ZVeB27ImPRJ%2FE9InHpjPbTsn4rRkoCuKl7%2Fgvw6MpHQqKZyFKflZytGtr7iN97zJF35FezML7igy%2FmVue8pVQhNLsE1hVfcs58F05BzCiSeba9CsEkTbr3H%2FJvPULSNXcLZJeZq8MDIceFCgF5CsfzvGQzu8f0MwWYhCF%2FsiSrorVrLRdR%2FdjkQf1HAVkcnbLvn7GaBUwk2Sw6OP3gSiBMgUB1IbizOZ6zz25lX91sPJpkhInK4SDWz5sLkCjJUTnEZdPufrI367RxGzOCbxRUdmzNwav3EQcDb9uZT4O5tRTNpA9VKCr8yIM6CFIv96uuh3Fe4juRdcjMtyYvstT921sR097H4CvATIrE3C0ycFxfCzn7RDlu%2BKyrKg%2FDM3pZeHhVmhgpLZxbEW4qn5PTHqSAVYa8kPEfVAxUd2wB5gxBw3iOsOnqdvj3Ll8vNKVD7kMzh17%2BSrcfZnVPLsgOCiRSg0JiBbiYUd0%2Fukr7kNTvduIw08snylu2nhP4hxWbmDgoun9fRlNGtaNgwn6cuoNQ7dYwV8dJNDLlnZsnCtL5g7Z%2FhsELVmXmUPtT4zuQ6M%2BGzVLCSgSuW93KakHKE8W77Rx8vAfP11zY3hOEL%2F7lqsd64vebkgTc65sy98fwXUcdsrMXhnQYNC0Hyn3XA67nkO78gG%2ByDI1LLcAwn%2Fm0ngY6qQGishWA8MQYA1tDPAcT8qBmerrn6TDoTSgpvNxLQhzN5X6EhEfTFXPNpj4b3eEborYtaVUCOzZYbFCtvUN7p11NHn2ezy9oqbr5YTARYDIM4bA3bEnJNs0YU3%2B45XR8d%2FJhP6CPr847hNjbBiN%2BieV9%2BM9F54PF%2BRMqXSm6jRgyO5shmzvJWI4jyNIU2iuQEPLZ4erw9kAkzTvdZyc%2BCVkSxKA618HR2DcV&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230122T134518Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIHHWDTDC%2F20230122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=2ac756915b0bb2c8bd6fcaf2d8e60d0cc9353b96c186873113535105b093f7c2",
//                        "width": 200,
//                        "height": 200
//                    },
//                    "REGULAR": {
//                        "url": "https://edamam-product-images.s3.amazonaws.com/web-img/404/404b794b6145f7d38324e6387afb6ae6.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCXVzLWVhc3QtMSJHMEUCIBsquVV2PObWXDdKui5wDbY58Uf2lE%2FgFkxEGvcJD1WSAiEAzUGadqPJIE%2FuBlhwswZ5c9SA1%2BbVJ0aiLgygfWzTTqcq1QQIv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDLTI%2BgK2k%2BcShcIQzSqpBII20P6PCxk%2BssIk%2FVOWPRRKnhrxfqdzWSP40MKDYVEWJw9SRNCh9TLZ03ZVeB27ImPRJ%2FE9InHpjPbTsn4rRkoCuKl7%2Fgvw6MpHQqKZyFKflZytGtr7iN97zJF35FezML7igy%2FmVue8pVQhNLsE1hVfcs58F05BzCiSeba9CsEkTbr3H%2FJvPULSNXcLZJeZq8MDIceFCgF5CsfzvGQzu8f0MwWYhCF%2FsiSrorVrLRdR%2FdjkQf1HAVkcnbLvn7GaBUwk2Sw6OP3gSiBMgUB1IbizOZ6zz25lX91sPJpkhInK4SDWz5sLkCjJUTnEZdPufrI367RxGzOCbxRUdmzNwav3EQcDb9uZT4O5tRTNpA9VKCr8yIM6CFIv96uuh3Fe4juRdcjMtyYvstT921sR097H4CvATIrE3C0ycFxfCzn7RDlu%2BKyrKg%2FDM3pZeHhVmhgpLZxbEW4qn5PTHqSAVYa8kPEfVAxUd2wB5gxBw3iOsOnqdvj3Ll8vNKVD7kMzh17%2BSrcfZnVPLsgOCiRSg0JiBbiYUd0%2Fukr7kNTvduIw08snylu2nhP4hxWbmDgoun9fRlNGtaNgwn6cuoNQ7dYwV8dJNDLlnZsnCtL5g7Z%2FhsELVmXmUPtT4zuQ6M%2BGzVLCSgSuW93KakHKE8W77Rx8vAfP11zY3hOEL%2F7lqsd64vebkgTc65sy98fwXUcdsrMXhnQYNC0Hyn3XA67nkO78gG%2ByDI1LLcAwn%2Fm0ngY6qQGishWA8MQYA1tDPAcT8qBmerrn6TDoTSgpvNxLQhzN5X6EhEfTFXPNpj4b3eEborYtaVUCOzZYbFCtvUN7p11NHn2ezy9oqbr5YTARYDIM4bA3bEnJNs0YU3%2B45XR8d%2FJhP6CPr847hNjbBiN%2BieV9%2BM9F54PF%2BRMqXSm6jRgyO5shmzvJWI4jyNIU2iuQEPLZ4erw9kAkzTvdZyc%2BCVkSxKA618HR2DcV&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230122T134518Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIHHWDTDC%2F20230122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=6f707078186da4b0f401c69aae88581d4b401705cb19b2b540c1803b9b6cb8d7",
//                        "width": 300,
//                        "height": 300
//                    },
//                    "LARGE": {
//                        "url": "https://edamam-product-images.s3.amazonaws.com/web-img/404/404b794b6145f7d38324e6387afb6ae6-l.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFYaCXVzLWVhc3QtMSJHMEUCIBsquVV2PObWXDdKui5wDbY58Uf2lE%2FgFkxEGvcJD1WSAiEAzUGadqPJIE%2FuBlhwswZ5c9SA1%2BbVJ0aiLgygfWzTTqcq1QQIv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwxODcwMTcxNTA5ODYiDLTI%2BgK2k%2BcShcIQzSqpBII20P6PCxk%2BssIk%2FVOWPRRKnhrxfqdzWSP40MKDYVEWJw9SRNCh9TLZ03ZVeB27ImPRJ%2FE9InHpjPbTsn4rRkoCuKl7%2Fgvw6MpHQqKZyFKflZytGtr7iN97zJF35FezML7igy%2FmVue8pVQhNLsE1hVfcs58F05BzCiSeba9CsEkTbr3H%2FJvPULSNXcLZJeZq8MDIceFCgF5CsfzvGQzu8f0MwWYhCF%2FsiSrorVrLRdR%2FdjkQf1HAVkcnbLvn7GaBUwk2Sw6OP3gSiBMgUB1IbizOZ6zz25lX91sPJpkhInK4SDWz5sLkCjJUTnEZdPufrI367RxGzOCbxRUdmzNwav3EQcDb9uZT4O5tRTNpA9VKCr8yIM6CFIv96uuh3Fe4juRdcjMtyYvstT921sR097H4CvATIrE3C0ycFxfCzn7RDlu%2BKyrKg%2FDM3pZeHhVmhgpLZxbEW4qn5PTHqSAVYa8kPEfVAxUd2wB5gxBw3iOsOnqdvj3Ll8vNKVD7kMzh17%2BSrcfZnVPLsgOCiRSg0JiBbiYUd0%2Fukr7kNTvduIw08snylu2nhP4hxWbmDgoun9fRlNGtaNgwn6cuoNQ7dYwV8dJNDLlnZsnCtL5g7Z%2FhsELVmXmUPtT4zuQ6M%2BGzVLCSgSuW93KakHKE8W77Rx8vAfP11zY3hOEL%2F7lqsd64vebkgTc65sy98fwXUcdsrMXhnQYNC0Hyn3XA67nkO78gG%2ByDI1LLcAwn%2Fm0ngY6qQGishWA8MQYA1tDPAcT8qBmerrn6TDoTSgpvNxLQhzN5X6EhEfTFXPNpj4b3eEborYtaVUCOzZYbFCtvUN7p11NHn2ezy9oqbr5YTARYDIM4bA3bEnJNs0YU3%2B45XR8d%2FJhP6CPr847hNjbBiN%2BieV9%2BM9F54PF%2BRMqXSm6jRgyO5shmzvJWI4jyNIU2iuQEPLZ4erw9kAkzTvdZyc%2BCVkSxKA618HR2DcV&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230122T134518Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIHHWDTDC%2F20230122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=84885fd1e0bfa932f2e59d134a2218168354756ec27eccca3f7f70a2cd3820d5",
//                        "width": 600,
//                        "height": 600
//                    }
//                },
//                "source": "Cook Almost Anything",
//                "url": "http://cookalmostanything.blogspot.com/2010/01/boulangere-potatoes.html",
//                "shareAs": "http://www.edamam.com/recipe/boulangere-potatoes-69188a0ed72922a8aa82f825d01d2eae/chicken+potatoes",
//                "yield": 4.0,
//                "dietLabels": [],
//                "healthLabels": [
//                    "Gluten-Free",
//                    "Wheat-Free",
//                    "Egg-Free",
//                    "Peanut-Free",
//                    "Tree-Nut-Free",
//                    "Soy-Free",
//                    "Fish-Free",
//                    "Shellfish-Free",
//                    "Pork-Free",
//                    "Red-Meat-Free",
//                    "Crustacean-Free",
//                    "Celery-Free",
//                    "Mustard-Free",
//                    "Sesame-Free",
//                    "Lupine-Free",
//                    "Mollusk-Free",
//                    "Alcohol-Free",
//                    "Sulfite-Free"
//                ],
//                "cautions": [
//                    "Sulfites"
//                ],
//                "ingredientLines": [
//                    "4 x nicola potatoes",
//                    "1 x large red onion, sliced finely",
//                    "500 ml chicken stock",
//                    "butter",
//                    "salt and white pepper"
//                ],
//                "ingredients": [
//                    {
//                        "text": "4 x nicola potatoes",
//                        "quantity": 4.0,
//                        "measure": "<unit>",
//                        "food": "potatoes",
//                        "weight": 852.0,
//                        "foodCategory": "vegetables",
//                        "foodId": "food_abiw5baauresjmb6xpap2bg3otzu",
//                        "image": "https://www.edamam.com/food-img/651/6512e82417bce15c2899630c1a2799df.jpg"
//                    },
//                    {
//                        "text": "1 x large red onion, sliced finely",
//                        "quantity": 1.0,
//                        "measure": "<unit>",
//                        "food": "red onion",
//                        "weight": 150.0,
//                        "foodCategory": "vegetables",
//                        "foodId": "food_bmrvi4ob4binw9a5m7l07amlfcoy",
//                        "image": "https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg"
//                    },
//                    {
//                        "text": "500 ml chicken stock",
//                        "quantity": 500.0,
//                        "measure": "milliliter",
//                        "food": "chicken stock",
//                        "weight": 507.21034052764503,
//                        "foodCategory": "canned soup",
//                        "foodId": "food_bptblvzambd16nbhewqmhaw1rnh5",
//                        "image": "https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg"
//                    },
//                    {
//                        "text": "butter",
//                        "quantity": 0.0,
//                        "measure": null,
//                        "food": "butter",
//                        "weight": 20.52526063117597,
//                        "foodCategory": "Dairy",
//                        "foodId": "food_awz3iefajbk1fwahq9logahmgltj",
//                        "image": "https://www.edamam.com/food-img/713/71397239b670d88c04faa8d05035cab4.jpg"
//                    },
//                    {
//                        "text": "salt and white pepper",
//                        "quantity": 0.0,
//                        "measure": null,
//                        "food": "salt",
//                        "weight": 9.05526204316587,
//                        "foodCategory": "Condiments and sauces",
//                        "foodId": "food_btxz81db72hwbra2pncvebzzzum9",
//                        "image": "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg"
//                    },
//                    {
//                        "text": "salt and white pepper",
//                        "quantity": 0.0,
//                        "measure": null,
//                        "food": "white pepper",
//                        "weight": 0.0,
//                        "foodCategory": "Condiments and sauces",
//                        "foodId": "food_a443px0bncpqa5avv80p3anrp26k",
//                        "image": "https://www.edamam.com/food-img/4f0/4f0e35fe6c042996408b337fb550324a.jpg"
//                    }
//                ],
//                "calories": 1045.801841315484,
//                "totalWeight": 1536.8894299945682,
//                "totalTime": 0.0,
//                "cuisineType": [
//                    "french"
//                ],
//                "mealType": [
//                    "lunch/dinner"
//                ],
//                "dishType": [
//                    "main course"
//                ],
//                "totalNutrients": {
//                    "ENERC_KCAL": {
//                        "label": "Energy",
//                        "quantity": 1045.801841315484,
//                        "unit": "kcal"
//                    },
//                    "FAT": {
//                        "label": "Fat",
//                        "quantity": 23.65136298427857,
//                        "unit": "g"
//                    },
//                    "FASAT": {
//                        "label": "Saturated",
//                        "quantity": 12.456081074116213,
//                        "unit": "g"
//                    },
//                    "FATRN": {
//                        "label": "Trans",
//                        "quantity": 0.6728180434899483,
//                        "unit": "g"
//                    },
//                    "FAMS": {
//                        "label": "Monounsaturated",
//                        "quantity": 7.303119219150394,
//                        "unit": "g"
//                    },
//                    "FAPU": {
//                        "label": "Polyunsaturated",
//                        "quantity": 2.0968017063305684,
//                        "unit": "g"
//                    },
//                    "CHOCDF": {
//                        "label": "Carbs",
//                        "quantity": 180.77124017700456,
//                        "unit": "g"
//                    },
//                    "CHOCDF.net": {
//                        "label": "Carbohydrates (net)",
//                        "quantity": 159.47724017700455,
//                        "unit": "g"
//                    },
//                    "FIBTG": {
//                        "label": "Fiber",
//                        "quantity": 21.294,
//                        "unit": "g"
//                    },
//                    "SUGAR": {
//                        "label": "Sugars",
//                        "quantity": 21.031838536715497,
//                        "unit": "g"
//                    },
//                    "SUGAR.added": {
//                        "label": "Sugars, added",
//                        "quantity": 0.0,
//                        "unit": "g"
//                    },
//                    "PROCNT": {
//                        "label": "Protein",
//                        "quantity": 31.816565296661647,
//                        "unit": "g"
//                    },
//                    "CHOLE": {
//                        "label": "Cholesterol",
//                        "quantity": 59.34562057285768,
//                        "unit": "mg"
//                    },
//                    "NA": {
//                        "label": "Sodium",
//                        "quantity": 3557.3695457828153,
//                        "unit": "mg"
//                    },
//                    "CA": {
//                        "label": "Calcium",
//                        "quantity": 158.59929168789088,
//                        "unit": "mg"
//                    },
//                    "MG": {
//                        "label": "Magnesium",
//                        "quantity": 231.73045712208676,
//                        "unit": "mg"
//                    },
//                    "K": {
//                        "label": "Potassium",
//                        "quantity": 4343.989226412369,
//                        "unit": "mg"
//                    },
//                    "FE": {
//                        "label": "Iron",
//                        "quantity": 8.053454402392255,
//                        "unit": "mg"
//                    },
//                    "ZN": {
//                        "label": "Zinc",
//                        "quantity": 3.461521040142508,
//                        "unit": "mg"
//                    },
//                    "P": {
//                        "label": "Phosphorus",
//                        "quantity": 671.0128544939464,
//                        "unit": "mg"
//                    },
//                    "VITA_RAE": {
//                        "label": "Vitamin A",
//                        "quantity": 145.46488612252008,
//                        "unit": "µg"
//                    },
//                    "VITC": {
//                        "label": "Vitamin C",
//                        "quantity": 179.9584206810553,
//                        "unit": "mg"
//                    },
//                    "THIA": {
//                        "label": "Thiamin (B1)",
//                        "quantity": 0.9291498822162345,
//                        "unit": "mg"
//                    },
//                    "RIBF": {
//                        "label": "Riboflavin (B2)",
//                        "quantity": 0.7512473780630982,
//                        "unit": "mg"
//                    },
//                    "NIA": {
//                        "label": "Niacin (B3)",
//                        "quantity": 17.19691240342299,
//                        "unit": "mg"
//                    },
//                    "VITB6A": {
//                        "label": "Vitamin B6",
//                        "quantity": 3.003414065540799,
//                        "unit": "mg"
//                    },
//                    "FOLDFE": {
//                        "label": "Folate equivalent (total)",
//                        "quantity": 190.79627484531753,
//                        "unit": "µg"
//                    },
//                    "FOLFD": {
//                        "label": "Folate (food)",
//                        "quantity": 190.79627484531753,
//                        "unit": "µg"
//                    },
//                    "FOLAC": {
//                        "label": "Folic acid",
//                        "quantity": 0.0,
//                        "unit": "µg"
//                    },
//                    "VITB12": {
//                        "label": "Vitamin B12",
//                        "quantity": 0.03489294307299915,
//                        "unit": "µg"
//                    },
//                    "VITD": {
//                        "label": "Vitamin D",
//                        "quantity": 0.30787890946763957,
//                        "unit": "µg"
//                    },
//                    "TOCPHA": {
//                        "label": "Vitamin E",
//                        "quantity": 0.743549148801576,
//                        "unit": "mg"
//                    },
//                    "VITK1": {
//                        "label": "Vitamin K",
//                        "quantity": 19.23918892523761,
//                        "unit": "µg"
//                    },
//                    "Sugar.alcohol": {
//                        "label": "Sugar alcohol",
//                        "quantity": 0.0,
//                        "unit": "g"
//                    },
//                    "WATER": {
//                        "label": "Water",
//                        "quantity": 1280.7326682111293,
//                        "unit": "g"
//                    }
//                },
//                "totalDaily": {
//                    "ENERC_KCAL": {
//                        "label": "Energy",
//                        "quantity": 52.290092065774196,
//                        "unit": "%"
//                    },
//                    "FAT": {
//                        "label": "Fat",
//                        "quantity": 36.386712283505496,
//                        "unit": "%"
//                    },
//                    "FASAT": {
//                        "label": "Saturated",
//                        "quantity": 62.28040537058107,
//                        "unit": "%"
//                    },
//                    "CHOCDF": {
//                        "label": "Carbs",
//                        "quantity": 60.25708005900152,
//                        "unit": "%"
//                    },
//                    "FIBTG": {
//                        "label": "Fiber",
//                        "quantity": 85.176,
//                        "unit": "%"
//                    },
//                    "PROCNT": {
//                        "label": "Protein",
//                        "quantity": 63.633130593323294,
//                        "unit": "%"
//                    },
//                    "CHOLE": {
//                        "label": "Cholesterol",
//                        "quantity": 19.781873524285892,
//                        "unit": "%"
//                    },
//                    "NA": {
//                        "label": "Sodium",
//                        "quantity": 148.223731074284,
//                        "unit": "%"
//                    },
//                    "CA": {
//                        "label": "Calcium",
//                        "quantity": 15.859929168789089,
//                        "unit": "%"
//                    },
//                    "MG": {
//                        "label": "Magnesium",
//                        "quantity": 55.173918362401615,
//                        "unit": "%"
//                    },
//                    "K": {
//                        "label": "Potassium",
//                        "quantity": 92.42530268962487,
//                        "unit": "%"
//                    },
//                    "FE": {
//                        "label": "Iron",
//                        "quantity": 44.74141334662364,
//                        "unit": "%"
//                    },
//                    "ZN": {
//                        "label": "Zinc",
//                        "quantity": 31.468373092204615,
//                        "unit": "%"
//                    },
//                    "P": {
//                        "label": "Phosphorus",
//                        "quantity": 95.85897921342091,
//                        "unit": "%"
//                    },
//                    "VITA_RAE": {
//                        "label": "Vitamin A",
//                        "quantity": 16.162765124724455,
//                        "unit": "%"
//                    },
//                    "VITC": {
//                        "label": "Vitamin C",
//                        "quantity": 199.9538007567281,
//                        "unit": "%"
//                    },
//                    "THIA": {
//                        "label": "Thiamin (B1)",
//                        "quantity": 77.42915685135287,
//                        "unit": "%"
//                    },
//                    "RIBF": {
//                        "label": "Riboflavin (B2)",
//                        "quantity": 57.788259851007545,
//                        "unit": "%"
//                    },
//                    "NIA": {
//                        "label": "Niacin (B3)",
//                        "quantity": 107.48070252139368,
//                        "unit": "%"
//                    },
//                    "VITB6A": {
//                        "label": "Vitamin B6",
//                        "quantity": 231.03185119544605,
//                        "unit": "%"
//                    },
//                    "FOLDFE": {
//                        "label": "Folate equivalent (total)",
//                        "quantity": 47.69906871132938,
//                        "unit": "%"
//                    },
//                    "VITB12": {
//                        "label": "Vitamin B12",
//                        "quantity": 1.4538726280416312,
//                        "unit": "%"
//                    },
//                    "VITD": {
//                        "label": "Vitamin D",
//                        "quantity": 2.052526063117597,
//                        "unit": "%"
//                    },
//                    "TOCPHA": {
//                        "label": "Vitamin E",
//                        "quantity": 4.95699432534384,
//                        "unit": "%"
//                    },
//                    "VITK1": {
//                        "label": "Vitamin K",
//                        "quantity": 16.032657437698006,
//                        "unit": "%"
//                    }
//                },
//                "digest": [
//                    {
//                        "label": "Fat",
//                        "tag": "FAT",
//                        "schemaOrgTag": "fatContent",
//                        "total": 23.65136298427857,
//                        "hasRDI": true,
//                        "daily": 36.386712283505496,
//                        "unit": "g",
//                        "sub": [
//                            {
//                                "label": "Saturated",
//                                "tag": "FASAT",
//                                "schemaOrgTag": "saturatedFatContent",
//                                "total": 12.456081074116213,
//                                "hasRDI": true,
//                                "daily": 62.28040537058107,
//                                "unit": "g"
//                            },
//                            {
//                                "label": "Trans",
//                                "tag": "FATRN",
//                                "schemaOrgTag": "transFatContent",
//                                "total": 0.6728180434899483,
//                                "hasRDI": false,
//                                "daily": 0.0,
//                                "unit": "g"
//                            },
//                            {
//                                "label": "Monounsaturated",
//                                "tag": "FAMS",
//                                "schemaOrgTag": null,
//                                "total": 7.303119219150394,
//                                "hasRDI": false,
//                                "daily": 0.0,
//                                "unit": "g"
//                            },
//                            {
//                                "label": "Polyunsaturated",
//                                "tag": "FAPU",
//                                "schemaOrgTag": null,
//                                "total": 2.0968017063305684,
//                                "hasRDI": false,
//                                "daily": 0.0,
//                                "unit": "g"
//                            }
//                        ]
//                    },
//                    {
//                        "label": "Carbs",
//                        "tag": "CHOCDF",
//                        "schemaOrgTag": "carbohydrateContent",
//                        "total": 180.77124017700456,
//                        "hasRDI": true,
//                        "daily": 60.25708005900152,
//                        "unit": "g",
//                        "sub": [
//                            {
//                                "label": "Carbs (net)",
//                                "tag": "CHOCDF.net",
//                                "schemaOrgTag": null,
//                                "total": 159.47724017700455,
//                                "hasRDI": false,
//                                "daily": 0.0,
//                                "unit": "g"
//                            },
//                            {
//                                "label": "Fiber",
//                                "tag": "FIBTG",
//                                "schemaOrgTag": "fiberContent",
//                                "total": 21.294,
//                                "hasRDI": true,
//                                "daily": 85.176,
//                                "unit": "g"
//                            },
//                            {
//                                "label": "Sugars",
//                                "tag": "SUGAR",
//                                "schemaOrgTag": "sugarContent",
//                                "total": 21.031838536715497,
//                                "hasRDI": false,
//                                "daily": 0.0,
//                                "unit": "g"
//                            },
//                            {
//                                "label": "Sugars, added",
//                                "tag": "SUGAR.added",
//                                "schemaOrgTag": null,
//                                "total": 0.0,
//                                "hasRDI": false,
//                                "daily": 0.0,
//                                "unit": "g"
//                            }
//                        ]
//                    },
//                    {
//                        "label": "Protein",
//                        "tag": "PROCNT",
//                        "schemaOrgTag": "proteinContent",
//                        "total": 31.816565296661647,
//                        "hasRDI": true,
//                        "daily": 63.633130593323294,
//                        "unit": "g"
//                    },
//                    {
//                        "label": "Cholesterol",
//                        "tag": "CHOLE",
//                        "schemaOrgTag": "cholesterolContent",
//                        "total": 59.34562057285768,
//                        "hasRDI": true,
//                        "daily": 19.781873524285892,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Sodium",
//                        "tag": "NA",
//                        "schemaOrgTag": "sodiumContent",
//                        "total": 3557.3695457828153,
//                        "hasRDI": true,
//                        "daily": 148.223731074284,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Calcium",
//                        "tag": "CA",
//                        "schemaOrgTag": null,
//                        "total": 158.59929168789088,
//                        "hasRDI": true,
//                        "daily": 15.859929168789089,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Magnesium",
//                        "tag": "MG",
//                        "schemaOrgTag": null,
//                        "total": 231.73045712208676,
//                        "hasRDI": true,
//                        "daily": 55.173918362401615,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Potassium",
//                        "tag": "K",
//                        "schemaOrgTag": null,
//                        "total": 4343.989226412369,
//                        "hasRDI": true,
//                        "daily": 92.42530268962487,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Iron",
//                        "tag": "FE",
//                        "schemaOrgTag": null,
//                        "total": 8.053454402392255,
//                        "hasRDI": true,
//                        "daily": 44.74141334662364,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Zinc",
//                        "tag": "ZN",
//                        "schemaOrgTag": null,
//                        "total": 3.461521040142508,
//                        "hasRDI": true,
//                        "daily": 31.468373092204615,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Phosphorus",
//                        "tag": "P",
//                        "schemaOrgTag": null,
//                        "total": 671.0128544939464,
//                        "hasRDI": true,
//                        "daily": 95.85897921342091,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Vitamin A",
//                        "tag": "VITA_RAE",
//                        "schemaOrgTag": null,
//                        "total": 145.46488612252008,
//                        "hasRDI": true,
//                        "daily": 16.162765124724455,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Vitamin C",
//                        "tag": "VITC",
//                        "schemaOrgTag": null,
//                        "total": 179.9584206810553,
//                        "hasRDI": true,
//                        "daily": 199.9538007567281,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Thiamin (B1)",
//                        "tag": "THIA",
//                        "schemaOrgTag": null,
//                        "total": 0.9291498822162345,
//                        "hasRDI": true,
//                        "daily": 77.42915685135287,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Riboflavin (B2)",
//                        "tag": "RIBF",
//                        "schemaOrgTag": null,
//                        "total": 0.7512473780630982,
//                        "hasRDI": true,
//                        "daily": 57.788259851007545,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Niacin (B3)",
//                        "tag": "NIA",
//                        "schemaOrgTag": null,
//                        "total": 17.19691240342299,
//                        "hasRDI": true,
//                        "daily": 107.48070252139368,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Vitamin B6",
//                        "tag": "VITB6A",
//                        "schemaOrgTag": null,
//                        "total": 3.003414065540799,
//                        "hasRDI": true,
//                        "daily": 231.03185119544605,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Folate equivalent (total)",
//                        "tag": "FOLDFE",
//                        "schemaOrgTag": null,
//                        "total": 190.79627484531753,
//                        "hasRDI": true,
//                        "daily": 47.69906871132938,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Folate (food)",
//                        "tag": "FOLFD",
//                        "schemaOrgTag": null,
//                        "total": 190.79627484531753,
//                        "hasRDI": false,
//                        "daily": 0.0,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Folic acid",
//                        "tag": "FOLAC",
//                        "schemaOrgTag": null,
//                        "total": 0.0,
//                        "hasRDI": false,
//                        "daily": 0.0,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Vitamin B12",
//                        "tag": "VITB12",
//                        "schemaOrgTag": null,
//                        "total": 0.03489294307299915,
//                        "hasRDI": true,
//                        "daily": 1.4538726280416312,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Vitamin D",
//                        "tag": "VITD",
//                        "schemaOrgTag": null,
//                        "total": 0.30787890946763957,
//                        "hasRDI": true,
//                        "daily": 2.052526063117597,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Vitamin E",
//                        "tag": "TOCPHA",
//                        "schemaOrgTag": null,
//                        "total": 0.743549148801576,
//                        "hasRDI": true,
//                        "daily": 4.95699432534384,
//                        "unit": "mg"
//                    },
//                    {
//                        "label": "Vitamin K",
//                        "tag": "VITK1",
//                        "schemaOrgTag": null,
//                        "total": 19.23918892523761,
//                        "hasRDI": true,
//                        "daily": 16.032657437698006,
//                        "unit": "µg"
//                    },
//                    {
//                        "label": "Sugar alcohols",
//                        "tag": "Sugar.alcohol",
//                        "schemaOrgTag": null,
//                        "total": 0.0,
//                        "hasRDI": false,
//                        "daily": 0.0,
//                        "unit": "g"
//                    },
//                    {
//                        "label": "Water",
//                        "tag": "WATER",
//                        "schemaOrgTag": null,
//                        "total": 1280.7326682111293,
//                        "hasRDI": false,
//                        "daily": 0.0,
//                        "unit": "g"
//                    }
//                ]
//            },
//            "_links": {
//                "self": {
//                    "title": "Self",
//                    "href": "https://api.edamam.com/api/recipes/v2/69188a0ed72922a8aa82f825d01d2eae?type=public&app_id=2a959ba0&app_key=5011b9cdc956e6a8d961299d6f07eeac"
//                }
//            }
//        },
//
//
//        {
//        },
