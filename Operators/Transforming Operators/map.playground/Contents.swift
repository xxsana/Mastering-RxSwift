//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift
import RxCocoa

/*:
 # map
 */

let disposeBag = DisposeBag()
let skills = ["Swift", "SwiftUI", "RxSwift"]


// ex1
// change Event<Float> to Event<String>
let slider = UISlider()
let label = UILabel()

slider.rx.value.asObservable()
    .map{ String($0) }
    .bind(to: label.rx.text)
    .disposed(by: disposeBag)


// ex2
// when get the value from textField
// after entering to the textField Return button
// change Observable<()> to Observable<String?>

let cityNameTextField = UITextField()

cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
    .asObservable()
    .map { cityNameTextField.text}
    .subscribe(onNext: { city in
        print(city)
    }).disposed(by: disposeBag)


// ex3
// After decoding into PersonModel after get a data from server,
// If you want to show on UILabel the value age of Observable<PersonModel>.

struct PersonModel { let age: Int }
let ageLabel = UILabel()

let ob = Observable<PersonModel>.just(PersonModel(age: 7))

ob.map { "\($0.age)" }
    .bind(to: ageLabel.rx.text)
    .disposed(by: disposeBag)
