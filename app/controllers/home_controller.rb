class HomeController < ApplicationController
  def index
    @categories = [
      { name: '音楽', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '健康', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/health.webp' },
      { name: '趣味', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/hoby.webp' },
      { name: '創作', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/art.webp' },
      { name: '旅行', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/beauty.webp' },
      { name: '飲食', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/food.webp' },
      { name: 'その他', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/others.webp' }
    ]
    @yoshimoto_recs = [
      {
        title: '笑って健康！折りがとう！',
        image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/y/RGR24pRw69Y-320x180@1.webp',
        tags: %w[イベント オンライン 話題性あり],
        amount_time: 60
      },
      {
        title: 'オスペンギンの介護オモシレーション',
        image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/y/cMMCH0e-WjM-320x180@1.webp',
        tags: %w[イベント オンライン 話題性あり],
        amount_time: 60
      },
      {
        title: '～脳トレしながら、レギュラーとオンラインで交流しよう～',
        image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/y/-KZMhDb5dkM-320x180@1.webp',
        tags: %w[イベント オンライン 話題性あり],
        amount_time: 60
      }
    ]
  end

  def detail
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @rec = {
      image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/6148b05c57d22bf1372b7368-320x180@1.jpg',
      title: '～おはらい町おかげ横丁ツアー～',
      sub_title: '生中継！オンライン伊勢旅行',
      amount_time: 60,
      tags: %w[イベント オンライン 話題性あり],
      targets: ['ほぼ自立'],
      description: 'おかげ横丁、おはらい町から伊勢神宮まで生中継双方向で撮影をしながら、様々なお土産店にも入店。３～５種類のお土産付き！
      実際に施設に届くお土産を試食しながらの参加となるので旅行している気分に！ご要望があれば、買い物もツアー後に可能です。
      ツアー最後には、伊勢神宮内宮入り口近くにある足に良いとされる「足神さん」 と呼ばれる宇治神社でツアーフィニッシュ。',
      flow_of_day: "0:00～00:05 　ツアーのご紹介　コンダクター自己紹介|\n 00:05～00:20 　おはらい町探索　お店やお土産について
                    \nお土産のご紹介\n00:20～00:30　人力車体験・クイズ等\n00:25～00:30　 内宮前
                    \n00:30～00:40 　足神神社
                    \n※スケジュールは変更する可能性がございます。",
      borrow_item: "-\n",
      bring_your_own_item: "-\n",
      extra_information: "【前田竜】\n伊勢神宮内宮のお膝元で、生まれ育った日本一優しい物知りお兄さん。地元民ならではの地元トークを取り入れながら、ご案内をさせて頂きますので、是非遊びに来てください
                          \n【田中宏典】\n日本各地を旅や営業を通して練り歩き、最後に辿り着いた伊勢の地。他の土地を知るからこそ、お伊勢さん特有の魅力をたっぷりとご案内させて頂きます！",
      organized_by: '人力車　俥夫',
      instructor_image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/6148b04a57d22bf1372b7363-90x90@1.jpg',
      instructor_name: '前田竜、田中宏典',
      instructor_profile: '皆さんのお声を聞いたり、個々にお手伝いいただく場面では、現地スタッフ様にご対応ご協力をお願いしております。メイン（全体）画面の他にもう1台スマートフォンもしくはタブレットの接続もしていただけると、
      より高度なオンラインレクリエーションが実現します。可能な範囲でご準備頂けますと幸いです。'
    }
  end
end
