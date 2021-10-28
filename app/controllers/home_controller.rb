class HomeController < ApplicationController
  def index
    @categories = [
      { name: '音楽', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '健康', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/health.webp' },
      { name: '趣味', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/hoby.webp' },
      { name: '創作', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/art.webp' },
      { name: '旅行', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/beauty.webp' },
      { name: '飲食', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/food.webp' },
      { name: 'その他', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/others.webp' },
    ]
    @yoshimoto_recs = [
      {
        title: '笑って健康！折りがとう！',
        image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/y/RGR24pRw69Y-320x180@1.webp',
        tags: ['イベント', 'オンライン', '話題性あり'],
        amount_time: 60,
      },
      {
        title: 'オスペンギンの介護オモシレーション',
        image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/y/cMMCH0e-WjM-320x180@1.webp',
        tags: ['イベント', 'オンライン', '話題性あり'],
        amount_time: 60,
      },
      {
        title: '～脳トレしながら、レギュラーとオンラインで交流しよう～',
        image: 'https://recreation.sandbox.everyplus.jp/resource/thumbnail/y/-KZMhDb5dkM-320x180@1.webp',
        tags: ['イベント', 'オンライン', '話題性あり'],
        amount_time: 60,
      },
    ]
  end
end
