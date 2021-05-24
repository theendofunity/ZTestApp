//
//  Company.swift
//  ZTestApp
//
//  Created by Дмитрий Дудкин on 16.05.2021.
//

import RealmSwift

class Company {
    var leaders: Results<Leader>!
    var bookkeepings: Results<Bookkeeper>!
    var employees: Results<Employee>!
}
