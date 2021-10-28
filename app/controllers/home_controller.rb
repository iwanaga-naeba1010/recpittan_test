class HomeController < ApplicationController
  def index
    @categories = [
      { name: '音楽', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '健康', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '趣味', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '創作', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '旅行', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: '飲食', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
      { name: 'その他', description: "音楽療法\n和太鼓奏法など", image: 'https://recreation.sandbox.everyplus.jp/images/category/musuc.webp' },
    ]
  end
end
