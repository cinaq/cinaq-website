const body = document.querySelector('body');
const menuTrigger = document.querySelector('#toggle-main-menu-mobile');
const menuContainer = document.querySelector('#main-menu-mobile');
const hamburgerIcon = document.querySelector('.hamburger');

if (menuTrigger) {
  menuTrigger.onclick = function () {
    menuContainer.classList.toggle('open');
    hamburgerIcon.classList.toggle('is-active');
    body.classList.toggle('lock-scroll');
  };
}
