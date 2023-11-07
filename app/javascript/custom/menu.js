// Menu manipulation

// Add toggle listener.
function addToggleListenetr(selected_id, menu_id, toggle_class) {
  let selected_element = document.querySelector(`#${selected_id}`);
  // console.log('selected_element', selected_element);
  if (!selected_element) return;

  selected_element.addEventListener('click', function(event) {
    event.preventDefault();
    let menu = document.querySelector(`#${menu_id}`);
    menu.classList.toggle(toggle_class);
  });
}

// Add toggle listeners to listen for clicks.
document.addEventListener('turbo:load', function() {
  addToggleListenetr('hamburger', 'navbar-menu', 'collapse');
  addToggleListenetr('account', 'dropdown-menu', 'active');
});
