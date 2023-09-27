import Swiper, { Navigation, Pagination } from 'swiper';

Swiper.use([Navigation, Pagination]);

const useSwiper = () => {
  new Swiper('.swiper', {
    loop: true,
    slidesPerView: 1,
    breakpoints: {
      576: {
        slidesPerView: 2,
      },
      980: {
        slidesPerView: 3,
      },
      1200: {
        slidesPerView: 4,
      },
    },
    centeredSlides: true,
    spaceBetween: 30,
    grabCursor: true,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
  });
};

$(document).ready(() => {
  useSwiper();
});

document.addEventListener('turbolinks:load', () => {
  useSwiper();
});
