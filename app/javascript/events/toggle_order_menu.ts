import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('.order_menu').on('click', (event) => {
      event.stopPropagation();

      const orderMenuContainer = $(event.currentTarget).closest(
        '.order_menu_container'
      );
      const orderId = orderMenuContainer.attr('id')?.replace('order-menu-', '');

      if (!orderId) {
        throw new Error('Order ID is not found');
        return;
      }

      const orderMenuModal = $(`#order-menu-modal-${orderId}`);

      // 表示されているかどうかを確認してトグルする
      if (orderMenuModal.is(':visible')) {
        orderMenuModal.fadeOut();
      } else {
        // すべての order-menu-modal を非表示にする
        $('.order-menu-modal').fadeOut();

        // クリックされた order-menu-modal を表示する
        orderMenuModal.fadeIn();
      }
    });

    // モーダル外をクリックしたらモーダルを非表示にする
    $(document).on('click', (event) => {
      if (
        !$(event.target).closest('.order-menu-modal').length &&
        !$(event.target).closest('.order_menu').length
      ) {
        $('.order-menu-modal').fadeOut();
      }
    });
  });
})();
