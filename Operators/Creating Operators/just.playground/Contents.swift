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

/*:
 # just
 */

let disposeBag = DisposeBag()
let element = "๐"

// ์์ ๋ณ์๋ฅผ ํ๋ผ๋ฏธํฐ๋ก ์ ๋ฌ,
// ๋ฐ๋ก ๊ตฌ๋ ํ ์ ๋ฌ๋๋ ์ด๋ฒคํธ๋ฅผ ํ๋ฆฐํธํ๋๋ก ๊ตฌ๋
Observable.just(element)
    .subscribe { event in
        print(event)
    }.disposed(by: disposeBag)


// ์ฐจ๊ทผ์ฐจ๊ทผ ๋ง๋ ๋ค ์น๋ฉด
// 1. observable ์์ฑ (๋์์ ์ด๋ฒคํธ๋ ๊ตฌ์ฒด์ ์ผ๋ก ์ ์)
let observable = Observable.just(element)

// 2. ๊ตฌ๋ํ๊ธฐ+disposed by
observable.subscribe { event in //event์ ํ์์ Event<String>์ผ๋ก ์๋
    print(event)                 // ๋ฐ์๋๋ง๋ค ํ  ์ผ
}.disposed(by: disposeBag)


// parmameter๋ก ๋ฐฐ์ด ์ ๋ฌ, ๋ฐ๋ก ๊ตฌ๋์์
Observable.just([1, 2, 3])
    .subscribe { event in
        print(event)
    }
