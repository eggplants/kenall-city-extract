# kenall-city-extract

2021年度 [テキスト処理]「`KEN_ALL.CSV`から市の抽出 && LaTeXレポート作成」

## 実行

```shellsession
$ ./extract.sh
[Preparing....]
[Parsing......]
[Checking.....]
[Wrong answers]: 0/47 lines => OK!
```

## 内容

- `extract.sh`
  - `KEN_ALL.CSV`から市と県を抽出し、県別に市の数を集計するスクリプト
  - `RES.CSV`に結果を出力し`ANS.CSV`と比較
- `KEN_ALL.CSV`
  - 日本郵政が公開している郵便番号データ
  - DL: <https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip>
- `RES.CSV`
  - `extract.sh`の結果
  - `<都道府県名>,<市の数>,/<市1>/<市2>/.../<市n>/`
- `ANS.CSV`
  - [e-stat]を参考に作成した正しい都道府県と市の数の組データ
  - `<都道府県名>,<市の数>`
- `mismatch`
  - `RES.CSV`と`ANS.CSV`を比較して一致しなかったもののデータ
  - デバック用
- `tex/`
  - レポートのTeXファイル

[テキスト処理]: https://kdb.tsukuba.ac.jp/syllabi/2021/GE71701/jpn/
[e-stat]: https://www.e-stat.go.jp/municipalities/number-of-municipalities?year=2021&month=11&day=21&file_format=csv&sort_key=cityCnt&sort_order=desc&form_id=city_count_form
